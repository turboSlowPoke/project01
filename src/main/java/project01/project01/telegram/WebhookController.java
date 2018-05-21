package project01.project01.telegram;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import project01.project01.db_services.SignalRepository;
import project01.project01.db_services.TrainingGroupRepository;
import project01.project01.db_services.UserDataRepository;
import project01.project01.db_services.UserRepository;
import project01.project01.entyties.*;
import project01.project01.enums.Global;
import project01.project01.exceptions.DublicateUsersInDb;
import project01.project01.enums.Purchase;
import project01.project01.telegram.commands.MainCommand;
import project01.project01.telegram.rx_objects.CallbackQuery;
import project01.project01.telegram.tx_objects.*;
import project01.project01.telegram.rx_objects.Message;
import project01.project01.telegram.rx_objects.Update;

import javax.annotation.PostConstruct;
import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@RestController
public class WebhookController {
    private static final Logger log = LoggerFactory.getLogger(WebhookController.class);
    private final UserRepository userRepository;
    private final SignalRepository signalRepository;
    private final TrainingGroupRepository trainingRepository;
    @Autowired
    private  UserDataRepository userDataRepository;
    private final String botURL ="https://api.telegram.org/bot376651530:AAH-aBiEkS_tezghZxNLTEi1ypnuXdbl-5M";

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
        restTemplate.postForObject(Global.BOT_URL.getText()+"/editMessageText", editMessageText,EditMessageText.class);
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
                    tempUser.getUserData().setTelegramNikcName(user.getUserData().getTelegramNikcName());
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
                        botMessage.setText("Здесь будут отображаться актуальные сигналы. Вам нужно оформить подписку.");
                    }
                    break;
                case TRAINING:
                    //если есть подписка на обучение, обучение активно
//                if (user.getSubsribe()!=null&&
//                        user.getSubsribe().getTraining()!=null&&
//                        user.getSubsribe().getTraining().getActive()){
//                    List<Webinar> webinars = user.getSubsribe().getTraining().getWebinars();
//                    String webinarString="дата и место вебинара пока не определены";
//                    if (webinars!=null&&!webinars.isEmpty()) {
//                        for (Webinar webinar : webinars) {
//                            if (webinar.getDateTime().isAfter(LocalDateTime.now())) {
//                                webinarString = webinar.getName() + " начнется " + webinar.getDateTime();
//                                if (webinar.getUrlWebinarRoom() != null && !webinar.getUrlWebinarRoom().isEmpty())
//                                    webinarString = webinarString + ", <a href=\"" + webinar.getUrlWebinarRoom() + "\">ссылка на вебинар</a>";
//                            }
//                        }
//                    }
//                    botMessage.setText("Ближайший вебинар: "+webinarString);
//
//                }else {
//                    botMessage.setText("Здесь будут отображаться приглашения на вебинар. Вам нужно оформить подписку.");
//                }
                    botMessage.setText("Здесь будут отображаться приглашения на вебинар");
                    break;
                case REFERALS_PROG:
                    String textMessage = "";
                    Referal referal = user.getReferal();
                    if (referal != null) {
                        textMessage = textMessage + "Количество ваших рефералов = " + referal.getNumberOfReferals() + "\n"
                                + "Количесвто оплат ваших рефералов=" + referal.getNumerOfReferalsPayments() + "\n";
                    } else {
                        textMessage = "У вас нет рефералов.\n ";
                    }
                    textMessage = textMessage + "Чтобы пригласить реферала, отправьте ему эту <a href=\"" + Global.BOT_LINK.getText() + "?start=" + user.getId() + "\">ссылку</a>\n";
                    botMessage.setText(textMessage);
                    botMessage.setParseMode("HTML");
                    break;
                case SUBSCRIPTIONS:
