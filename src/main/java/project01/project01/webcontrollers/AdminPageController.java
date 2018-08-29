package project01.project01.webcontrollers;

import org.apache.juli.logging.Log;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import project01.project01.db_services.*;
import project01.project01.entyties.*;
import project01.project01.services.SignalsService;

import javax.servlet.http.HttpServletRequest;
import javax.websocket.server.PathParam;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
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
    private HomeworkRepository homeworkRepository;
    @Autowired
    private SignalsService signalsService;
    @Autowired
    private PayOutOrderRepositotry payOutOrderRepositotry;
    @Autowired
    private CourseRepository courseRepository;
    @Autowired
    private LinksForWebPagesRepository linksForWebPagesRepository;

    @GetMapping("/admin")
    public ModelAndView getMainPage(){
        Map<String,Object> model =  new HashMap<>();
        model.put("isMain",true);
        model.put("countAllUsers",userRepository.count());
        model.put("countActiveSubscribe",subscribeRepository.countAllByEndOfSignalAfter(LocalDate.now()));
        model.put("countUsersWithTraining",subscribeRepository.countAllByTrainingIsActiveTrue());
        return new ModelAndView("admin_tepmlates/admin",model);

    }
    @GetMapping("/admin/signals")
    public ModelAndView getSignalsPage(HttpServletRequest request){
        Map<String,Object> model = new HashMap<>();;
        model.put("isSignals",true);
        if (request.getSession(false).getAttribute("signalsSended")!=null){
            model.put("signalsSended",(Integer)request.getSession(false).getAttribute("signalsSended"));
            request.getSession(false).removeAttribute("signalsSended");
        }
        return new ModelAndView("admin_tepmlates/admin",model);
    }

    @PostMapping("/admin/send_signal")
    public RedirectView sendSignal(HttpServletRequest request,
                                   @RequestParam String header,
                                   @RequestParam String body){
        Integer count = signalsService.sendSignal(header, body);
        request.getSession(false).setAttribute("signalsSended",count);
        return new RedirectView("/admin/signals") ;
    }
    @GetMapping("/admin/TRAINING")
    public ModelAndView getTrainingPage(){
        Map<String,Object> model = new HashMap<>();
        model.put("isTraining",true);
        model.put("isMainTrainingMenu",true);
        model.put("trainingGroupList",trainingGroupRepository.findAll());
        model.put("coursesList",courseRepository.findAll());
        return new ModelAndView("admin_tepmlates/admin",model);
    }
    @PostMapping("/admin/TRAINING/createCourse")
    public RedirectView addTrainingCourse(@RequestParam String name,
                                          @RequestParam String description,
                                          @RequestParam String amount){
        Course course = new Course();
        course.setName(name);
        course.setDescription(description);
        course.setAmount(new BigDecimal(amount+".00"));
        courseRepository.save(course);
        log.info("Создан курс "+ course);
        return new RedirectView("/admin/TRAINING");
    }
    @PostMapping("/admin/TRAINING/createGroup")
    public RedirectView addTrainingGroup(@RequestParam String courseId,
                                         @RequestParam String name,
                                         @RequestParam String startSet,
                                         @RequestParam String endSet){
        TrainingGroup trainingGroup = new TrainingGroup();
        trainingGroup.setName(name);
        trainingGroup.setStartSet(LocalDate.parse(startSet));
        trainingGroup.setEndSet(LocalDate.parse(endSet));
        Optional<Course> course = courseRepository.findById(Integer.parseInt(courseId));
        trainingGroup.setCourse(course.get());
        trainingGroupRepository.save(trainingGroup);
        log.info("Сохранена новая группа на обучение " + trainingGroup);
        System.out.println("Сохранена новая группа на обучение " + trainingGroup);
        return new RedirectView("/admin/TRAINING");
    }
    @GetMapping("/admin/TRAINING/delete_course/{courseId}")
    public RedirectView deleteCourse(@PathVariable String courseId){
        Optional<Course>course = courseRepository.findById(Integer.parseInt(courseId));
        course.ifPresent(c ->{
            if (trainingGroupRepository.countTrainingGroupsByCourseId(c.getId())==0){
                courseRepository.delete(c);
                log.info("курс удален " +course.get());
            }else {
                log.warn("нельзя удалить курс, есть созданные группы " +c);
            }
        });
        return new RedirectView("/admin/TRAINING");
    }
    @GetMapping("/admin/TRAINING/delete_group/{id}")
    public RedirectView deleteTrainingGroup(@PathVariable String id){
        Optional<TrainingGroup> group = trainingGroupRepository.findById(Integer.parseInt(id));
        group.ifPresent(g ->{
            if(g.getUsers().isEmpty()) {
                trainingGroupRepository.delete(g);
                log.info("Ужалена группа " + group);
            }else {
                log.warn("нельзя удалить группу с юзерами");
            }
        });
        return new RedirectView("/admin/TRAINING");
    }
    @GetMapping("/admin/TRAINING/group")
    public ModelAndView getTrainigGroupPage(@RequestParam(required = false) String groupId){
        Map<String,Object> model = new HashMap<>();
        model.put("isTraining",true);
        model.put("isGroupTrainingMenu",true);
        model.put("trainingGroupList",trainingGroupRepository.findAll());
        if (groupId!=null&&!groupId.isEmpty()){
            model.put("trainingGroup",trainingGroupRepository.findById(Integer.parseInt(groupId)).get());
        }
        return new ModelAndView("admin_tepmlates/admin",model);
    }
    @GetMapping("/admin/TRAINING/homeworks")
    public ModelAndView getHomeworksPage(){
        Map<String,Object> model = new HashMap<>();
        model.put("isTraining",true);
        model.put("isHomeworkTrainingMenu",true);
        model.put("uncheckedHomeworkList",homeworkRepository.findAllByChekedFalse());
        return new ModelAndView("admin_tepmlates/admin",model);
    }
    @GetMapping("/admin/content")
    public ModelAndView getContentPage(){
        Map<String,Object> model = new HashMap<>();;
        model.put("isContent",true);
        Optional<LinksForWebPages> links= linksForWebPagesRepository.findById(1);
        links.ifPresent(l -> { model.put("linksForWebPages",l); });
        return new ModelAndView("admin_tepmlates/admin",model);
    }
    @PostMapping("/admin/content")
    public RedirectView setYoutubeLinc(@RequestParam String youtube){
        Optional<LinksForWebPages> links= linksForWebPagesRepository.findById(1);
        if (!links.isPresent()){
            LinksForWebPages linksForWebPages = new LinksForWebPages();
            linksForWebPages.setId(1);
            linksForWebPages.setYoutube(youtube);
            linksForWebPagesRepository.save(linksForWebPages);
        }else {
            links.ifPresent(l -> {
                l.setYoutube(youtube);
                linksForWebPagesRepository.save(l);
            });
        }
        log.info("Изменена ссылка на youtube");
        return new RedirectView("/admin/content");
    }

