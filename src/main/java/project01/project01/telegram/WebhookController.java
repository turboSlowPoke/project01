package project01.project01.telegram;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import project01.project01.db_services.SignalRepository;
import project01.project01.db_services.TrainingGroupRepository;
import project01.project01.db_services.UserRepository;
import project01.project01.entyties.*;
import project01.project01.enums.Global;
import project01.project01.exceptions.DublicateUsersInDb;
import project01.project01.exceptions.NoUserInDbException;
import project01.project01.enums.PaidServices;
import project01.project01.telegram.commands.MainCommand;
import project01.project01.telegram.rx_objects.CallbackQuery;
import project01.project01.telegram.tx_objects.*;
import project01.project01.telegram.rx_objects.Message;
import project01.project01.telegram.rx_objects.Update;

import javax.annotation.PostConstruct;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@RestController
public class WebhookController {
    private static final Logger log = LoggerFactory.getLogger(WebhookController.class);
    private final UserRepository userRepository;
    private final SignalRepository signalRepository;
    private final TrainingGroupRepository trainingRepository;
    private final String botURL ="https://api.telegram.org/bot376651530:AAH-aBiEkS_tezghZxNLTEi1ypnuXdbl-5M";

    public WebhookController(UserRepository userRepository, SignalRepository signalRepository, TrainingGroupRepository trainingRepository) {
        this.userRepository = userRepository;
        this.signalRepository = signalRepository;
        this.trainingRepository = trainingRepository;

    }

    @RequestMapping("/mybot")
    public ResponseForTelegram getUpdate(@RequestBody  Update update) throws DublicateUsersInDb {
        System.out.println("recive update");
        if (update.getCallbackQuery()!=null){
             return contextCallBackQuery(update.getCallbackQuery());
        }
        else {
            SendMessage botMessage = null;
            Message userMessage = update.getMessage();
            Integer chatId = userMessage.getChat().getId();
            System.out.println("search user....");
            List<User> users = userRepository.findUserByTelegramChatId(chatId);
            User user = null;
            if (users!=null&&!users.isEmpty())
                 user = users.get(0);
            System.out.println(user);
            if (user==null){
                botMessage = startContext(userMessage);
            }else {
                botMessage = mainContext(user, userMessage);
            }
            if (botMessage!=null)
             sendMessage(botMessage);
          //  return botMessage;
        }
        return null;
    }

    private EditMessageText contextCallBackQuery(CallbackQuery callbackQuery) {
        String id = callbackQuery.getId();
        String data = callbackQuery.getData();
        Integer chatId = callbackQuery.getMessage().getChat().getId();
        if (data.equals("Обновить username")){
            List<User> users = userRepository.findUserByTelegramChatId(chatId);
            if (!users.isEmpty()){
                User user = users.get(0);
                user.getUserData().setTelegramNikcName("@"+callbackQuery.getMessage().getChat().getUserName());
                if (!user.getUserData().getTelegramNikcName().equals("@null")){
                    userRepository.save(user);
                    log.info("обновлен @telgranusername "+user);
                    EditMessageText editMessageText = new EditMessageText(callbackQuery.getInlineMessageId(),"Ваш username "+user.getUserData().getTelegramNikcName()+" сохранён");
                    sendEditMessageText(editMessageText);
                   // return editMessageText;
                }else {
                    EditMessageText editMessageText = new EditMessageText(callbackQuery.getInlineMessageId(),"Сначала настройте username");
                    editMessageText.setReplyMarkup(createUpdateBottom());
                    sendEditMessageText(editMessageText);
                   // return editMessageText;
                }
            }

        }
        return null;
    }

    private void sendEditMessageText(EditMessageText editMessageText) {
        RestTemplate restTemplate = new RestTemplate();
        restTemplate.postForObject(botURL+"/editMessageText", editMessageText,EditMessageText.class);
    }

