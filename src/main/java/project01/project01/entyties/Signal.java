package project01.project01.entyties;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "signals")
public class Signal {
    @Id @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;
    private LocalDateTime dateTime;
    private String header;
    @Lob
    private String body;

    public Signal() {
    }

    public Signal(String header, String body) {
        this.header = header;
        this.body = body;
        this.dateTime=LocalDateTime.now();
    }

    public Signal(String heder, String body, LocalDateTime dateTime) {
        this.dateTime=dateTime;
        this.header=heder;
        this.body=body;
    }

    @Override
    public String toString() {
        return "Signal{" +
                "id=" + id +
                ", dateTime=" + dateTime +
                ", header='" + header + '\'' +
                ", body='" + body + '\'' +
                '}';
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public LocalDateTime getDateTime() {
        return dateTime;
    }

    public void setDateTime(LocalDateTime dateTime) {
        this.dateTime = dateTime;
    }

    public String getHeader() {
        return header;
    }

    public void setHeader(String header) {
        this.header = header;
    }

    public String getBody() {
        return body;
    }

    public void setBody(String body) {
        this.body = body;
    }
}
