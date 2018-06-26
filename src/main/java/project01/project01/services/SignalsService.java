package project01.project01.services;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import project01.project01.db_services.SignalRepository;
import project01.project01.db_services.UserRepository;
import project01.project01.entyties.Signal;
import project01.project01.entyties.User;
import project01.project01.enums.Global;
import project01.project01.exceptions.TelegramMessageNotSendedException;
import project01.project01.telegram.tx_objects.SendMessage;

import java.time.LocalDate;
import java.util.List;

@Service
public class SignalsService {
    private static final Logger log = LoggerFactory.getLogger(SignalsService.class);
    @Autowired
    private SignalRepository signalRepository;
    @Autowired
    private UserRepository userRepository;

    public Integer sendSignal(String header, String body) {
        Signal signal = new Signal(header,body);
        signalRepository.save(signal);
        List<User> users = userRepository.findUserForSendSignals(LocalDate.now());
        Integer count=0;
        if (users!=null&&!users.isEmpty()){
            System.out.println("Отправляем сигналы....");
            log.info("отправляем сигналы");
            for (User u : users){
                SendMessage sendMessage = new SendMessage(u.getTelegramChatId(),signal.getBody());
                try {
                    sendMessage(sendMessage);
                    count++;
                } catch (Exception e) {
                    System.out.println("Ошибка при отправке юзеру"+u);
                }
            }
            System.out.println("Сигналы отправлены");
            log.info("Сигналы отправлены");
        }
        return count;
    }

    public void sendMessageForUser(User user, String text){
        SendMessage sendMessage = new SendMessage();
        sendMessage.setChatId(user.getId());
        sendMessage.setText(text);
        try {
            sendMessage(sendMessage);
        } catch (TelegramMessageNotSendedException e) {
            log.warn("Не удалось отправить сообщение юзеру "+user);
        }
    }


    private void sendMessage(SendMessage sendMessage) throws TelegramMessageNotSendedException {
        RestTemplate restTemplate = new RestTemplate();
        try {
            restTemplate.postForObject(Global.BOT_URL.getText() +"/sendMessage", sendMessage,SendMessage.class);
            Thread.sleep(15);
        } catch (Exception e){
            throw new TelegramMessageNotSendedException();
        }
    }
}
