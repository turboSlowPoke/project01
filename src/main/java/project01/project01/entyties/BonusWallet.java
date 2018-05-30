package project01.project01.entyties;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import java.math.BigDecimal;

@Entity
public class BonusWallet {
    @Id @GeneratedValue
    private Integer id;
    private BigDecimal usdBonus;
    private BigDecimal candyWrapers;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public BigDecimal getUsdBonus() {
        return usdBonus;
    }

    public void setUsdBonus(BigDecimal usdBonus) {
        this.usdBonus = usdBonus;
    }

    public BigDecimal getCandyWrapers() {
        return candyWrapers;
    }

    public void setCandyWrapers(BigDecimal candyWrapers) {
        this.candyWrapers = candyWrapers;
    }
}
