package project01.project01.telegram;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import project01.project01.db_services.SignalRepository;
import project01.project01.db_services.TrainingRepository;
import project01.project01.db_services.UserRepository;
import project01.project01.entyties.*;
import project01.project01.exceptions.DublicateUsersInDb;
import project01.project01.exceptions.NoUserInDbException;
import project01.project01.telegram.commands.MainCommand;
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

import static project01.project01.telegram.commands.MainCommand.ACCAUNT;

@RestController
public class WebhookController {
    private static final Logger log = LoggerFactory.getLogger(WebhookController.class);
    private final UserRepository userRepository;
    private final SignalRepository signalRepository;
    private final TrainingRepository trainingRepository;

    public WebhookController(UserRepository userRepository, SignalRepository signalRepository, TrainingRepository trainingRepository) {
        this.userRepository = userRepository;
        this.signalRepository = signalRepository;
        this.trainingRepository = trainingRepository;

    }

    @RequestMapping("/mybot")
    public ResponseForTelegram getUpdate(@RequestBody  Update update) throws DublicateUsersInDb {
        if (update.getCallbackQuery()!=null){
           // CallbackQueryAnswer answer = contextCallBackQuery(update.getCallbackQuery());
           // answerCallbackQuery(answer);
        }
        else {
            SendMessage botMessage = null;
            Message userMessage = update.getMessage();
            Integer chatId = userMessage.getChat().getId();
            List<User> users = userRepository.findUserByTelegramChatId(chatId);
            User user = null;
            if (users != null && users.size()!= 1&&users.size()!=0) {
                throw new DublicateUsersInDb();
            } else if (users != null && users.size() == 1) {
                user = users.get(0);
            }
            if (user==null){
                botMessage = startContext(userMessage);
            }else {
                botMessage = mainContext(user, userMessage);
            }
            /*if (botMessage!=null)
             sendMessage(botMessage);*/
            return botMessage;
        }
        return null;
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
                if (user.getSubsribe()!=null&&
                        user.getSubsribe().getEndOfTraining()!=null&&
                        user.getSubsribe().getEndOfTraining().isAfter(LocalDate.now())){
                    List<Training> trainings = trainingRepository.findTrainingByActive(true);
                    if (trainings!=null&&trainings.size()>0){
                        String stringWithTrainings ="";
                        for (Training training: trainings){
                            stringWithTrainings=stringWithTrainings+
                                    "Время проведения вебинара:"+training.getWebinarDate().toLocalDate().toString()+"\n "+
                                    training.getHeader()+"\n "+
                                    training.getUrlWebinarRoom()+"\n ";
                        }
                        botMessage.setText(stringWithTrainings);
                    }
                }else {
                    botMessage.setText("Здесь будут отображаться приглашения на вебинар. Вам нужно оформить подписку.");
                }
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
                textMessage=textMessage+"Чтобы пригласить реферала, отправьте ему эту <a href=\"https://t.me/tradebeepbot?start="+user.getId()+"\">ссылку</a>\n";
                botMessage.setText(textMessage);
                botMessage.setParseMode("HTML");
                break;
            case SUBSCRIPTIONS:
                Subscribe subscribe = user.getSubsribe();
                String signalsString;
                String trainingString;
                String resultString;
                if (subscribe!=null&&subscribe.getEndOfSignal()!=null&&subscribe.getEndOfSignal().isAfter(LocalDate.now())) {
                    signalsString = "Подписка на сигналы активна до " + subscribe.getEndOfSignal() + "\n";
                }else {
                    signalsString="Подписка на сигналы не активна\n";
                }
                if (subscribe!=null&&subscribe.getEndOfTraining()!=null&&subscribe.getEndOfTraining().isAfter(LocalDate.now())){
                    trainingString="Подписка на обучение активна до "+subscribe.getEndOfTraining()+"\n";
                }else {
                    trainingString="Подписка на обучение не активна\n";
                }
                resultString=signalsString+trainingString+"Купить подписку:\n";
                botMessage.setText(resultString);
                botMessage.setReplyMarkup(createSubsribtionMenu());
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

    private InlineKeyboardMarkup createSubsribtionMenu() {
        //
        return null;
    }

    private SendMessage startContext(Message userMessage) {
        SendMessage answer = new SendMessage(userMessage.getChat().getId(),"");
        answer.setReplyMarkup(createMainKeyBoard());
        String text = userMessage.getText();
        if (text.equals("/start")) {
            User user = new User(userMessage.getChat().getId());
            UserData userData = new UserData();
            userData.setFirstName(getValidPartName(userMessage.getChat().getFirstName()));
            userData.setLastName(getValidPartName(userMessage.getChat().getLastName()));
            user.setUserData(userData);

            Subscribe subsribe = new Subscribe(LocalDate.now().plusMonths(1),LocalDate.now().plusMonths(1));
            user.setSubsribe(subsribe);

            userRepository.save(user);
            log.info("В базу добавлен новый root пользователь "+ user);
            answer.setText("Добро пожаловать!");
        }else if(text.startsWith("/start")){
            User user = new User(userMessage.getChat().getId());
            UserData userData = new UserData();
            userData.setFirstName(getValidPartName(userMessage.getChat().getFirstName()));
            userData.setLastName(getValidPartName(userMessage.getChat().getLastName()));
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
                answer.setText("Добро пожаловать");
            } catch (Exception e) {
                log.error("Зашел юзер по кривой реф ссылке");
                userRepository.save(user);
                answer.setText("Добро пожаловать.\n Внимание, в  ссылке, по которой вы перешли, ошибка в id пригласителя.");
            }
        }
        else {
            answer = new SendMessage(userMessage.getChat().getId(),"Ошибка: Вас нет в базе. Нажмите /start");
        }
        return answer;
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
        restTemplate.postForObject("https://api.telegram.org/bot376651530:AAH-aBiEkS_tezghZxNLTEi1ypnuXdbl-5M/sendMessage", sendMessage,SendMessage.class);
    }

    @PostConstruct
    public void init(){
        signalRepository.save(new Signal("signal-1","body-1",LocalDateTime.now().minusDays(4)));
        signalRepository.save(new Signal("signal-2","body2",LocalDateTime.now().minusDays(3)));
        trainingRepository.save(new Training(LocalDateTime.now().plusDays(2),"webinar 1","www.lalal"));
        trainingRepository.save(new Training(LocalDateTime.now().plusDays(5),"webinar 2","www.lalal"));
    /*    System.out.println("PostConstruct start");
        LinkedMultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
        FileSystemResource value = new FileSystemResource(new File("./public_cert.pem"));
        map.add("certificate", value);
        map.add("url","https://93.170.123.172:443/mybot");
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.MULTIPART_FORM_DATA);
        HttpEntity<LinkedMultiValueMap<String, Object>> requestEntity = new HttpEntity<>(map, headers);
        RestTemplate restTemplate = new RestTemplate();
        restTemplate.exchange("https://api.telegram.org/bot376651530:AAH-aBiEkS_tezghZxNLTEi1ypnuXdbl-5M/setWebhook", HttpMethod.POST, requestEntity, String.class);
        System.out.println("setwebhook");*/
    }
}
