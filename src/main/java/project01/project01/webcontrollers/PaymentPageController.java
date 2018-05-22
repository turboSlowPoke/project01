package project01.project01.webcontrollers;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;
import project01.project01.config.AdvcashCongig;
import project01.project01.db_services.OrderRepository;
import project01.project01.db_services.TrainingGroupRepository;
import project01.project01.db_services.UserRepository;
import project01.project01.entyties.Order;
import project01.project01.entyties.TrainingGroup;
import project01.project01.entyties.User;
import project01.project01.enums.Purchase;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@Controller
public class PaymentPageController {
    private static final Logger log = LoggerFactory.getLogger(PrivatePageController.class);
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private OrderRepository orderRepository;
    @Autowired
    private TrainingGroupRepository trainingGroupRepository;

    @PostMapping("/payment")
    public ModelAndView payment(HttpServletRequest request,
                                @RequestParam String purchase,
                                @RequestParam(required = false) String trainingGroupId){
        Map<String,Object> model = new HashMap<>();
        Purchase purch = Purchase.getTYPE(purchase);
        if (purch!=Purchase.FAIL){
            Order order = new Order();
            order.setDateTime(LocalDateTime.now());
            order.setComment(purch.getText());
            order.setPurch(purch.getText());
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
                case TRAINING:
                    order.setAmount(new BigDecimal("100"));
                    Optional<TrainingGroup> trainingGroup = trainingGroupRepository.findById(Integer.parseInt(trainingGroupId));
                    trainingGroup.ifPresent(gr -> {
                        order.setTrGroupid(gr.getId());
                        model.put("trainingGroup",trainingGroup.get());
                    });
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

    @PostMapping("/status")
    public RedirectView status(RedirectAttributes redirectAttributes,
                               HttpServletRequest request,
                               @RequestParam("ac_start_date")String acStartDate,
                               @RequestParam("ac_sci_name") String sciName,
                               @RequestParam("ac_src_wallet") String acSrcWallet,
                               @RequestParam("ac_dest_wallet") String acDstWallet,
                               @RequestParam("ac_order_id") String orderId,
                               @RequestParam("ac_amount") String amount,
                               @RequestParam("ac_merchant_currency") String currency,
                               //@RequestParam("ac_hash") String hash,
                               @RequestParam("ac_transaction_status") String status
                               ){
        log.info("пришло подтверждение оплаты для заказа " +orderId);
        System.out.println("пришло подтверждение оплаты для заказа " + orderId);
        User user = (User) request.getSession(false).getAttribute("user");
        if (status.equals("COMPLETED")){
                //считаем и сравниваем хеш
                //ставим в ордере статус оплачено
                Optional<Order> oOrder = orderRepository.findById(Integer.parseInt(orderId));
                if (oOrder.isPresent()){
                    Order order = oOrder.get();
                    oOrder.get().setPaid(true);
                    orderRepository.save(order);

                    Purchase purchase = Purchase.getTYPE(order.getPurch());
                    switch (purchase){
                        case TRAINING:
                            Optional<TrainingGroup> group = trainingGroupRepository.findById(order.getTrGroupid());
                            group.ifPresent(gr -> {
                                Optional<User> userOptional = userRepository.findById(user.getId());
                                userOptional.ifPresent(u-> {
                                    if (u.getTrainingGroups()==null)
                                        u.setTrainingGroups(new ArrayList<TrainingGroup>());
                                    u.getTrainingGroups().add(gr);
                                    userRepository.save(u);
                                    request.getSession(false).setAttribute("user",u);
                                });
                                if (gr.getUsers()==null)
                                    gr.setUsers(new ArrayList<User>());
                                gr.getUsers().add(user);
                                trainingGroupRepository.save(gr);
                                System.out.println("юзер "+user + " записан в группу " +gr);
                            });
                            break;
                        case SIGNALS01:
                            if (user.getSubsribe().getEndOfSignal()!=null)
                                user.getSubsribe().setEndOfSignal(user.getSubsribe().getEndOfSignal().plusMonths(1));
                            else
                                user.getSubsribe().setEndOfSignal(LocalDate.now().plusMonths(1));
                            System.out.println("Продлена подписка на сигналы для юзера " +user);
                            log.info("Продлена подписка на сигналы для юзера " +user);
                            break;
                        case SIGNALS02:
                            if (user.getSubsribe().getEndOfSignal()!=null)
                                user.getSubsribe().setEndOfSignal(user.getSubsribe().getEndOfSignal().plusMonths(2));
                            else
                                user.getSubsribe().setEndOfSignal(LocalDate.now().plusMonths(2));
                            System.out.println("Продлена подписка на сигналы для юзера " +user);
                            log.info("Продлена подписка на сигналы для юзера " +user);
                            break;
                        case SIGNALS03:
                            if (user.getSubsribe().getEndOfSignal()!=null)
                                user.getSubsribe().setEndOfSignal(user.getSubsribe().getEndOfSignal().plusMonths(3));
                            else
                                user.getSubsribe().setEndOfSignal(LocalDate.now().plusMonths(3));
                            System.out.println("Продлена подписка на сигналы для юзера " +user);
                            log.info("Продлена подписка на сигналы для юзера " +user);
                            break;
                    }
                    userRepository.save(user);

                }
                //рассчитываем рефералку
        }
        redirectAttributes.addAttribute("paidOrder",orderId);
        return new RedirectView("/lk");
    }
}
