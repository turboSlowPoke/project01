package project01.project01.telegram;

import org.springframework.core.io.FileSystemResource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import project01.project01.telegram.methods.SendMessage;
import project01.project01.telegram.objects.Update;

import javax.annotation.PostConstruct;
import java.io.File;

@RestController
public class WebhookController {

    @RequestMapping("/mybot")
    public ResponseForTelegram getUpdate(@RequestBody  Update update){
        System.out.println(update);
        System.out.println(update.getMessage().getText());
        sendMessage(new SendMessage(update.getMessage().getChat().getId(),"her"));
        return null;
    }

    private void sendMessage(SendMessage sendMessage) {
        RestTemplate restTemplate = new RestTemplate();
        restTemplate.postForObject("https://api.telegram.org/bot376651530:AAH-aBiEkS_tezghZxNLTEi1ypnuXdbl-5M/sendMessage", sendMessage,SendMessage.class);
    }

    @PostConstruct
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
    }
}
