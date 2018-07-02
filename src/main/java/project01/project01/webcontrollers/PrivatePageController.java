package project01.project01.webcontrollers;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClientService;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClient;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import project01.project01.config.GlobalConfig;
import project01.project01.db_services.*;
import project01.project01.entyties.*;
import project01.project01.enums.Global;
import project01.project01.services.PasswordService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.websocket.server.PathParam;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Controller
public class PrivatePageController {
    private static final Logger log = LoggerFactory.getLogger(PrivatePageController.class);
    @Autowired
    private OAuth2AuthorizedClientService authorizedClientService;
    @Autowired
    private TrainingGroupRepository trainingGroupRepository;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private OrderRepository orderRepository;
    @Autowired
    private UserDataRepository userDataRepository;
    @Autowired
    private PasswordService passwordService;
    @Autowired
    private HomeworkRepository homeworkRepository;
    @Autowired
    private PayOutOrderRepositotry payOutOrderRepositotry;

    public PrivatePageController( ) {
    }


    @GetMapping("/lk")
    public ModelAndView lk(HttpServletRequest request,
                           Authentication authentication,
                           @RequestParam(required = false) String paidOrder) {
        HttpSession session = request.getSession(false);
//        authentication.getAuthorities().stream().map(res -> {
//            String key1 =  ((GrantedAuthority) res).getAuthority().
//        }).collect(Collectors.to)
        String userIdFromTelegramLink = (String) session.getAttribute("userIdFromTelegramLink");

        Integer userId=null;
        if (session.getAttribute("userId")==null) {
            User user = null;
            //проверяем какого типа авторизация, если через гугл то name содержит только цифры google id
            String currentPrincipalName = authentication.getName();
                if (hasOnlyDigital(currentPrincipalName)) {
                    //ищем юзера в базе
                    List<User> users = userRepository.findUserByGoogleId(currentPrincipalName);
                    //если не нашли создаем нового
                    if (users==null||users.isEmpty()){
                        if (userIdFromTelegramLink==null) {
                            user = createNewUserWithGoogleAuth(authentication);
                        }else {
                            user = addGoogleIdToUser(authentication,userIdFromTelegramLink);
                        }
                    }else {
                        user=users.get(0);
                    }
                }else {
                    //если не гугл, то name содержит поле login User-а
                    CustomUserDetails userDetails =  (CustomUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
                    user = userDetails.getUser();
                }
            // крепим атрибут к сессии
            userId=user.getId();
            session.setAttribute("userId",user.getId());
            //если админ редиректим на админскую страницу
            if (userIsAdmin(user))
                return new ModelAndView("redirect:/admin", new HashMap<>());
        } else {
            //user = (User) session.getAttribute("user");
             userId = (Integer) session.getAttribute("userId");
        }
        List<TrainingGroup> trainingGroups = trainingGroupRepository.findTrainingGroupsByEndSetIsAfter(LocalDate.now().minusDays(1));
        Map<String, Object> model = new HashMap<>();
        Optional<User> optionalUser = userRepository.findById(userId);
        optionalUser.ifPresent(user->{
            model.put("user", user);
            if (user.getTelegramChatId()==null) {
                model.put("userHash",user.getHash());
            }
            if (request.getSession(false).getAttribute("passwordChanged")!=null
                    &&(Boolean) request.getSession(false).getAttribute("passwordChanged")){
                model.put("succes","Пароль изменён");
                request.getSession().removeAttribute("passwordChanged");
            }
            model.put("botLink",Global.BOT_LINK.getText());
            //если юзер перешел по реферальной ссылке
            if (session.getAttribute("invitedId")!=null){
                try {
                    Integer id = Integer.parseInt((String) session.getAttribute("invitedId"));
                    Optional<User> optionalInvitedUser = userRepository.findById(id);
                    optionalInvitedUser.ifPresent(u ->{
                        if ((user.getInvitedId()==null||user.getInvitedId()==0)){ //проверить чтобы юзер не пригласил сам себя
                            user.setInvitedId(u.getId());
                            userRepository.save(user);
                        }
                        log.info("Добавлен invitedId="+id+"  для " + user);
                        System.out.println("Добавлен invitedId="+id+"  для " + user);
                    });
                }catch (Exception e){
                    log.error("Не корректный id в реф ссылке" + session.getAttribute("invitedId"));
                    System.out.println("Не корректный id в реф ссылке" + session.getAttribute("invitedId"));
                }finally {
                    session.removeAttribute("invitedId");
                }
            }
            model.put("numberOfAllReferals",userRepository.countByInvitedId(user.getId()));
            BigDecimal amount = orderRepository.amountReferalPayment(user.getId());
            model.put("sumPaymentOfReferals",amount);
            model.put("sumUncheckedHomework",homeworkRepository.countUncheckedHomeworkForUser(user.getId()));
            List<Homework> homeworkList = homeworkRepository.findTop5ByDateTimeOfCreationAndUserId(user.getId());
            model.put("lastFivehomeWork",homeworkRepository.findTop5ByDateTimeOfCreationAndUserId(user.getId()));
        });
        //заявка на выплату
        model.put("payOutOrders",payOutOrderRepositotry.findOpenOrderForUser(userId));
        model.put("trainingGroups",trainingGroups);

        //редирект от удачного платежа
        if (paidOrder!=null&&!paidOrder.isEmpty()){
            Optional<Order> optionalOrder = orderRepository.findById(Integer.parseInt(paidOrder));
            optionalOrder.ifPresent(order -> {
                model.put("paidOrder",order);
            });
        }
        model.put("siteURL",GlobalConfig.siteUrl);
        return new ModelAndView("dashboard", model);

    }

    private boolean userIsAdmin(User user) {
        boolean chek=false;
        Set<Role> roles = user.getRoles();
        for (Role role : roles)
            if (role.getRole().equals("ADMIN"))
                chek=true;
        return chek;
    }

    @PostMapping("/lk/add_homework")
    public RedirectView addHomeWork(HttpServletRequest request,
                                    @RequestParam(value = "name",required = false) String name,
                                    @RequestParam(value = "files",required = false)MultipartFile[] files,
                                    @RequestParam(value = "body",required = false) String body){
        Optional<User> optionalUser = userRepository.findById((Integer)request.getSession(false).getAttribute("userId"));
        optionalUser.ifPresent(user -> {
            Integer sumUncheckedHomework = homeworkRepository.countUncheckedHomeworkForUser(user.getId());
            if (user.getTrainingGroups()!=null
                    &&user.getTrainingGroups().size()>0
                    &&name!=null
                    &&(sumUncheckedHomework==null||sumUncheckedHomework<2)
                    &&(files!=null||body!=null)) {
                log.info("юзер " + user + "прислал дз");
                System.out.println("юзер " + user + "прислал дз");
                List<String> filenames = new ArrayList<>();
                if (files!=null) {
                    for (MultipartFile file : files) {
                        String filename = "" + user.getId() + "_" + LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"))
                                + "_" + StringUtils.cleanPath(file.getOriginalFilename());
                        if (!file.isEmpty()&&!filename.contains("..")) {
                            try (InputStream inputStream = file.getInputStream()) {
                                Files.copy(inputStream, GlobalConfig.pathUsersFiles.resolve(filename), StandardCopyOption.REPLACE_EXISTING);
                                filenames.add(filename);
                                System.out.println("Сохранён файл " + filename);
                                log.info("Сохранён файл " + filename);
                            } catch (IOException e) {
                                System.out.println("не смог сохранить файл в homeworkfiles " + GlobalConfig.pathUsersFiles.resolve(filename));
                            }
                        }
                    }
                }
                Homework homework = new Homework();
                homework.setDateTimeOfCreation(LocalDateTime.now());
                if (!name.isEmpty())
                    homework.setName(name);
                if (!filenames.isEmpty())
                    homework.setFiles(filenames);
                if (body!=null&&!body.isEmpty())
                    homework.setBody(body);
                if (user.getHomeworks() == null)
                    user.setHomeworks(new ArrayList<>());
                homework.setUser(user);
                homework.setTrainingGroup(user.getTrainingGroups().get(0));
                user.getHomeworks().add(homework);
                userRepository.save(user);
                log.info("Сохранено дз " + homework + "для юзера " +user);
                System.out.println("Сохранено дз " + homework + "для юзера " +user);
            }
        });
        return new RedirectView("/lk");
    }

    @PostMapping("/lk/delete_homework")
    public RedirectView deleteHomework(HttpServletRequest request,
                                       @RequestParam String id){
        Optional<User> optionalUser = userRepository.findById((Integer) request.getSession(false).getAttribute("userId"));
        optionalUser.ifPresent(user -> {
            Optional<Homework> optionalHomework = homeworkRepository.findById(Integer.parseInt(id));
            optionalHomework.ifPresent(homework -> {
                if (homework.getUser().getId()==user.getId()){
                    Integer countDeletedFiles=0;
                    for (String path : homework.getFiles()) {
                        Path fileToDeletePath = GlobalConfig.pathUsersFiles.resolve(path);
                        try {
                            Files.delete(fileToDeletePath);
                            countDeletedFiles++;
                        } catch (IOException e) {
                            System.out.println("Не смог удалить файл" + path);
                            log.error("Не смог удалить файл" + path);
                        }
                    }
                    if (countDeletedFiles==homework.getFiles().size()){
                        System.out.println("все файлы для дз  удалены");
                        user.getHomeworks().remove(homework);
                        userRepository.save(user);
                        homeworkRepository.delete(homework);
                    }else {
                        System.out.println("Не все файлы удалены, не могу удалить " + homework);
                    }
                }
            });
        });
        return new RedirectView("/lk");
    }
    @GetMapping("/lk/list_my_homeworks")
    public ModelAndView getHomeworkList(HttpServletRequest request){
        Map<String,Object> model = new HashMap<>();
        Optional<User> optionalUser = userRepository.findById((Integer)request.getSession(false).getAttribute("userId"));
        optionalUser.ifPresent(user -> {
            List<Homework> homeworkList = homeworkRepository.findAllAndSortByDateByUserId(user.getId());
            model.put("homeworkList",homeworkList);
        });
        return new ModelAndView("homeworks_list_user_view",model);
    }

    @GetMapping("/lk/homework/{id}")
    public ModelAndView getHomework(HttpServletRequest request,
                                    @PathVariable("id") String id){
        Map<String,Object> model = new HashMap<>();
        Optional<User> optionalUser = userRepository.findById((Integer)request.getSession(false).getAttribute("userId"));
        optionalUser.ifPresent(user -> {
            try {
                Optional<Homework> optionalHomework = homeworkRepository.findById(Integer.parseInt(id));
                optionalHomework.ifPresent(homework -> {
                    if (homework.getUser().getId()==user.getId()){
                        model.put("homework",homework);
                    }else {
                        System.out.println("Пытается открыть чужую работу id="+id+", юзер: " + user);
                        log.warn("Пытается открыть чужую работу id="+id+", юзер: " + user);
                    }
                });
            }catch (NumberFormatException e){
                System.out.println("Пытается открыть работу с id="+id+", юзер:" +user);
                log.warn("Пытается открыть работу с id="+id+", юзер:" +user);
            }
        });
        return new ModelAndView("homework_user_view",model);
    }

    @PostMapping("/lk")
    public RedirectView uploadFile(HttpServletRequest request,
                                   @RequestParam(required = false) String firstName,
                                   @RequestParam(required = false) String lastName,
                                   @RequestParam(required = false) String password1,
                                   @RequestParam(required = false) String password2,
                                   @RequestParam(required = false) String email,
                                   @RequestParam(required = false) String advcash){
        Integer userId = (Integer) request.getSession(false).getAttribute("userId");
        Optional<User> optionalUser = userRepository.findById(userId);
        optionalUser.ifPresent(user -> {
            if (firstName!=null) {
                user.getUserData().setFirstName(firstName);
                userDataRepository.save(user.getUserData());
                log.info("сменил имя "+user);
                System.out.println("сменил имя "+user);
            }
            if (lastName!=null){
                user.getUserData().setLastName(lastName);
                userDataRepository.save(user.getUserData());
                log.info("сменил фамилию "+user);
                System.out.println("сменил фамилию "+user);
            }
            if (password1!=null&&password2!=null&&
                    password1.equals(password2)&&
                    passwordService.checkPassword(password1)){
                user.setPassword(new BCryptPasswordEncoder().encode(password1));
                userRepository.save(user);
                System.out.println("Поменял пароль юзер" + user);
                request.getSession(false).setAttribute("passwordChanged",true);
            }
            if (email!=null&&!email.isEmpty()){
                user.getUserData().setEmail(email);
                userDataRepository.save(user.getUserData());
                log.info("сменил email "+user);
                System.out.println("сменил email "+user);
            }
            if (advcash!=null&&!advcash.isEmpty()&&advcash.length()<20){
                user.getUserData().setAdvcash(advcash);
                userRepository.save(user);
                System.out.println("сменил advcash " +user);
                log.info("сменил advcash " +user);
            }
        });
        return new RedirectView("/lk");
    }

    @GetMapping("/lk/pay_out")
    private RedirectView createPayOutOrder(HttpServletRequest request){
        Optional<User> optionalUser = userRepository.findById((Integer)request.getSession(false).getAttribute("userId"));
        optionalUser.ifPresent(user -> {
            if (user.getBonusWallet()!=null
                    &&user.getBonusWallet().getUsdBonus()!=null
                    &&user.getBonusWallet().getUsdBonus().signum()==1){
                List<PayOutOrder> payOutOrders = payOutOrderRepositotry.findOpenOrderForUser(user.getId());
                if (payOutOrders==null||payOutOrders.isEmpty()) {
                    if (user.getPayOutOrders() == null) {
                        user.setPayOutOrders(new ArrayList<>());
                    }
                    PayOutOrder payOutOrder = new PayOutOrder();
                    payOutOrder.setCreateDate(LocalDateTime.now());
                    payOutOrder.setUser(user);
                    user.getPayOutOrders().add(payOutOrder);
                    userRepository.save(user);
                    log.info("Создана заявка на выплату рефералки для " +user);
                    System.out.println("Создана заявка на выплату рефералки для " +user);
                    request.getSession(false).setAttribute("succes","Заявка на выплату принята");
                }
            }
        });
        return new RedirectView("/lk");
    }

    private User addGoogleIdToUser(Authentication authentication, String userIdFromTelegramLink) {
        OAuth2AuthorizedClient authorizedClient = authorizedClientService.loadAuthorizedClient("google", authentication.getName());
        String userInfoEndpointUri = authorizedClient.getClientRegistration()
                .getProviderDetails().getUserInfoEndpoint().getUri();
        if (!StringUtils.isEmpty(userInfoEndpointUri)) {
            RestTemplate restTemplate = new RestTemplate();
            HttpHeaders headers = new HttpHeaders();
            headers.add(HttpHeaders.AUTHORIZATION, "Bearer " + authorizedClient.getAccessToken()
                    .getTokenValue());
            HttpEntity entity = new HttpEntity("", headers);
            ResponseEntity<Map> response = restTemplate
                    .exchange(userInfoEndpointUri, HttpMethod.GET, entity, Map.class);
            Map userAttributes = response.getBody();
            String email = userAttributes.get("email").toString();
            String name = userAttributes.get("name").toString();
            String firstName = name.substring(0,name.indexOf(" "));
            String lastName = name.substring(name.indexOf(" "));
            String login = email.substring(0,email.indexOf("@"));
            User user = userRepository.findUserById(Integer.parseInt(userIdFromTelegramLink)).get(0);
            user.setGoogleId(authentication.getName());
            UserData userData = user.getUserData();
            userData.setEmail(email);
            userData.setFirstName(firstName);
            userData.setLastName(lastName);
            userRepository.save(user);
            log.info("Сохранён пользователь, перешедший по ссылке из телеграм "+user);
            return user;
        }

        return null;
    }

    private User createNewUserWithGoogleAuth(Authentication authentication) {
        //запрос данных у гугл
        OAuth2AuthorizedClient authorizedClient = authorizedClientService.loadAuthorizedClient("google", authentication.getName());
        String userInfoEndpointUri = authorizedClient.getClientRegistration()
                .getProviderDetails().getUserInfoEndpoint().getUri();
        if (!StringUtils.isEmpty(userInfoEndpointUri)) {
            RestTemplate restTemplate = new RestTemplate();
            HttpHeaders headers = new HttpHeaders();
            headers.add(HttpHeaders.AUTHORIZATION, "Bearer " + authorizedClient.getAccessToken()
                    .getTokenValue());
            HttpEntity entity = new HttpEntity("", headers);
            ResponseEntity<Map> response = restTemplate
                    .exchange(userInfoEndpointUri, HttpMethod.GET, entity, Map.class);
            Map userAttributes = response.getBody();

            String email = userAttributes.get("email").toString();
            String name = userAttributes.get("name").toString();
            String firstName = name.substring(0,name.indexOf(" "));
            String lastName = name.substring(name.indexOf(" "));
            String login = email.substring(0,email.indexOf("@"));

            User user = new User();
            userRepository.save(user);
            user.setLogin(login);
            user.setStartDate(LocalDateTime.now());
            user.setGoogleId(authentication.getName());
            user.setRoles(new HashSet<Role>(Arrays.asList(new Role())));
            //create hash
            String checkString = user.getId().toString()+user.getStartDate()+Global.COD_WORD.getText();
            MessageDigest md = null;
            try {
                md = MessageDigest.getInstance("SHA-256");
            } catch (NoSuchAlgorithmException e) {
                e.printStackTrace();
            }
            md.update(checkString.getBytes(StandardCharsets.UTF_8));
            byte[] digest = md.digest();
            String hash = String.format("%064x", new BigInteger( 1, digest ) );

            user.setHash(hash);
            UserData userData = new UserData();
            userData.setEmail(email);
            userData.setFirstName(firstName);
            userData.setLastName(lastName);
            user.setUserData(userData);
            user.setSubsribe(new Subscribe());
            userRepository.save(user);
            log.info("Сохранён новый пользователь "+user);
            System.out.println("Сохранён новый пользователь "+user);
            return user;
        }
        return null;
    }

    private Boolean hasOnlyDigital(String name) {
        Boolean check =false;
        String p = "[0-9]+";
        Pattern pattern = Pattern.compile(p,Pattern.UNICODE_CHARACTER_CLASS);
        if (name!=null) {
                Matcher matcher = pattern.matcher(name);
                if (matcher.matches()) {
                    check = true;
                }
        }
        return check;
    }
}
