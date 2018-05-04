package project01.project01.webcontrollers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.Map;

@Controller
public class PaymentPageController {

    @RequestMapping("payment")
    public ModelAndView payment(@RequestParam String method){
        Map<String,Object> model = new HashMap<>();

    }
}