////////////////////////////////////////////////////////////////////////////////////////////////
    @RequestMapping("/oldadmin")
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
//                    TrainingGroup trainingGroup = createTrainingGroup(groupName,startSet,endSet);
//                    model.put("trainingGroup",trainingGroup);
                    break;
            }
        }

        model.put("countUsers",userRepository.count());
        model.put("countActiveSubscribe",subscribeRepository.countAllByEndOfSignalAfter(LocalDate.now()));
        model.put("countUsersWithTraining",subscribeRepository.countAllByTrainingIsActiveTrue());
        model.put("trainingGroupList",trainingGroupRepository.findAll());
        model.put("uncheckedHomeworkList", homeworkRepository.findAllByChekedFalse());
        model.put("payOutOrderList",payOutOrderRepositotry.findAllByCloseFalse());
        return new ModelAndView("admin",model);
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
            Optional<Homework> optionalHomework = homeworkRepository.findById(Integer.parseInt(homeworkId));
            optionalHomework.ifPresent(homework -> {
                if (rating!=null&&!rating.isEmpty()){
                    homework.setRating(Integer.parseInt(rating));
                    homework.setCheked(true);
                    homeworkRepository.save(homework);
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
        return new ModelAndView("admin_tepmlates/homework",model);
    }

    @GetMapping("/admin/unchecked_homeworks")
    public ModelAndView getUncheckedHomeworkList(){
        Map<String,Object> model = new HashMap<>();
        List<Homework> uncheckedHomeworkList = homeworkRepository.findAllByChekedFalse();
        model.put("uncheckedHomeworkList",uncheckedHomeworkList);
        return new ModelAndView("unchekedHomeworList",model);

    }

    @GetMapping("/admin/pay_out_orders")
    public ModelAndView getPayOutOrders(){
        Map<String,Object> model = new HashMap<>();
        model.put("payOutOrderList",payOutOrderRepositotry.findAllByCloseFalse());
        return new ModelAndView("pay_out_orders",model);
    }

    @GetMapping("/admin/close_pay_out_order/{orderId}")
    public RedirectView closePayOutOrder(@PathVariable("orderId") String orderId){
        Optional<PayOutOrder> payOutOrder = payOutOrderRepositotry.findById(Integer.parseInt(orderId));
        payOutOrder.ifPresent(order -> {
            User user = order.getUser();
            BigDecimal amount = user.getBonusWallet().getUsdBonus();
            user.getBonusWallet().setUsdBonus(new BigDecimal("0.00"));
            order.setAmount(amount);
            order.setClose(true);
            order.setCloseDate(LocalDateTime.now());
            userRepository.save(user);
            System.out.println("Закрыта заявка на вывод для юзера"+user);
            log.info("Закрыта заявка на вывод для юзера"+user);
            signalsService.sendMessageForUser(user,"Обработана ваша заявка на вывод реферальных");
        });

        return new RedirectView("/admin/pay_out_orders");
    }



}
