package project01.project01.telegram.tx_objects;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;

@JsonInclude(JsonInclude.Include.NON_NULL)
public class AnswerCallbackQuery {
    @JsonProperty("callback_query_id")
    private String callbackQueryId;
    private String text;
    @JsonProperty("show_alert")
    private Boolean showAlert;
    private String url;
    @JsonProperty("cache_time")
    private Integer cashTime=60;

    public AnswerCallbackQuery() {
    }



    public AnswerCallbackQuery(String callbackQueryId, String text) {
        this.callbackQueryId = callbackQueryId;
        this.text = text;
    }

    public String getCallbackQueryId() {
        return callbackQueryId;
    }

    public void setCallbackQueryId(String callbackQueryId) {
        this.callbackQueryId = callbackQueryId;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public Boolean getShowAlert() {
        return showAlert;
    }

    public void setShowAlert(Boolean showAlert) {
        this.showAlert = showAlert;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Integer getCashTime() {
        return cashTime;
    }

    public void setCashTime(Integer cashTime) {
        this.cashTime = cashTime;
    }
}
