package project01.project01.webcontrollers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;

import org.springframework.security.oauth2.client.OAuth2AuthorizedClientService;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClient;
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;
import project01.project01.db_services.UserRepository;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
public class PrivatePageController {
    @Autowired
    private OAuth2AuthorizedClientService authorizedClientService;

    private final UserRepository userRepository;

    public PrivatePageController( UserRepository userRepository) {
        this.authorizedClientService = authorizedClientService;
        this.userRepository = userRepository;
    }

    @GetMapping("/lk")
    public ModelAndView lk(HttpServletRequest request, OAuth2AuthenticationToken authentication) {
        HttpSession session = request.getSession(true);
        if (session!=null&&session.getAttribute("user")==null){
            if (authentication!=null){

            }
        }
        System.out.println("authentication.getName()=" + authentication.getName());
        OAuth2AuthorizedClient authorizedClient = authorizedClientService.loadAuthorizedClient(authentication.getAuthorizedClientRegistrationId(), authentication.getName());
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
            System.out.println(userAttributes.get("name"));
            System.out.println(userAttributes.get("email"));
        }


//        if (session!=null)
//            System.out.println(session.getAttribute("test"));
        // CustomUserDetails userDetails =  (CustomUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Map<String, String> model = new HashMap<>();
        model.put("username", "user");
        return new ModelAndView("dashboard", model);

    }
}
