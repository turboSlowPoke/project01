package project01.project01.entyties;

import javax.persistence.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Entity
public class TrainingGroup {
    @Id @GeneratedValue
    private Integer id;
    private String name;
    private LocalDate startSet;
    private LocalDate endSet;
    @OneToMany(cascade = CascadeType.ALL)
    private List<Webinar> webinars;
    @ManyToMany
    private List<User> users;
    @ManyToOne (cascade = CascadeType.ALL)
    private Course course;
    @OneToMany(cascade = CascadeType.ALL)
    private List<Homework> homeworkList;
    private String telegramName;

    @Override
    public String toString() {
        return "TrainingGroup{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", startSet=" + startSet +
                ", endSet=" + endSet +
                '}';
    }

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

    public LocalDate getStartSet() {
        return startSet;
    }

    public void setStartSet(LocalDate startSet) {
        this.startSet = startSet;
    }

    public LocalDate getEndSet() {
        return endSet;
    }

    public void setEndSet(LocalDate endSet) {
        this.endSet = endSet;
    }

    public Course getCourse() {
        return course;
    }

    public void setCourse(Course course) {
        this.course = course;
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

    public List<Homework> getHomeworkList() {
        return homeworkList;
    }

    public void setHomeworkList(List<Homework> homeworkList) {
        this.homeworkList = homeworkList;
    }

    public String getTelegramName() {
        return telegramName;
    }

    public void setTelegramName(String telegramName) {
        this.telegramName = telegramName;
    }
}
