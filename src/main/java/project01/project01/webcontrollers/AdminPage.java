package project01.project01.webcontrollers;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;
import project01.project01.db_services.SignalRepository;
import project01.project01.db_services.SubscribeRepository;
import project01.project01.db_services.UserRepository;
import project01.project01.entyties.Signal;
import project01.project01.entyties.User;
import project01.project01.enums.Global;
import project01.project01.telegram.tx_objects.SendMessage;

import javax.servlet.http.HttpServletRequest;
import javax.websocket.server.PathParam;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class AdminPage {
    private static final Logger log = LoggerFactory.getLogger(AdminPage.class);
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private SubscribeRepository subscribeRepository;
    @Autowired
    private SignalRepository signalRepository;

//    @GetMapping("/admin")
//    public ModelAndView adminPageGet(){
//        Map<String,Object> model = new HashMap<>();
//        model.put("countUsers",userRepository.count());
//        model.put("countActiveSubscribe",subscribeRepository.countAllByEndOfSignalAfter(LocalDate.now()));
//        model.put("countUsersWithTraining",subscribeRepository.countAllByTrainingIsActiveTrue());
//
//        return new ModelAndView("admin",model);
//
//    }

    @RequestMapping("/admin")
    public ModelAndView adminPagePost(@RequestParam(required = false) String method,
                                      @RequestParam(required = false) String header,
                                      @RequestParam(required = false) String body){

        Map<String,Object> model = new HashMap<>();
        if (method!=null) {
            switch (method) {
                case "sendSignal":
                    Integer count = sendSignal(header, body);
                    model.put("signalsSended", count);
                    break;
            }
        }
        model.put("countUsers",userRepository.count());
        model.put("countActiveSubscribe",subscribeRepository.countAllByEndOfSignalAfter(LocalDate.now()));
        model.put("countUsersWithTraining",subscribeRepository.countAllByTrainingIsActiveTrue());
        return new ModelAndView("admin",model);
    }

    private Integer sendSignal(String header, String body) {
        Signal signal = new Signal(header,body);
        signalRepository.save(signal);
        List<User> users = userRepository.findUserForSendSignals(LocalDateTime.now());
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

    private void sendMessage(SendMessage sendMessage) throws Exception {
        RestTemplate restTemplate = new RestTemplate();
           // restTemplate.postForObject(Global.BOT_URL.getText() +"/sendMessage", sendMessage,SendMessage.class);
            Thread.sleep(20);

    }
}