//                Subscribe subscribe = user.getSubsribe();
//                String signalsString;
//                String trainingString;
//                String resultString;
//                if (subscribe!=null&&subscribe.getEndOfSignal()!=null&&subscribe.getEndOfSignal().isAfter(LocalDate.now())) {
//                    signalsString = "Подписка на сигналы активна до " + subscribe.getEndOfSignal() + "\n";
//                }else {
//                    signalsString="Подписка на сигналы не активна\n";
//                }
//                if (subscribe!=null&&subscribe.getTraining()!=null&&subscribe.getTraining().getEndTraining().isAfter(LocalDate.now())){
//                    trainingString="Дата начала курса "+subscribe.getTraining().getStartTraining()+"\n"
//                            +"Дата конца курса "+subscribe.getTraining().getEndTraining();
//                }else {
//                    trainingString="Подписка на обучение не активна\n";
//                }
//                resultString=signalsString+trainingString+"Купить подписку:\n";
//                botMessage.setText(resultString);
                    botMessage.setText("Подписки");
                    botMessage.setReplyMarkup(createSubsribtionMenu(user));
                    break;
                case PRIVATE_PAGE:
                    System.out.println("Вызвано меню личный кабинет");
                    String privatePageText = "";
                    if (user.getGoogleId() == null && user.getPassword() == null) {
                        privatePageText = "<b>К боту не привязан линый web-кабинет!</b>\n";
                        privatePageText = privatePageText + "Устанновить логин: отправьте /login <i>ваш логин</i>\n";
                        privatePageText = privatePageText + "Установить пароль: отправьте /pass <i>ваш пароль</i>\n";
                        privatePageText = privatePageText + "Доступна авторизация через <b>Google</b> аккаунт\n";
                        privatePageText = privatePageText + "Перейти на сайт в личный кабинет нужно по этой " +
                                "<a href=\"" + Global.WEBSITE_LINK.getText() + "/?uh=" + user.getHash() + "\">ссылке</a>";
                    } else {
                        privatePageText = "<b>Перейти на сайт в личный кабинет нужно по этой</b> " +
                                "<a href=\"" + Global.WEBSITE_LINK.getText() + "/?uh=" + user.getHash() + "\">ссылке</a>\n";
                        if (user.getLogin() != null)
                            privatePageText = privatePageText + "Ваш логин " + user.getLogin() + "\n";
                        if (user.getPassword() == null)
                            privatePageText = privatePageText + "Пароль не установлен." + "\n";
                        privatePageText = privatePageText + "Устанновить логин: отправьте /login <i>ваш логин</i>\n" +
                                "Установить пароль: отправьте /pass <i>ваш пароль</i>\n";
                    }
                    botMessage.setText(privatePageText);
                    botMessage.setParseMode("HTML");
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
        line2.add(new InlineKeyboardButton(Purchase.TRAINING01.getText(),"https://93.170.123.172/pay?userId="+user.getId()+"&service="+Purchase.TRAINING01.getText()));
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
            user = createNewUser(incomingMessage);
            log.info("В базу добавлен новый root пользователь");
        }else if(text.startsWith("/start ref")){
            user = createNewUser(incomingMessage);
            try {
                Integer parenUserId = Integer.parseInt(text.substring(10));
                List<User> users = userRepository.findUserById(parenUserId);
                if (users==null||users.isEmpty())
                    throw new Exception();
                User parentUser= users.get(0);
                parentUser.getReferal().plusOneReferal();
                userRepository.save(parentUser);
                log.info("Юзеру добавлен реферал "+parentUser);
                user.setReferal(new Referal(parenUserId));
                userRepository.save(user);
                log.info("Сохранён приглашенный пользователь");
                sendMessage(new SendMessage(parentUser.getTelegramChatId(),"У вас добавился реферал: "+user.getUserData().getFirstName() + ", @"+user.getUserData().getTelegramNikcName()));
                answer.setText("<b>Добро пожаловать</b>");
            } catch (Exception e) {
                log.error("Зашел юзер по кривой реф ссылке");
                userRepository.save(user);
                answer.setText("<b>Добро пожаловать!</b>\n <b>Внимание</b>, в  ссылке, по которой вы перешли, ошибка в id пригласителя.");
            }
        }else if (text.startsWith("/start ")&&text.substring(7).length()==64){// /start=123456789,,,
            List<User> users = userRepository.findUserByHash(text.substring(7));
            if (users!=null&&!users.isEmpty()){
                user = users.get(0);
                user.setTelegramChatId(incomingMessage.getChat().getId());
                user.getUserData().setTelegramNikcName("@"+incomingMessage.getChat().getUserName());
                if (user.getUserData().getFirstName()==null)
                    user.getUserData().setFirstName(getValidPartName(incomingMessage.getChat().getFirstName()));
                if (user.getUserData().getLastName()==null)
                    user.getUserData().setLastName(getValidPartName(incomingMessage.getChat().getLastName()));
                userRepository.save(user);
                userDataRepository.save(user.getUserData());
                log.info("Юзеру выполнена привязка телеграм "+user);
            }else{
                log.warn("Юзер перешел по кривой ссылке из личного кабинета: " +text);
                System.out.println("Юзер перешел по кривой ссылке из личного кабинета: " +text);
                answer.setText("<<b>Вниманией!</b> В ссылке по которой вы перешли ошибка, бот не может привязать вашу учетку в telegram к личному кабинету");
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

    private User createNewUser(Message incomingMessage) {
        UserData userData = new UserData();
        userData.setFirstName(getValidPartName(incomingMessage.getChat().getFirstName()));
        userData.setLastName(getValidPartName(incomingMessage.getChat().getLastName()));
        userData.setTelegramNikcName("@"+incomingMessage.getChat().getUserName());
        User user = new User();
        user.setStartDate(LocalDateTime.now());
        user.setTelegramChatId(incomingMessage.getChat().getId());
        user.setRoles(new HashSet<Role>(Arrays.asList(new Role())));
        user.setLogin(incomingMessage.getChat().getUserName());
        userRepository.save(user);
        String stringForHash = user.getId().toString()+user.getStartDate().toString()+Global.COD_WORD;
        MessageDigest md = null;
        try {
            md = MessageDigest.getInstance("SHA-256");
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        md.update(stringForHash.getBytes(StandardCharsets.UTF_8));
        byte[] digest = md.digest();
        String hash = String.format("%064x", new BigInteger( 1, digest ) );
        user.setHash(hash);
        userRepository.save(user);
        log.info("Сохранён новый юзер: "+user);
        return user;
    }

    private InlineKeyboardMarkup createUpdateBottom() {
        List<List<InlineKeyboardButton>> lines = new ArrayList<>();
        List<InlineKeyboardButton> line1 = new ArrayList<>();
        line1.add(new InlineKeyboardButton("Обновить username"));
        lines.add(line1);
        return new InlineKeyboardMarkup(lines);
    }

    private String getValidPartName(String name) {
        String validName="-";
        String p = "([\\w]|.)*";
        Pattern pattern = Pattern.compile(p,Pattern.UNICODE_CHARACTER_CLASS);
        if (name!=null) {
            try {
                Matcher matcher = pattern.matcher(name);
                if (matcher.matches()) {
                    validName = name;
                }
            } catch (Exception e) {
                log.info("Не прошло проверку имя "+name);
            }
        }
        return validName;
    }

    private KeyboardMarkup createMainKeyBoard() {
        List<List<KeyboardButton>> buttonList = new ArrayList<>();
        List<KeyboardButton> line1 = new ArrayList<>();
        line1.add(new KeyboardButton(MainCommand.SIGNALS.getText()));
        line1.add(new KeyboardButton(MainCommand.TRAINING.getText()));
        List<KeyboardButton> line2 = new ArrayList<>();
        line2.add(new KeyboardButton(MainCommand.REFERALS_PROG.getText()));
        line2.add(new KeyboardButton(MainCommand.SUBSCRIPTIONS.getText()));
        List<KeyboardButton> line3 = new ArrayList<>();
        line3.add(new KeyboardButton(MainCommand.PRIVATE_PAGE.getText()));
        buttonList.add(line1);
        buttonList.add(line2);
        buttonList.add(line3);
        return new ReplyKeyboardMarkup(buttonList);
    }

    private void sendMessage(SendMessage sendMessage) {
        RestTemplate restTemplate = new RestTemplate();
        System.out.println("/sendMessage...");
        restTemplate.postForObject(Global.BOT_URL.getText()+"/sendMessage", sendMessage,SendMessage.class);
    }

    @PostConstruct
    public void init(){
        signalRepository.save(new Signal("signal-1","body-1",LocalDateTime.now().minusDays(4)));
        signalRepository.save(new Signal("signal-2","body2",LocalDateTime.now().minusDays(3)));
//        trainingRepository.save(new Training(LocalDateTime.now().plusDays(2),"webinar 1","www.lalal"));
//        trainingRepository.save(new Training(LocalDateTime.now().plusDays(5),"webinar 2","www.lalal"));
//        System.out.println("PostConstruct start");
//        LinkedMultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
//        FileSystemResource value = new FileSystemResource(new File("./public_cert.pem"));
//        map.add("certificate", value);
//        map.add("url","https://93.170.123.172:443/mybot");
//        HttpHeaders headers = new HttpHeaders();
//        headers.setContentType(MediaType.MULTIPART_FORM_DATA);
//        HttpEntity<LinkedMultiValueMap<String, Object>> requestEntity = new HttpEntity<>(map, headers);
//        RestTemplate restTemplate = new RestTemplate();
//        restTemplate.exchange("https://api.telegram.org/bot376651530:AAH-aBiEkS_tezghZxNLTEi1ypnuXdbl-5M/setWebhook", HttpMethod.POST, requestEntity, String.class);
//        System.out.println("setwebhook");
    }
}
