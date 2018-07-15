package project01.project01.services;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClient;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClientService;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.client.RestTemplate;
import project01.project01.config.GlobalConfig;
import project01.project01.db_services.UserDataRepository;
import project01.project01.db_services.UserRepository;
import project01.project01.entyties.Role;
import project01.project01.entyties.Subscribe;
import project01.project01.entyties.User;
import project01.project01.entyties.UserData;
import project01.project01.exceptions.NoUserInDbException;
import project01.project01.telegram.rx_objects.Message;

import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.time.LocalDateTime;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
public class UserService {
    private static final Logger log = LoggerFactory.getLogger(UserService.class);
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private UserDataRepository userDataRepository;
    @Autowired
    private OAuth2AuthorizedClientService authorizedClientService;

    public User createNewUserByInviteLinkForTelegram(Message message) throws NoUserInDbException  {
        User user = createNewUser(message);
        try {
            Integer parenUserId = Integer.parseInt(message.getText().substring(10));
            Optional<User> optionalUser = userRepository.findById(parenUserId);
            if (optionalUser.isPresent()){
                User parentUser = optionalUser.get();
                user.setInvitedId(parentUser.getId());
                userRepository.save(user);
                log.info("Юзеру добавлен реферал "+parentUser);
                log.info("Сохранён приглашенный пользователь");
            }else {
                throw new NoUserInDbException();
            }
        }catch (NumberFormatException e){
            throw new NoUserInDbException();
        } catch (NoUserInDbException e) {
            userRepository.save(user);
            System.out.println("Кривая реф ссылка, сохранён без id пригласителя " + user);
            log.warn("Кривая реф ссылка, сохранён без id пригласителя " + user);
            throw new NoUserInDbException();
        }finally {
            return user;
        }
    }

    public User createNewUser(Message message) {

        User user = new User();
        user.setStartDate(LocalDateTime.now());
        user.setTelegramChatId(message.getChat().getId());
        user.setRoles(new HashSet<Role>(Arrays.asList(new Role())));
        user.setLogin(message.getChat().getUserName());
        user=userRepository.save(user);

        UserData userData = new UserData();
        userData.setFirstName(getValidPartName(message.getChat().getFirstName()));
        userData.setLastName(getValidPartName(message.getChat().getLastName()));
        userData.setTelegramNikcName("@"+message.getChat().getUserName());
        Optional<User> optionalUser = userRepository.findById(user.getId());
        optionalUser.ifPresent(u -> {
            u.setUserData(userData);
            String stringForHash = u.getId().toString()+u.getStartDate().toString()+GlobalConfig.CodWord;
            u.setHash(createHash(stringForHash));
            u.setSubsribe(new Subscribe());
            userRepository.save(u);
            log.info("Сохранён новый юзер: "+u);
        });
        return user;
    }

    public User addTelegramIdToUser(Message message ) {
        Optional<User> optionalUser = userRepository.findUserByHash(message.getText().substring(7));
        if (optionalUser.isPresent()){
            User user =optionalUser.get();
            user.setTelegramChatId(message.getChat().getId());
            user.getUserData().setTelegramNikcName("@" + message.getChat().getUserName());
            if (user.getUserData().getFirstName() == null)
                user.getUserData().setFirstName(getValidPartName(message.getChat().getFirstName()));
            if (user.getUserData().getLastName() == null)
                user.getUserData().setLastName(getValidPartName(message.getChat().getLastName()));
            userRepository.save(user);
            userDataRepository.save(user.getUserData());
            log.info("Юзеру выполнена привязка телеграм " + user);
            return user;
        }else {
            log.warn("Юзер перешел в бот по кривой ссылке из личного кабинета: " +message.getText());
            System.out.println("Юзер перешел в бот по кривой ссылке из личного кабинета: " +message.getText());
            return null;
        }

    }

    public User addGoogleIdToUser(Authentication authentication, String userIdFromTelegramLink) {
        log.info("Пытаемся добавить гугл данные к телеграм юзеру ");
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
            Optional<User> optionalUser = userRepository.findUserByHash(userIdFromTelegramLink);
            if(optionalUser.isPresent()){
                User user = optionalUser.get();
                user.setGoogleId(authentication.getName());
                UserData userData = user.getUserData();
                userData.setEmail(email);
                userData.setFirstName(firstName);
                userData.setLastName(lastName);
                userRepository.save(user);
                log.info("Сохранён пользователь, перешедший по ссылке из телеграм "+user);
                return user;
            }else {
                log.warn("юзер прешел по кривой ссылке из телеграм uh="+userIdFromTelegramLink);
            }
        }
        return null;
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

    private String createHash(String stringForHash){
        MessageDigest md = null;
        try {
            md = MessageDigest.getInstance("SHA-256");
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        md.update(stringForHash.getBytes(StandardCharsets.UTF_8));
        byte[] digest = md.digest();
        String hash = String.format("%064x", new BigInteger( 1, digest ) );
        return hash;
    }

}
