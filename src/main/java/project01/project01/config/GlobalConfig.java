package project01.project01.config;

import java.math.BigDecimal;
import java.nio.file.Path;
import java.nio.file.Paths;

public class GlobalConfig {
    public static final Path pathUsersFiles = Paths.get("src/homeworkfiles/");
    public static final String siteUrl = "https://potvneskazut.ru";
    public static final BigDecimal bonusProcentForPayment = new BigDecimal("0.10");
    public static final BigDecimal bonusProcentForReferal = new BigDecimal("0.10");
    public static final String CodWord = "C0d0v0eSl0v0";
    public static final String BOT_API_URL = "https://api.telegram.org/bot653179705:AAHdEivXVAZU2yMpjGKgd5hBJaHKzIbw5ak";
    public static final String BOT_LINK="http://t.me/signals_potv_bot";
    public static final String CODOVOE_SLOVO="C0d0v0eSl0v0";

    public static final String SIGNALS_1 ="50";
    public static final String SIGNALS_2 ="100";
    public static final String SIGNALS_3 ="150";
    public static final String TRAINING ="200";

}
