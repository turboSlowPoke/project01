package project01.project01.entyties;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import java.time.LocalDate;
@Entity
public class Subscribe {
    @Id @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;
    private LocalDate endOfSignal;
    private LocalDate endOfTraining;

    public Subscribe() {
    }

    public Subscribe(LocalDate endOfSignal, LocalDate endOfTraining) {
        this.endOfSignal =endOfSignal;
        this.endOfTraining = endOfTraining;
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

    public LocalDate getEndOfTraining() {
        return endOfTraining;
    }

    public void setEndOfTraining(LocalDate endOfTraining) {
        this.endOfTraining = endOfTraining;
    }
}
