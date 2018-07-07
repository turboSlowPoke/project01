package project01.project01.telegram;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import project01.project01.config.GlobalConfig;
import project01.project01.db_services.*;
import project01.project01.entyties.*;
import project01.project01.exceptions.DublicateUsersInDb;
import project01.project01.enums.Purchase;
import project01.project01.exceptions.NoUserInDbException;
import project01.project01.services.UserService;
import project01.project01.telegram.commands.MainCommand;
import project01.project01.telegram.rx_objects.CallbackQuery;
import project01.project01.telegram.tx_objects.*;
import project01.project01.telegram.rx_objects.Message;
import project01.project01.telegram.rx_objects.Update;

import javax.annotation.PostConstruct;
import java.io.File;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.*;

@RestController
public class WebhookController {
    private static final Logger log = LoggerFactory.getLogger(WebhookController.class);
    private final UserRepository userRepository;
    private final SignalRepository signalRepository;
    private final TrainingGroupRepository trainingRepository;
    @Autowired
    private  UserDataRepository userDataRepository;
    @Autowired
    private OrderRepository orderRepository;
    @Autowired
    private UserService userService;
    public WebhookController(UserRepository userRepository, SignalRepository signalRepository, TrainingGroupRepository trainingRepository) {
        this.userRepository = userRepository;
        this.signalRepository = signalRepository;
        this.trainingRepository = trainingRepository;

    }

    @RequestMapping("/mybot")
    public ResponseForTelegram getUpdate(@RequestBody  Update update) throws DublicateUsersInDb {
        //System.out.println("recive update " + update.getMessage().getText());
        if (update.getCallbackQuery()!=null){
              contextCallBackQuery(update.getCallbackQuery());
        }
        else {
            SendMessage botMessage = null;
            Message userMessage = update.getMessage();
            Integer chatId = userMessage.getChat().getId();
            List<User> users = userRepository.findUserByTelegramChatId(chatId);
            User user = null;
            if (users!=null&&!users.isEmpty())
                 user = users.get(0);
            if (user==null){
                botMessage = startContext(userMessage);
            }else {
                botMessage = mainContext(user, userMessage);
            }
            if (botMessage!=null)
             sendMessage(botMessage);
            //return botMessage;
        }
        return null;
    }

    private EditMessageText contextCallBackQuery(CallbackQuery callbackQuery) {
        System.out.println("CallBackContext");
        String id = callbackQuery.getId();
        String data = callbackQuery.getData();
        Integer chatId = callbackQuery.getMessage().getChat().getId();
        if (data.equals("Обновить username")){
            System.out.println("search user...");
            List<User> users = userRepository.findUserByTelegramChatId(chatId);
            if (users!=null&&!users.isEmpty()){
                User user = users.get(0);
                user.getUserData().setTelegramNikcName("@"+callbackQuery.getMessage().getChat().getUserName());
                if (!user.getUserData().getTelegramNikcName().equals("@null")){
                    userRepository.save(user);
                    log.info("обновлен @telgranusername "+user);
                    System.out.println("updated @telgranusername "+user);
                    EditMessageText editMessageText = new EditMessageText(callbackQuery.getMessage().getChat().getId(),
                            callbackQuery.getMessage().getId(),
                            "Ваш username "+user.getUserData().getTelegramNikcName()+" сохранён");
                    System.out.println("sending endMessage good username....");
                    sendEditMessageText(editMessageText);
                   // return editMessageText;
                }else {
                    EditMessageText editMessageText = new EditMessageText(callbackQuery.getMessage().getChat().getId(),
                            callbackQuery.getMessage().getId(),
                            "Сначала настройте username");
                    editMessageText.setReplyMarkup(createUpdateBottom());
                    System.out.println("sending message bad username...");
                    sendEditMessageText(editMessageText);
                   // return editMessageText;
                }
            }

        }
        return null;
    }

    private void sendEditMessageText(EditMessageText editMessageText) {
        RestTemplate restTemplate = new RestTemplate();
        restTemplate.postForObject(GlobalConfig.BOT_API_URL+"/editMessageText", editMessageText,EditMessageText.class);
    }

