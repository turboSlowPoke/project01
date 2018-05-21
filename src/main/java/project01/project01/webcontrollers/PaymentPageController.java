package project01.project01.webcontrollers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import project01.project01.config.AdvcashCongig;
import project01.project01.db_services.OrderRepository;
import project01.project01.db_services.UserRepository;
import project01.project01.entyties.Order;
import project01.project01.entyties.User;
import project01.project01.enums.Purchase;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@Controller
public class PaymentPageController {
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private OrderRepository orderRepository;

    @PostMapping("/payment")
    public ModelAndView payment(HttpServletRequest request,
                                @RequestParam String purchase){
        Map<String,Object> model = new HashMap<>();
        Purchase purch = Purchase.getTYPE(purchase);
        if (purch!=Purchase.FAIL){
            Order order = new Order();
            order.setDateTime(LocalDateTime.now());
            order.setComment(purch.getText());
            switch (purch){
                case SIGNALS01:
                    order.setAmount(new BigDecimal("10"));
                    break;
                case SIGNALS02:
                    order.setAmount(new BigDecimal("20"));
                    break;
                case SIGNALS03:
                    order.setAmount(new BigDecimal("30"));
                    break;
                case TRAINING01:
                    order.setAmount(new BigDecimal("100"));
                    break;
            }
            User user = (User) request.getSession(false).getAttribute("user");
            user.addOrder(order);
            userRepository.save(user);
            orderRepository.save(order);
            //create hash  ac_account_email:ac_sci_name:ac_amount:ac_currency:secret:ac_order_id
            String string =
                    AdvcashCongig.acAccountEmail+":"+
                    AdvcashCongig.acSciName+":"+
                    order.getAmount()+":"+
                    AdvcashCongig.acCurrency+":"+
                    AdvcashCongig.secret+":"+
                    order.getId();
            MessageDigest md = null;
            try {
                md = MessageDigest.getInstance("SHA-256");
            } catch (NoSuchAlgorithmException e) {
                e.printStackTrace();
            }
            md.update(string.getBytes(StandardCharsets.UTF_8));
            byte[] digest = md.digest();
            String hash = String.format("%064x", new BigInteger( 1, digest ) );

            model.put("hash",hash);
            model.put("order",order);
        }

        return new ModelAndView("pay",model);
    }

    @RequestMapping("/status")
    public void status(@RequestParam("ac_transfer")String transferId,
                               @RequestParam("ac_start_date")String acStartDate,
                               @RequestParam("ac_sci_name") String sciName,
                               @RequestParam("ac_src_wallet") String acSrcWallet,
                               @RequestParam("ac_dest_wallet") String acDstWallet,
                               @RequestParam("ac_order_id") String orderId,
                               @RequestParam("ac_amount") String amount,
                               @RequestParam("ac_merchant_currency") String currency,
                               @RequestParam("ac_hash") String hash,
                               @RequestParam("ac_transaction_status") String status
                               ){
        switch (status){
            case "COMPLETED":
                //считаем и сравниваем хеш
                //ставим в ордере статус оплачено
                Optional<Order> order = orderRepository.findById(Integer.parseInt(orderId));
                if (order.isPresent()){
                    order.get().setPaid(true);

                }
                //продляем услугу
                //расчитываем рефералку
                break;
        }
    }
}
