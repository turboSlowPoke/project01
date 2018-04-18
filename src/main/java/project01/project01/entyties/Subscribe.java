package project01.project01.entyties;

import javax.persistence.*;
import java.time.LocalDate;
@Entity
public class Subscribe {
    @Id @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;
    private LocalDate endOfSignal;

    public Subscribe() {
    }

    public Subscribe(LocalDate endOfSignal, LocalDate endOfTraining) {
        this.endOfSignal =endOfSignal;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public LocalDate getEndOfSignal() {
        return endOfSignal;
    }

    public void setEndOfSignal(LocalDate endOfSignal) {
        this.endOfSignal = endOfSignal;
    }

}
