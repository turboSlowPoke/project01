package project01.project01.entyties;

import javax.persistence.Entity;
import javax.persistence.Id;
import java.time.LocalDate;

@Entity
public class Subsribe {
    @Id
    private Integer id;
    private LocalDate endOfSignal;
    private LocalDate endOfTraining;
}
