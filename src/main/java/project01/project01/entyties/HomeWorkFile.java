package project01.project01.entyties;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import java.nio.file.Path;

@Entity
public class HomeWorkFile {
    @Id @GeneratedValue
    private Integer id;
    private String path;

    public HomeWorkFile(Path resolve) {

    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }
}