    private SendMessage mainContext(User user, Message userMessage) {
        String text = userMessage.getText();
        SendMessage botMessage = new SendMessage(userMessage.getChat().getId(),"Неизвестная команда");
        if (userMessage.getText().startsWith("/start ")&&text.substring(7).length()==64){
            System.out.println("Обновление юзера");
            List<User> users = userRepository.findUserByHash(text.substring(7));
            if (users!=null&&!users.isEmpty()){
                User tempUser = users.get(0);
                if (!tempUser.getHash().equals(user.getHash())
                        &&tempUser.getTelegramChatId()==null){
                    System.out.println("Удаляем пользователя "+user);
                    userRepository.delete(user);
                    System.out.println("Удален");
                    System.out.println("Обновляем пользователя... "+tempUser);
                    tempUser.setTelegramChatId(user.getTelegramChatId());
                    if (user.getPassword()!=null){
                        System.out.println("Обновляем пароль и логин...");
                        tempUser.setPassword(user.getPassword());
                        tempUser.setLogin(user.getLogin());
                    }
                    tempUser.getUserData().setTelegramNikcName("@"+userMessage.getChat().getUserName());
                    System.out.println("Обновлён");
                    System.out.println("Сохраняем пользоватлея " +tempUser);
                    userRepository.save(tempUser);
                    userDataRepository.save(tempUser.getUserData());
                    System.out.println("Сохранён");
                    log.info("Обновлен юзер " +tempUser);
                    botMessage.setText("Ваши данные были обновлены");
                }else {
                    botMessage=null;
                }
            }
        } else {
            MainCommand command = MainCommand.getTYPE(text);
            switch (command) {
                case SIGNALS:
                    if (user.getSubsribe() != null &&
                            user.getSubsribe().getEndOfSignal() != null &&
                            user.getSubsribe().getEndOfSignal().isAfter(LocalDate.now())) {
                        List<Signal> signals = signalRepository.findSignalByDateTimeAfter(LocalDateTime.now().minusDays(7));
                        if (signals != null && signals.size() > 0) {
                            String stringWithSignals = "";
                            for (Signal signal : signals) {
                                stringWithSignals = stringWithSignals +
                                        signal.getDateTime().toLocalDate().toString() + "\n " +
                                        signal.getHeader() + "\n " +
                                        signal.getBody() + "\n ";
                            }
                            botMessage.setText(stringWithSignals);
                        }
                    } else {
                        botMessage.setText("Здесь будут отображаться актуальные сигналы. Вам нужно оформить подписку в <a href=\""+GlobalConfig.siteUrl + "/?uh=" + user.getHash()+"\">личном кабинете</a>.");
                        botMessage.setParseMode("HTML");
                    }
                    break;
                case TRAINING:
                    String trainingText="";
                    if (user.getTrainingGroups()!=null&&!user.getTrainingGroups().isEmpty()){
                        TrainingGroup trainingGroup = user.getTrainingGroups().get(0);
                        trainingText = "Вы записаны на курс \""+trainingGroup.getCourse().getName()+"\"\n.";
                        if (trainingGroup.getWebinars()!=null&&!trainingGroup.getWebinars().isEmpty()){
                            trainingText = trainingText+"Предстоящие вебинары:\n";
                            for (Webinar webinar : trainingGroup.getWebinars()){
                                if (webinar.getDateTime()!=null&&webinar.getDateTime().isAfter(LocalDateTime.now().minusHours(2))) {
                                    trainingText=trainingText+"Вебинар: "+webinar.getName()+
                                            ", время начала: "+webinar.getDateTime();
                                    if (webinar.getUrlWebinarRoom()==null){
                                        trainingText=trainingText+"\n";
                                    }else {
                                        trainingText=trainingText+", ссылка на комнату: "+webinar.getUrlWebinarRoom()+"\n";
                                    }
                                }
                            }
                        }
                    }else {
                        trainingText="Запишитесь на курс на сайте, в <a href=\""+GlobalConfig.siteUrl + "/?uh=" + user.getHash()+"\">личном кабинете</a>.";
                    }
                    botMessage.setText(trainingText);
                    botMessage.setParseMode("HTML");
                    break;
                case REFERALS_PROG:
                    String textMessage = "";
                    Long allReferals = userRepository.countByInvitedId(user.getId());
                    BigDecimal amountReferalsPayment = orderRepository.amountReferalPayment(user.getId());
                    if (amountReferalsPayment==null)
                        amountReferalsPayment=new BigDecimal("0.0");
                    BigDecimal usdBonus = new BigDecimal("0.0");
                    if (user.getBonusWallet()!=null&&user.getBonusWallet().getUsdBonus()!=null)
                        usdBonus=user.getBonusWallet().getUsdBonus();
                    textMessage = textMessage + "Количество ваших рефералов = " +  allReferals+ "\n"+
                                "Произведено оплат на сумму ="+amountReferalsPayment + "$\n"+
                                "Вам начислено "+usdBonus+"$\n";
                    textMessage = textMessage + "Чтобы пригласить реферала, отправьте ему эту <a href=\"" + GlobalConfig.BOT_LINK + "?start=" + user.getId() + "\">ссылку</a>\n";
                    botMessage.setText(textMessage);
                    botMessage.setParseMode("HTML");
                    break;
                case SUBSCRIPTIONS:
                    botMessage.setText("Подписки");
                    botMessage.setReplyMarkup(createSubsribtionMenu(user));
                    break;
                case PRIVATE_PAGE:
                    System.out.println("Вызвано меню личный кабинет");
                    String privatePageText = "";
                    if (user.getGoogleId() == null && user.getPassword() == null) {
                        privatePageText = "<b>К боту не привязан линый web-кабинет!</b>\n";
                        privatePageText = privatePageText + "Устанновить логин, отправьте\n /login <i>ваш логин</i>\n";
                        privatePageText = privatePageText + "Установить пароль, отправьте\n /pass <i>ваш пароль</i>\n";
                        privatePageText = privatePageText + "Доступна авторизация через <b>Google</b> аккаунт\n";
                        privatePageText = privatePageText + "Перейти на сайт в личный кабинет нужно по этой " +
                                "<a href=\"" + GlobalConfig.siteUrl + "/?uh=" + user.getHash() + "\">ссылке</a>\n\n";
                    } else {
                        privatePageText = "<b>Перейти на сайт в личный кабинет нужно по этой</b> " +
                                "<a href=\"" + GlobalConfig.siteUrl + "/?uh=" + user.getHash() + "\">ссылке</a>\n\n";
                        if (user.getLogin() != null)
                            privatePageText = privatePageText + "Ваш логин " + user.getLogin() + "\n";
                        if (user.getPassword() == null)
                            privatePageText = privatePageText + "Пароль не установлен." + "\n";
                        privatePageText = privatePageText + "Чтобы устанновить логин, отправьте \n /login <i>ваш логин</i>\n" +
                                "Чтобы установить пароль, отправьте \n /pass <i>ваш пароль</i>\n";
                    }
                   // privatePageText=privatePageText+"\nДля взаимодействия с вами , нам нужен ваш <b>@username</b>, пожалуйста заполните его (Настройки -> Имя пользователя / Settings->Username), затем нажмите в чате кнопку обновить";
                    botMessage.setText(privatePageText);
                    botMessage.setParseMode("HTML");
                    sendMessage(botMessage);
                    if (user.getUserData().getTelegramNikcName()==null||user.getUserData().getTelegramNikcName().equals("@null")){
                        privatePageText = "Ваш телеграм @username <b>не настроен</b>\n";
                    }else {
                        privatePageText= "Ваш телеграм @username = <b>"+user.getUserData().getTelegramNikcName()+"</b>\n";
                    }
                    botMessage.setText(privatePageText+"\nЧтобы изменить или установить ваш телеграм @username, заполните его в профиле мессенджера (Настройки -> Имя пользователя / Settings->Username), затем нажмите кнопку обновить");
                    botMessage.setReplyMarkup(createUpdateBottom());
                    break;
                case START:
                    botMessage.setText("Главное меню:");
                    botMessage.setReplyMarkup(createMainKeyBoard());
                    break;
            }
        }

        return botMessage;
    }

