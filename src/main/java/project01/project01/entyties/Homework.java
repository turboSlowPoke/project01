package project01.project01.entyties;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

@Entity
public class Homework {
    @Id @GeneratedValue
    private Integer id;
    private String name;
    @Lob
    private String body;
    private LocalDateTime dateTimeOfCreation;
    private LocalDateTime dateTimeVerification;
    private Integer rating;
    private Boolean cheked=false;
    @ElementCollection(targetClass = String.class)
    private List<String> files;
    @ManyToOne
    private User user;
    @ManyToOne
    private TrainingGroup trainingGroup;

    @Override
    public String toString() {
        return "Homework{" +
                "id=" + id +
                ", dateTimeOfCreation=" + dateTimeOfCreation +
                ", dateTimeVerification=" + dateTimeVerification +
                ", rating=" + rating +
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

    public LocalDateTime getDateTimeOfCreation() {
        return dateTimeOfCreation;
    }

    public void setDateTimeOfCreation(LocalDateTime dateTimeOfCreation) {
        this.dateTimeOfCreation = dateTimeOfCreation;
    }

    public LocalDateTime getDateTimeVerification() {
        return dateTimeVerification;
    }

    public void setDateTimeVerification(LocalDateTime dateTimeVerification) {
        this.dateTimeVerification = dateTimeVerification;
    }

    public Integer getRating() {
        return rating;
    }

    public void setRating(Integer rating) {
        this.rating = rating;
    }

    public Boolean getCheked() {
        return cheked;
    }

    public List<String> getFiles() {
        return files;
    }

    public void setCheked(Boolean cheked) {
        this.cheked = cheked;
    }

    public void setFiles(List<String> files) {
        this.files = files;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public TrainingGroup getTrainingGroup() {
        return trainingGroup;
    }

    public void setTrainingGroup(TrainingGroup trainingGroup) {
        this.trainingGroup = trainingGroup;
    }

    public String getBody() {
        return body;
    }

    public void setBody(String body) {
        this.body = body;
    }
}
