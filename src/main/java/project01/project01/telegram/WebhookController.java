package project01.project01.telegram;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import project01.project01.db_services.UserRepository;
import project01.project01.entyties.User;
import project01.project01.entyties.UserData;
import project01.project01.exceptions.DublicateUsersInDb;
import project01.project01.telegram.bottons.MainCommand;
import project01.project01.telegram.tx_objects.*;
import project01.project01.telegram.rx_objects.Message;
import project01.project01.telegram.rx_objects.Update;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@RestController
public class WebhookController {
    private static  Logger
    final UserRepository userRepository;

    public WebhookController(UserRepository userRepository) {
        this.userRepository = userRepository;
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
            Integer chatId = userMessage.getId();
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
                botMessage = mainContext(userMessage);
            }
            //if (botMessage!=null)
            // sendMessage(botMessage);
            return botMessage;
        }
        return null;
    }

    private SendMessage mainContext(Message userMessage) {
        return null;
    }

    private SendMessage startContext(Message userMessage) {
        SendMessage answer;
        String text = userMessage.getText();
        if (text.equals("/start")) {
            User user = new User(userMessage.getChat().getId());
            UserData userData = new UserData();
            userData.setFirstName(getValidPartName(userMessage.getChat().getFirstName()));
            userData.setLastName(getValidPartName(userMessage.getChat().getLastName()));
            user.setUserData(userData);
            userRepository.save(user);
            answer = new SendMessage(user.getTelegramChatId(), "Добро пожаловать!");
            answer.setReplyMarkup(createMainKeyBoard());
        }else {
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
        return name;
    }

    private KeyboardMarkup createMainKeyBoard() {
        List<List<KeyboardButton>> buttonList = new ArrayList<>();
        List<KeyboardButton> line1 = new ArrayList<>();
        line1.add(new KeyboardButton(MainCommand.BOTTOM011.getText()));
        line1.add(new KeyboardButton(MainCommand.BOTTOM011.getText()));
        List<KeyboardButton> line2 = new ArrayList<>();
        line2.add(new KeyboardButton(MainCommand.BOTTOM021.getText()));
        line2.add(new KeyboardButton(MainCommand.BOTTOM022.getText()));
        buttonList.add(line1);
        buttonList.add(line2);
        return new ReplyKeyboardMarkup(buttonList);
    }

    private void sendMessage(SendMessage sendMessage) {
        RestTemplate restTemplate = new RestTemplate();
        restTemplate.postForObject("https://api.telegram.org/bot376651530:AAH-aBiEkS_tezghZxNLTEi1ypnuXdbl-5M/sendMessage", sendMessage,SendMessage.class);
    }

/*    @PostConstruct
    public void init(){
        System.out.println("PostConstruct start");
        LinkedMultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
        FileSystemResource value = new FileSystemResource(new File("./public_cert.pem"));
        map.add("certificate", value);
        map.add("url","https://93.170.123.172:443/mybot");
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.MULTIPART_FORM_DATA);
        HttpEntity<LinkedMultiValueMap<String, Object>> requestEntity = new HttpEntity<>(map, headers);
        RestTemplate restTemplate = new RestTemplate();
        restTemplate.exchange("https://api.telegram.org/bot376651530:AAH-aBiEkS_tezghZxNLTEi1ypnuXdbl-5M/setWebhook", HttpMethod.POST, requestEntity, String.class);
        System.out.println("setwebhook");
    }*/
}
