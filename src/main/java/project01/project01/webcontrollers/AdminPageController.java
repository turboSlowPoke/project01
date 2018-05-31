package project01.project01.webcontrollers;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;
import project01.project01.db_services.*;
import project01.project01.entyties.*;
import project01.project01.enums.Global;
import project01.project01.telegram.tx_objects.SendMessage;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Controller
public class AdminPageController {
    private static final Logger log = LoggerFactory.getLogger(AdminPageController.class);
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private SubscribeRepository subscribeRepository;
    @Autowired
    private SignalRepository signalRepository;
    @Autowired
    private TrainingGroupRepository trainingGroupRepository;
    @Autowired
    private HomeWorkRepository homeWorkRepository;


    @RequestMapping("/admin")
    public ModelAndView admin(@RequestParam(required = false) String method,
                                      @RequestParam(required = false) String header,
                                      @RequestParam(required = false) String body,
                                      @RequestParam(required = false) String groupName,
                                      @RequestParam(required = false) String startSet,
                                      @RequestParam(required = false) String endSet){

        Map<String,Object> model = new HashMap<>();
        if (method!=null) {
            switch (method) {
                case "sendSignal":
                    Integer count = sendSignal(header, body);
                    model.put("signalsSended", count);
                    break;
                case "createTrainingGroup":
                    log.info("Создаем новую группу");
                    System.out.println("Создаем новую группу");
                    TrainingGroup trainingGroup = createTrainingGroup(groupName,startSet,endSet);
                    model.put("trainingGroup",trainingGroup);
                    break;
            }
        }

        model.put("countUsers",userRepository.count());
        model.put("countActiveSubscribe",subscribeRepository.countAllByEndOfSignalAfter(LocalDate.now()));
        model.put("countUsersWithTraining",subscribeRepository.countAllByTrainingIsActiveTrue());
        model.put("trainingGroupList",trainingGroupRepository.findAll());
        return new ModelAndView("admin",model);
    }

    private TrainingGroup createTrainingGroup(String groupName, String startSet, String endSet) {
        TrainingGroup trainingGroup = new TrainingGroup();
        trainingGroup.setName(groupName);
        trainingGroup.setStartSet(LocalDate.parse(startSet));
        trainingGroup.setEndSet(LocalDate.parse(endSet));
        Course course = new Course();
        course.setAmount(new BigDecimal("100"));
        course.setName("СуперКурс");
        course.setDescription("Это супер пупер курс пройдя который вы будете супер пупер");
        trainingGroup.setCourse(course);
        trainingGroupRepository.save(trainingGroup);
        log.info("Сохранена новая группа на обучение " + trainingGroup);
        System.out.println("Сохранена новая группа на обучение " + trainingGroup);
        return trainingGroup;
    }

    private Integer sendSignal(String header, String body) {
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

    private void sendMessage(SendMessage sendMessage) throws Exception {
        RestTemplate restTemplate = new RestTemplate();
           restTemplate.postForObject(Global.BOT_URL.getText() +"/sendMessage", sendMessage,SendMessage.class);
            Thread.sleep(20);

    }

    @GetMapping("/admin/group")
    public ModelAndView trainingGroup(@RequestParam String group){
        Map<String, Object> model = new HashMap<>();
        Optional<TrainingGroup> trainingGroup = trainingGroupRepository.findById(Integer.parseInt(group));
        trainingGroup.ifPresent(tg -> model.put("group",tg));
        return new ModelAndView("TrainingGroup",model);
    }

    @RequestMapping(value = "/admin/training_group/{groupId}/list_user_homeworks/{userid}", method = RequestMethod.GET)
    public ModelAndView checkHomeWork(@PathVariable("userid") String userId,
                                      @PathVariable("groupId")String groupId){
      Map<String,Object> model = new HashMap<>();
      Optional<User> optionalUser = userRepository.findById(Integer.parseInt(userId));
      optionalUser.ifPresent(user -> {
          model.put("user",user);
      });
      Optional<TrainingGroup> trainingGroup = trainingGroupRepository.findById(Integer.parseInt(groupId));
      trainingGroup.ifPresent(group -> {
            model.put("trainingGroup",group);
      });

      return new ModelAndView("homeworkList",model);

    }

}
