package project01.project01.entyties;

import javax.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Entity
public class Training {
    @Id @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;
   // @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    //private List<User> students;
    private LocalDate startTraining;
    private LocalDate endTraining;
    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private List<Webinar> webinars;
    private Boolean active;

    public Training() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }


    public LocalDate getStartTraining() {
        return startTraining;
    }

    public void setStartTraining(LocalDate startTraining) {
        this.startTraining = startTraining;
    }

    public LocalDate getEndTraining() {
        return endTraining;
    }

    public void setEndTraining(LocalDate endTraining) {
        this.endTraining = endTraining;
    }

    public List<Webinar> getWebinars() {
        return webinars;
    }

    public void setWebinars(List<Webinar> webinars) {
        this.webinars = webinars;
    }
}
