package project01.project01.services;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import project01.project01.db_services.UserDataRepository;
import project01.project01.db_services.UserRepository;
import project01.project01.entyties.Role;
import project01.project01.entyties.Subscribe;
import project01.project01.entyties.User;
import project01.project01.entyties.UserData;
import project01.project01.enums.Global;
import project01.project01.exceptions.NoUserInDbException;
import project01.project01.telegram.rx_objects.Message;
import project01.project01.telegram.tx_objects.SendMessage;

import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
public class UserService {
    private static final Logger log = LoggerFactory.getLogger(UserService.class);
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private UserDataRepository userDataRepository;

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
        UserData userData = new UserData();
        userData.setFirstName(getValidPartName(message.getChat().getFirstName()));
        userData.setLastName(getValidPartName(message.getChat().getLastName()));
        userData.setTelegramNikcName("@"+message.getChat().getUserName());
        User user = new User();
        user.setStartDate(LocalDateTime.now());
        user.setTelegramChatId(message.getChat().getId());
        user.setRoles(new HashSet<Role>(Arrays.asList(new Role())));
        user.setLogin(message.getChat().getUserName());
        userRepository.save(user);
        String stringForHash = user.getId().toString()+user.getStartDate().toString()+Global.COD_WORD;
        user.setHash(createHash(stringForHash));
        user.setSubsribe(new Subscribe());
        userRepository.save(user);
        log.info("Сохранён новый юзер: "+user);
        return user;
    }

    public User addTelegramIdToUser(Message message ) {
        List<User> users = userRepository.findUserByHash(message.getText().substring(7));
        if (users != null && !users.isEmpty() && users.size() == 1) {
            User user = users.get(0);
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
        }else{
            log.warn("Юзер перешел в бот по кривой ссылке из личного кабинета: " +message.getText());
            System.out.println("Юзер перешел в бот по кривой ссылке из личного кабинета: " +message.getText());
            return null;
        }
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
