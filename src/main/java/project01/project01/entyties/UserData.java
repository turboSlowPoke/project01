package project01.project01.entyties;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class UserData {
    @Id @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;
    private String email;
    private String telegramNikcName;
    private String firstName;
    private String lastName;
    private String advcash;

    @Override
    public String toString() {
        return "UserData{" +
                "id=" + id +
                ", email='" + email + '\'' +
                ", telegramNikcName='" + telegramNikcName + '\'' +
                ", firstName='" + firstName + '\'' +
                ", lastName='" + lastName + '\'' +
                '}';
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTelegramNikcName() {
        return telegramNikcName;
    }

    public void setTelegramNikcName(String telegramNikcName) {
        this.telegramNikcName = telegramNikcName;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getAdvcash() {
        return advcash;
    }

    public void setAdvcash(String advcash) {
        this.advcash = advcash;
    }
}
