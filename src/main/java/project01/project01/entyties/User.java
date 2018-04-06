package project01.project01.entyties;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.Set;

@Entity
public class User {
    @Id @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;
    private String login;
    private String password;
    @Column(unique = true)
    private Integer telegramChatId;
    @OneToOne(cascade = CascadeType.ALL)
    private UserData userData;
    @OneToOne(cascade = CascadeType.ALL)
    private Subscribe subsribe;
    private LocalDateTime startDate;
    @OneToOne(cascade = CascadeType.ALL)
    private Referal referal;
    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinTable(name = "user_role", joinColumns = @JoinColumn(name = "user_id"), inverseJoinColumns = @JoinColumn(name = "role_id"))
    private Set<Role> roles;

    public User() {
    }

    public User(Integer telegramChatId) {
        this.telegramChatId=telegramChatId;
        this.startDate = LocalDateTime.now();
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", login='" + login + '\'' +
                ", password='" + password + '\'' +
                ", telegramChatId=" + telegramChatId +
                '}';
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Integer getTelegramChatId() {
        return telegramChatId;
    }

    public void setTelegramChatId(Integer telegramChatId) {
        this.telegramChatId = telegramChatId;
    }

    public UserData getUserData() {
        return userData;
    }

    public void setUserData(UserData userData) {
        this.userData = userData;
    }

    public Subscribe getSubsribe() {
        return subsribe;
    }

    public void setSubsribe(Subscribe subsribe) {
        this.subsribe = subsribe;
    }

    public LocalDateTime getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDateTime startDate) {
        this.startDate = startDate;
    }

    public Referal getReferal() {
        if (this.referal==null)
            this.referal=new Referal();
        return referal;
    }

    public void setReferal(Referal referal) {
        this.referal = referal;
    }

    public Set<Role> getRoles() {
        return roles;
    }

    public void setRoles(Set<Role> roles) {
        this.roles = roles;
    }
}
