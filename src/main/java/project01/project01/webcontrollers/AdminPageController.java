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
import project01.project01.services.SignalsService;
import project01.project01.telegram.tx_objects.SendMessage;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.HashMap;
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
    @Autowired
    private SignalsService signalsService;


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
                    Integer count = signalsService.sendSignal(header, body);
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

    @GetMapping("/admin/group/{groupid}")
    public ModelAndView trainingGroup(@PathVariable("groupid")String groupid){
        Map<String, Object> model = new HashMap<>();
        Optional<TrainingGroup> trainingGroup = trainingGroupRepository.findById(Integer.parseInt(groupid));
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

    @RequestMapping(value = "/admin/homework/{homeworkId}", method = RequestMethod.GET)
    public ModelAndView homework(@PathVariable("homeworkId")String homeworkId,
                                 @RequestParam(required = false)String rating){
        Map<String, Object> model = new HashMap<>();
        if (homeworkId!=null&&!homeworkId.isEmpty()){
            Optional<Homework> optionalHomework = homeWorkRepository.findById(Integer.parseInt(homeworkId));
            optionalHomework.ifPresent(homework -> {
                if (rating!=null&&!rating.isEmpty()){
                    homework.setRating(Integer.parseInt(rating));
                    homework.setVerified(true);
                    homeWorkRepository.save(homework);
                    log.info("проверено дз "+homework);
                    System.out.println("проверено дз "+homework);
                    Optional<User> optionalUser = userRepository.findById(homework.getUser().getId());
                    optionalUser.ifPresent(user -> {
                        if (user.getBonusWallet()==null){
                            BonusWallet wallet = new BonusWallet();
                            wallet.setCandyWrapers(new BigDecimal("0.00"));
                            wallet.setUsdBonus(new BigDecimal("0.00"));
                            user.setBonusWallet(wallet);
                        }
                        user.getBonusWallet().setCandyWrapers(user.getBonusWallet().getCandyWrapers().add(new BigDecimal(rating)));
                        userRepository.save(user);
                        log.info("добавлены бонусы юзеру" +user);
                        System.out.println("добавлены бонусы юзеру" +user);
                    });
                }
                model.put("homework",homework);
            });
        }
        return new ModelAndView("homework",model);
    }

}
