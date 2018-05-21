package project01.project01.entyties;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "orders")
public class Order {
    @Id @GeneratedValue
    private Integer id;
    private LocalDateTime dateTime;
    private BigDecimal amount;
    private String comment;
    private String purch;
    private Boolean isPaid = false;

    @Override
    public String toString() {
        return "Order{" +
                "id=" + id +
                ", dateTime=" + dateTime +
                ", amount=" + amount +
                ", comment='" + comment + '\'' +
                ", status='" + isPaid + '\'' +
                '}';
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public LocalDateTime getDateTime() {
        return dateTime;
    }

    public void setDateTime(LocalDateTime dateTime) {
        this.dateTime = dateTime;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Boolean getPaid() {
        return isPaid;
    }

    public void setPaid(Boolean paid) {
        isPaid = paid;
    }

    public String getPurch() {
        return purch;
    }

    public void setPurch(String purch) {
        this.purch = purch;
    }
}
