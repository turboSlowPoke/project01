package project01.project01.webcontrollers;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;
import project01.project01.config.AdvcashCongig;
import project01.project01.config.GlobalConfig;
import project01.project01.db_services.OrderRepository;
import project01.project01.db_services.TrainingGroupRepository;
import project01.project01.db_services.UserRepository;
import project01.project01.entyties.*;
import project01.project01.enums.Purchase;

import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;
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
    @Transactional
    @PostMapping("/payment")
    public ModelAndView payment(HttpServletRequest request,
                                @RequestParam String purchase,
                                @RequestParam(required = false) String trainingGroupId){
        Map<String,Object> model = new HashMap<>();
        log.info("purchase="+purchase);
        Purchase purch = Purchase.getTYPE(purchase);
        if (purch!=Purchase.FAIL){
            Order order = new Order();
            order.setDateTime(LocalDateTime.now());
            order.setComment(purch.getText());
            order.setPurch(purch.getText());
            switch (purch){
                case SIGNALS01:
                    order.setAmount(new BigDecimal(GlobalConfig.SIGNALS_1));
                    break;
                case SIGNALS02:
                    order.setAmount(new BigDecimal(GlobalConfig.SIGNALS_2));
                    break;
                case SIGNALS03:
                    order.setAmount(new BigDecimal(GlobalConfig.SIGNALS_3));
                    break;
                case TRAINING:
                    order.setAmount(new BigDecimal(GlobalConfig.TRAINING));
                    Optional<TrainingGroup> trainingGroup = trainingGroupRepository.findById(Integer.parseInt(trainingGroupId));
                    trainingGroup.ifPresent(gr -> {
                        order.setTrGroupid(gr.getId());
                        model.put("trainingGroup",trainingGroup.get());
                    });
                    break;
            }
            Optional<User> optionalUser = userRepository.findById((Integer) request.getSession(false).getAttribute("userId"));
            optionalUser.ifPresent(user ->{
                user.addOrder(order);
                order.setUser(user);
                userRepository.save(user);
                orderRepository.save(order);
                log.info("Сформирован заказ "+order+" для юзера " +user);
                System.out.println("Сформирован заказ "+order+" для юзера " +user);
            });
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
        model.put("acAccountEmail",AdvcashCongig.acAccountEmail);
        model.put("acSciName",AdvcashCongig.acSciName);
        model.put("acCurrency",AdvcashCongig.acCurrency);
        Optional<User> optionalUser = userRepository.findById((Integer)request.getSession(false).getAttribute("userId"));
        optionalUser.ifPresent(user -> {
            model.put("user",user);
        });
        return new ModelAndView("pay",model);
    }
    @Transactional
    @ResponseStatus(HttpStatus.OK)
    @PostMapping("/status_payment_p0tv")
    public void status(HttpServletRequest request,
                       @RequestParam("ac_transfer")String acTransfer,
                       @RequestParam("ac_start_date")String acStartDate,
                       @RequestParam("ac_src_wallet") String acSrcWallet,
                       @RequestParam("ac_dest_wallet") String acDstWallet,
                       @RequestParam("ac_order_id") String orderId,
                       @RequestParam("ac_amount") String amount,
                       @RequestParam("ac_merchant_currency") String currency,
                       @RequestParam("ac_hash") String acHash,
                       @RequestParam("ac_transaction_status") String status){
        log.info("пришло подтверждение оплаты для заказа " +orderId);
        if (status.equals("COMPLETED")){
                //считаем и сравниваем хеш
//ac_transfer:
// ac_start_date:
// ac_sci_name:
// ac_src_wallet:
// ac_dest_wallet:
// ac_order_id:
// ac_amount:
// ac_merchant_currency:
// SCI's password
                String string =acTransfer+":"+
                        acStartDate+":"+
                        AdvcashCongig.acSciName+":"+
                        acSrcWallet+":"+
                        acDstWallet+":"+
                        orderId+":"+
                        amount+":"+
                        currency+":"+
                        AdvcashCongig.secret;
                MessageDigest md = null;
                try {
                    md = MessageDigest.getInstance("SHA-256");
                } catch (NoSuchAlgorithmException e) {
                    e.printStackTrace();
                }
                md.update(string.getBytes(StandardCharsets.UTF_8));
                byte[] digest = md.digest();
                String myhash = String.format("%064x", new BigInteger( 1, digest ) );
                if (!myhash.equals(acHash)){
                    log.warn("не сошлись хеши для заказа "+orderId);
                    throw new RuntimeException();
                }
                Optional<Order> optionalOrder = orderRepository.findById(Integer.parseInt(orderId));
                optionalOrder.ifPresent(order -> {
                    User user = order.getUser();
                    if (user.getSubsribe()==null)
                        user.setSubsribe(new Subscribe());
                    order.setPaid(true);
                    orderRepository.save(order);
                    Purchase purchase = Purchase.getTYPE(order.getPurch());
                    switch (purchase){
                        case TRAINING:
                            Optional<TrainingGroup> group = trainingGroupRepository.findById(order.getTrGroupid());
                            group.ifPresent(gr -> {

                                    if (user.getTrainingGroups()==null)
                                        user.setTrainingGroups(new ArrayList<TrainingGroup>());
                                    user.getTrainingGroups().add(gr);
                                    userRepository.save(user);
                                    request.getSession(false).setAttribute("user",user);
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
                                user.getSubsribe().setEndOfSignal(user.getSubsribe().getEndOfSignal().plusMonths(3));
                            else
                                user.getSubsribe().setEndOfSignal(LocalDate.now().plusMonths(3));
                            System.out.println("Продлена подписка на сигналы для юзера " +user);
                            log.info("Продлена подписка на сигналы для юзера " +user);
                            break;
                        case SIGNALS03:
                            if (user.getSubsribe().getEndOfSignal()!=null)
                                user.getSubsribe().setEndOfSignal(user.getSubsribe().getEndOfSignal().plusMonths(6));
                            else
                                user.getSubsribe().setEndOfSignal(LocalDate.now().plusMonths(6));
                            System.out.println("Продлена подписка на сигналы для юзера " +user);
                            log.info("Продлена подписка на сигналы для юзера " +user);
                            break;
                    }
                    //начисляем бонусы
                    if (user.getBonusWallet()==null) {
                        BonusWallet wallet = new BonusWallet();
                        wallet.setCandyWrapers(new BigDecimal("0.00"));
                        wallet.setUsdBonus(new BigDecimal("0.00"));
                        user.setBonusWallet(wallet);
                    }
                    BigDecimal newBonus = order.getAmount().multiply(GlobalConfig.bonusProcentForPayment);
                    user.getBonusWallet().setCandyWrapers(user.getBonusWallet().getCandyWrapers().add(newBonus));
                    if (user.getUserData().getAdvcash()==null){
                        user.getUserData().setAdvcash(acSrcWallet);

                    }
                    log.info("бонусы начислены " + newBonus);
                    System.out.println("бонусы начислены " + newBonus);
                    userRepository.save(user);
                    //начисляем рефералку
                    if (user.getInvitedId()!=null){
                        Optional<User> otionalParentUser = userRepository.findById(user.getInvitedId());
                        otionalParentUser.ifPresent(parentUser -> {
                            if (parentUser.getBonusWallet()==null){
                                BonusWallet wallet = new BonusWallet();
                                wallet.setCandyWrapers(new BigDecimal("0.00"));
                                wallet.setUsdBonus(new BigDecimal("0.00"));
                                parentUser.setBonusWallet(wallet);
                            }
                            BigDecimal newUSDBonus = order.getAmount().multiply(GlobalConfig.bonusProcentForReferal);
                            parentUser.getBonusWallet().setUsdBonus(user.getBonusWallet().getUsdBonus().add(newUSDBonus));
                            userRepository.save(parentUser);
                            log.info("реферальные бонусы начислены пригласителю" +parentUser);
                            System.out.println("реферальные бонусы начислены пригласителю" +parentUser);
                        });
                    }
                });

        }

    }
    @GetMapping("/succes_payment")
    public RedirectView succesPay(RedirectAttributes redirectAttributes,
                                  @RequestParam("ac_order_id") String orderId){
        redirectAttributes.addAttribute("paidOrder",orderId);
        return new RedirectView("/lk");
    }
    @GetMapping("/fail_payment")
    public RedirectView failPay(RedirectAttributes redirectAttributes,
                                  @RequestParam("ac_order_id") String orderId){
        redirectAttributes.addAttribute("failPaidOrder",orderId);
        return new RedirectView("/lk");
    }
}