    private SendMessage mainContext(User user, Message userMessage) {
        MainCommand command = MainCommand.getTYPE(userMessage.getText());
        SendMessage botMessage = new SendMessage(userMessage.getChat().getId(),"Неизвестная команда");
        switch (command){
            case SIGNALS:
                if (user.getSubsribe()!=null&&
                        user.getSubsribe().getEndOfSignal()!=null&&
                        user.getSubsribe().getEndOfSignal().isAfter(LocalDate.now())){
                    List<Signal> signals = signalRepository.findSignalByDateTimeAfter(LocalDateTime.now().minusDays(7));
                    if (signals!=null&&signals.size()>0){
                        String stringWithSignals ="";
                        for (Signal signal: signals){
                            stringWithSignals=stringWithSignals+
                                    signal.getDateTime().toLocalDate().toString()+"\n "+
                                    signal.getHeader()+"\n "+
                                    signal.getBody()+"\n ";
                        }
                        botMessage.setText(stringWithSignals);
                    }
                }else {
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
                if (referal!=null){
                    textMessage=textMessage+"Количество ваших рефералов = "+referal.getNumberOfReferals()+"\n"
                            +"Количесвто оплат ваших рефералов="+referal.getNumerOfReferalsPayments()+"\n";
                }else {
                    textMessage = "У вас нет рефералов.\n ";
                }
                textMessage=textMessage+"Чтобы пригласить реферала, отправьте ему эту <a href=\""+Global.BOT_LINK.getText()+"?start="+user.getId()+"\">ссылку</a>\n";
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
            case ACCAUNT:
                break;
            case START:
                botMessage.setText("Главное меню:");
                botMessage.setReplyMarkup(createMainKeyBoard());
                break;
        }
        return botMessage;
    }

    private InlineKeyboardMarkup createSubsribtionMenu(User user) {
        List<List<InlineKeyboardButton>> lines = new ArrayList<>();
        List<InlineKeyboardButton> line1 = new ArrayList<>();
        line1.add(new InlineKeyboardButton(Global.SIGNALS01.getText(),"https://93.170.123.172/pay?userId="+user.getId()+"&service="+PaidServices.SIGNALS01.getText()));
        line1.add(new InlineKeyboardButton(Global.SIGNALS02.getText(),"https://93.170.123.172/pay?userId="+user.getId()+"&service="+PaidServices.SIGNALS02.getText()));
        line1.add(new InlineKeyboardButton(Global.SIGNALS03.getText(),"https://93.170.123.172/pay?userId="+user.getId()+"&service="+PaidServices.SIGNALS03.getText()));
        List<InlineKeyboardButton> line2 = new ArrayList<>();
        line2.add(new InlineKeyboardButton(Global.TRAINING01.getText(),"https://93.170.123.172/pay?userId="+user.getId()+"&service="+PaidServices.TRAINING01.getText()));
        line2.add(new InlineKeyboardButton(Global.TRAINING02.getText(),"https://93.170.123.172/pay?userId="+user.getId()+"&service="+PaidServices.TRAINING02.getText()));
        line2.add(new InlineKeyboardButton(Global.TRAINING03.getText(),"https://93.170.123.172/pay?userId="+user.getId()+"&service="+PaidServices.TRAINING03.getText()));
        lines.add(line1);
        lines.add(line2);
        return new InlineKeyboardMarkup(lines);
    }

    private SendMessage startContext(Message userMessage) {
        SendMessage answer = new SendMessage(userMessage.getChat().getId(),"");
        answer.setReplyMarkup(createMainKeyBoard());
        answer.setParseMode("HTML");
        String text = userMessage.getText();
        if (text.equals("/start")) {
            User user = new User(userMessage.getChat().getId());
            UserData userData = new UserData();
            userData.setFirstName(getValidPartName(userMessage.getChat().getFirstName()));
            userData.setLastName(getValidPartName(userMessage.getChat().getLastName()));
            userData.setTelegramNikcName("@"+userMessage.getChat().getUserName());
            user.setUserData(userData);
            userRepository.save(user);
            log.info("В базу добавлен новый root пользователь "+ user);
            answer.setText("<b>Добро пожаловать!</b>");
            if (user.getUserData().getTelegramNikcName().equals("@null")){
                System.out.println("send answer1...");
                sendMessage(answer);
                answer.setText("<b>Внимание!</b> Для взаимодействия с вами при обучении, нам нужен ваш <b>@username</b>, пожалуйста заполните его (Настройки -> Имя пользователя / Settings->Username), затем нажмите в чате кнопку обновить");
                answer.setReplyMarkup(createUpdateBottom());
            }
        }else if(text.startsWith("/start")){
            User user = new User(userMessage.getChat().getId());
            UserData userData = new UserData();
            userData.setFirstName(getValidPartName(userMessage.getChat().getFirstName()));
            userData.setLastName(getValidPartName(userMessage.getChat().getLastName()));
            userData.setTelegramNikcName("@"+userMessage.getChat().getUserName());
            user.setUserData(userData);
            try {
                Integer parenUserId = Integer.parseInt(text.substring(7));
                User parentUser = userRepository.findUserById(parenUserId).get(0);
                if (parentUser==null)
                    throw new NoUserInDbException();
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

            if (user.getUserData().getTelegramNikcName().equals("@null")){
                sendMessage(answer);
                answer.setText("<b>Внимание!</b> Для взаимодействия с вами при обучении, нам нужен ваш <b>@username</b>, пожалуйста заполните его (Настройки -> Имя пользователя / Settings->Username), затем нажмите в чате кнопку обновить");
                answer.setReplyMarkup(createUpdateBottom());
            }
        }
        else {
            answer = new SendMessage(userMessage.getChat().getId(),"Ошибка: Вас нет в базе. Нажмите /start");
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
        buttonList.add(line1);
        buttonList.add(line2);
        return new ReplyKeyboardMarkup(buttonList);
    }

    private void sendMessage(SendMessage sendMessage) {
        RestTemplate restTemplate = new RestTemplate();
        System.out.println("rest zapros");
        restTemplate.postForObject(botURL+"/sendMessage", sendMessage,SendMessage.class);
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
