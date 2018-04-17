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
import org.springframework.security.oauth2.client.OAuth2AuthorizedClientService;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClient;
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;
import project01.project01.db_services.CustomUserDetails;
import project01.project01.db_services.UserRepository;
import project01.project01.entyties.Role;
import project01.project01.entyties.User;
import project01.project01.entyties.UserData;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Controller
public class PrivatePageController {
    private static final Logger log = LoggerFactory.getLogger(PrivatePageController.class);
    @Autowired
    private OAuth2AuthorizedClientService authorizedClientService;

    private final UserRepository userRepository;

    public PrivatePageController( UserRepository userRepository) {
        this.authorizedClientService = authorizedClientService;
        this.userRepository = userRepository;
    }

    @GetMapping("/login_google_succes")
    public ModelAndView loginWithGoogleSucces(HttpServletRequest request, OAuth2AuthenticationToken authentication){
        System.out.println("login_google_succes");
        String googleAuthId = authentication.getName();
        List<User> users = userRepository.findUserByGoogleId(googleAuthId);
        User user=null;
        if (users==null||users.isEmpty()){
             user = createNewUserWithGoogleAuth(authentication);
        }
        request.getSession(false).setAttribute("user",user);
        return new ModelAndView("redirect:"+"/lk");

    }



    @GetMapping("/lk")
    public ModelAndView lk(HttpServletRequest request, Authentication authentication) {
        HttpSession session = request.getSession(false);
        User user = null;
        //user как атрибут
        if (session.getAttribute("user")==null) {
            //проверяем какого типа авторизация, если через гугл то name содержит только цифры google id
            String currentPrincipalName = authentication.getName();
                if (hasOnlyDigital(currentPrincipalName)) {
                    //ищем юзера в базе
                    List<User> users = userRepository.findUserByGoogleId(currentPrincipalName);
                    //если не нашли создаем нового
                    if (users==null||users.isEmpty()){
                        user = createNewUserWithGoogleAuth(authentication);
                    }
                }else {
                    //если не гугл, то name содержит поле login User-а
                    CustomUserDetails userDetails =  (CustomUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
                    user = userDetails.getUser();
                }
            // крепим атрибут к сессии
            session.setAttribute("user",user);
        } else {
            user = (User) session.getAttribute("user");
        }


        Map<String, Object> model = new HashMap<>();
        model.put("user", user);
        return new ModelAndView("dashboard", model);

    }

    private User createNewUserWithGoogleAuth(Authentication authentication) {
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
            String login = email.substring(0,name.indexOf("@"));
            User user = new User(login);
            user.setGoogleId(authentication.getName());
            Set<Role> roles = new HashSet<>();
            roles.add(new Role());
            user.setRoles(roles);
            UserData userData = new UserData();
            userData.setEmail(email);
            userData.setFirstName(firstName);
            userData.setLastName(lastName);
            user.setUserData(userData);
            userRepository.save(user);
            log.info("Сохранён новый пользователь "+user);
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
