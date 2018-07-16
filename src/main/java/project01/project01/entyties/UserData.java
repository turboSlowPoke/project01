package project01.project01.entyties;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.validation.constraints.Email;
import javax.validation.constraints.Size;

@Entity
public class UserData {
    @Id @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;
    @Email
    private String email;
    @Size(min = 5,max = 100,message = "Telegram @username mast be between 5 and 100 characters")
    private String telegramNikcName;
    @Size(min = 1,max = 100,message = "First name mast be between 1 and 100 characters")
    private String firstName;
    @Size(min = 1,max = 100,message = "Last name mast be between 1 and 100 characters")
    private String lastName;
    @Size(min = 1,max = 100,message = "Advcash wallet mast be between 12 and 20 characters")
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
