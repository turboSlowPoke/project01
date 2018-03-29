package project01.project01.telegram.tx_objects;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.List;
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ReplyKeyboardMarkup extends KeyboardMarkup {
    @JsonProperty("keyboard")
    private List<List<KeyboardButton>> buttonList;
    @JsonProperty("resize_keyboard")
    private Boolean resize=true;
    @JsonProperty("one_time_keyboard")
    private Boolean oneTime;
    private Boolean selective;

    public ReplyKeyboardMarkup() {
    }

    public ReplyKeyboardMarkup(List<List<KeyboardButton>> buttonList) {
        this.buttonList=buttonList;
    }

    public List<List<KeyboardButton>> getButtonList() {
        return buttonList;
    }

    public void setButtonList(List<List<KeyboardButton>> buttonList) {
        this.buttonList = buttonList;
    }

    public Boolean getResize() {
        return resize;
    }

    public void setResize(Boolean resize) {
        this.resize = resize;
    }

    public Boolean getOneTime() {
        return oneTime;
    }

    public void setOneTime(Boolean oneTime) {
        this.oneTime = oneTime;
    }

    public Boolean getSelective() {
        return selective;
    }

    public void setSelective(Boolean selective) {
        this.selective = selective;
    }
}