    private InlineKeyboardMarkup createSubsribtionMenu(User user) {
        List<List<InlineKeyboardButton>> lines = new ArrayList<>();
        List<InlineKeyboardButton> line1 = new ArrayList<>();
        line1.add(new InlineKeyboardButton(Purchase.SIGNALS01.getText(),"https://93.170.123.172/pay?userId="+user.getId()+"&service="+Purchase.SIGNALS01.getText()));
        line1.add(new InlineKeyboardButton(Purchase.SIGNALS02.getText(),"https://93.170.123.172/pay?userId="+user.getId()+"&service="+Purchase.SIGNALS02.getText()));
        line1.add(new InlineKeyboardButton(Purchase.SIGNALS03.getText(),"https://93.170.123.172/pay?userId="+user.getId()+"&service="+Purchase.SIGNALS03.getText()));
        List<InlineKeyboardButton> line2 = new ArrayList<>();
        line2.add(new InlineKeyboardButton(Purchase.TRAINING.getText(),"https://93.170.123.172/pay?userId="+user.getId()+"&service="+Purchase.TRAINING.getText()));
        lines.add(line1);
        lines.add(line2);
        return new InlineKeyboardMarkup(lines);
    }

    private SendMessage startContext(Message incomingMessage) {
        SendMessage answer = new SendMessage(incomingMessage.getChat().getId(),"");
        answer.setText("<b>Добро пожаловать!</b>");
        answer.setReplyMarkup(createMainKeyBoard());
        answer.setParseMode("HTML");
        String text = incomingMessage.getText();
        User user;
        String t = text.substring(6);
        Integer len = text.substring(6).length();
        if (text.equals("/start")) {
            userService.createNewUser(incomingMessage);
        }else if(text.startsWith("/start ref")){
            try {
                user = userService.createNewUserByInviteLinkForTelegram(incomingMessage);
                String textFoParentUser = "У вас добавился реферал: ";
                if (user.getUserData().getFirstName()!=null){
                    textFoParentUser= textFoParentUser+user.getUserData().getFirstName()+", ";
                }else {
                    textFoParentUser= textFoParentUser+"имя не указано, ";
                }
                if (user.getUserData().getTelegramNikcName()!=null&&!user.getUserData().getTelegramNikcName().equals("@null")){
                    textFoParentUser = textFoParentUser + user.getUserData().getTelegramNikcName()+".\n";
                }else {
                    textFoParentUser = textFoParentUser + "@никнейм не указан.\n";
                }
                sendMessage(new SendMessage(user.getInvitedId(),"У вас добавился реферал: "+user.getUserData().getFirstName() + ", @"+user.getUserData().getTelegramNikcName()));
                answer.setText("<b>Добро пожаловать</b>");
            } catch (NoUserInDbException e) {
                answer.setText("<b>Добро пожаловать!</b>\n <b>Внимание</b>, в  ссылке, по которой вы перешли, ошибка в id пригласителя.");
            }
        }else if (text.startsWith("/start ")&&text.substring(7).length()==64){// /start='hash'
            User userByHash = userService.addTelegramIdToUser(incomingMessage);
            if (userByHash==null){
                answer.setText("<<b>Вниманией!</b> В ссылке по которой вы перешли ошибка, бот не может привязать ваш ID в telegram к личному кабинету");
                answer.setReplyMarkup(null);
            }
        } else {
            answer = new SendMessage(incomingMessage.getChat().getId(),"Ошибка: Вас нет в базе. Нажмите /start");
        }

        if (!answer.getText().equals("Ошибка: Вас нет в базе. Нажмите /start")&&incomingMessage.getChat().getUserName()==null){
            sendMessage(answer);
            answer.setText("<b>Внимание!</b> Для взаимодействия с вами при обучении, нам нужен ваш <b>@username</b>, пожалуйста заполните его (Настройки -> Имя пользователя / Settings->Username), затем нажмите в чате кнопку обновить");
            answer.setReplyMarkup(createUpdateBottom());
        }
        return answer;
    }

