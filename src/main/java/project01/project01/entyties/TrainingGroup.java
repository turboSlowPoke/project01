package project01.project01.entyties;

import javax.persistence.*;
import java.time.LocalDate;
import java.util.List;

@Entity
public class TrainingGroup {
    @Id @GeneratedValue
    private Integer id;
    private String name;
    private LocalDate startTraining;
    private LocalDate endTraining;
    @OneToMany(cascade = CascadeType.ALL)
    @JoinColumn(name = "TRAINING_GROUP_ID")
    private List<Webinar> webinars;
    @OneToMany(mappedBy = "trainingGroup")
    private List<User> users;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

    public List<User> getUsers() {
        return users;
    }

    public void setUsers(List<User> users) {
        this.users = users;
    }
}
