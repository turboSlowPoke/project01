package project01.project01.entyties;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import java.time.LocalDateTime;

@Entity
public class Training {
    @Id @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;
    private LocalDateTime dateOfCreation;
    private LocalDateTime webinarDate;
    private String header;
    private String urlWebinarRoom;
    private Boolean active;

    public Training() {
    }

    public Training(LocalDateTime webinarDate, String header, String urlWebinarRoom) {
        this.webinarDate = webinarDate;
        this.header = header;
        this.urlWebinarRoom = urlWebinarRoom;
        this.active=true;
        this.dateOfCreation= LocalDateTime.now();
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public LocalDateTime getDateOfCreation() {
        return dateOfCreation;
    }

    public void setDateOfCreation(LocalDateTime dateOfCreation) {
        this.dateOfCreation = dateOfCreation;
    }

    public LocalDateTime getWebinarDate() {
        return webinarDate;
    }

    public void setWebinarDate(LocalDateTime webinarDate) {
        this.webinarDate = webinarDate;
    }

    public String getHeader() {
        return header;
    }

    public void setHeader(String header) {
        this.header = header;
    }

    public String getUrlWebinarRoom() {
        return urlWebinarRoom;
    }

    public void setUrlWebinarRoom(String urlWebinarRoom) {
        this.urlWebinarRoom = urlWebinarRoom;
    }

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }
}
