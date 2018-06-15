package project01.project01.config;

import java.math.BigDecimal;
import java.nio.file.Path;
import java.nio.file.Paths;

public class GlobalConfig {
    public static final Path pathUsersFiles = Paths.get("src/homeworkfiles/");
    public static final String siteUrl = "https://sandbox.dorado.su";
    public static final BigDecimal bonusProcentForPayment = new BigDecimal("0.10");
    public static final BigDecimal bonusProcentForReferal = new BigDecimal("0.10");
    public static final String CodWord = "C0d0v0eSl0v0";
}