    private InlineKeyboardMarkup createUpdateBottom() {
        List<List<InlineKeyboardButton>> lines = new ArrayList<>();
        List<InlineKeyboardButton> line1 = new ArrayList<>();
        line1.add(new InlineKeyboardButton("Обновить username"));
        lines.add(line1);
        return new InlineKeyboardMarkup(lines);
    }

    private KeyboardMarkup createMainKeyBoard() {
        List<List<KeyboardButton>> buttonList = new ArrayList<>();
        List<KeyboardButton> line1 = new ArrayList<>();
        line1.add(new KeyboardButton(MainCommand.SIGNALS.getText()));
        line1.add(new KeyboardButton(MainCommand.TRAINING.getText()));
        List<KeyboardButton> line2 = new ArrayList<>();
        line2.add(new KeyboardButton(MainCommand.REFERALS_PROG.getText()));
        line2.add(new KeyboardButton(MainCommand.PRIVATE_PAGE.getText()));
       // line2.add(new KeyboardButton(MainCommand.SUBSCRIPTIONS.getText()));
       // List<KeyboardButton> line3 = new ArrayList<>();
       // line3.add(new KeyboardButton(MainCommand.PRIVATE_PAGE.getText()));
        buttonList.add(line1);
        buttonList.add(line2);
       // buttonList.add(line3);
        return new ReplyKeyboardMarkup(buttonList);
    }

    private void sendMessage(SendMessage sendMessage) {
        RestTemplate restTemplate = new RestTemplate();
        System.out.println("/sendMessage...");
        restTemplate.postForObject(GlobalConfig.BOT_API_URL+"/sendMessage", sendMessage,SendMessage.class);
    }

    @PostConstruct
    public void init(){

        System.out.println("PostConstruct start");
        LinkedMultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
        map.add("url","https://potvneskazut.ru:443/mybot");
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.MULTIPART_FORM_DATA);
        HttpEntity<LinkedMultiValueMap<String, Object>> requestEntity = new HttpEntity<>(map, headers);
        RestTemplate restTemplate = new RestTemplate();
      //  restTemplate.exchange(GlobalConfig.BOT_API_URL+"/setWebhook", HttpMethod.POST, requestEntity, String.class);
        System.out.println("WebhookIsSet");
    }
}
