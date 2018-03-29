package project01.project01.entyties;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Referal {
    @Id @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;
    private Integer numberOfReferals=0;
    private Integer numerOfReferalsPayments=0;
    private Integer parentUserId;

    public Referal() {
    }

    public Referal(Integer parentUserId) {
        this.parentUserId=parentUserId;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getNumberOfReferals() {
        return numberOfReferals;
    }

    public void setNumberOfReferals(Integer numberOfReferals) {
        this.numberOfReferals = numberOfReferals;
    }

    public Integer getNumerOfReferalsPayments() {
        return numerOfReferalsPayments;
    }

    public void setNumerOfReferalsPayments(Integer numerOfReferalsPayments) {
        this.numerOfReferalsPayments = numerOfReferalsPayments;
    }

    public Integer getParentUserId() {
        return parentUserId;
    }

    public void setParentUserId(Integer parentUserId) {
        this.parentUserId = parentUserId;
    }

    public void plusOneReferal(){
        this.numberOfReferals++;
    }
}
