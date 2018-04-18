package project01.project01.entyties;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import java.time.LocalDateTime;

@Entity
public class Webinar {
    @Id @GeneratedValue
    private Integer id;
    private String urlWebinarRoom;
    private String name;
    private LocalDateTime dateTime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUrlWebinarRoom() {
        return urlWebinarRoom;
    }

    public void setUrlWebinarRoom(String urlWebinarRoom) {
        this.urlWebinarRoom = urlWebinarRoom;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public LocalDateTime getDateTime() {
        return dateTime;
    }

    public void setDateTime(LocalDateTime dateTime) {
        this.dateTime = dateTime;
    }
}
