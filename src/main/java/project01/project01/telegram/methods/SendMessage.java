package project01.project01.telegram.methods;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import project01.project01.telegram.ResponseForTelegram;

@JsonInclude(JsonInclude.Include.NON_NULL)
public class SendMessage extends ResponseForTelegram {
    @JsonProperty("chat_id")
    private Integer chatId;
    private String text;
    @JsonProperty("parse_mode")
    private String parseMode;
    @JsonProperty("disable_web_page_preview")
    private Boolean disableWebPagePreview;
    @JsonProperty("disable_notification")
    private Boolean disableNotification;
    @JsonProperty("reply_to_message_id")
    private Integer replytoMessageId;
    @JsonProperty("reply_markup")
    private KeyboardMarkup replyMarkup;

    public SendMessage() {
    }

    public SendMessage(Integer chatId, String text) {
        this.chatId = chatId;
        this.text = text;
    }

    @Override
    public String toString() {
        return "SendMessage{" +
                "chatId=" + chatId +
                ", text='" + text + '\'' +
                ", parseMode='" + parseMode + '\'' +
                ", disableWebPagePreview=" + disableWebPagePreview +
                ", disableNotification=" + disableNotification +
                ", replytoMessageId=" + replytoMessageId +
                ", replyMarkup=" + replyMarkup +
                '}';
    }

    public Integer getChatId() {
        return chatId;
    }

    public void setChatId(Integer chatId) {
        this.chatId = chatId;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getParseMode() {
        return parseMode;
    }

    public void setParseMode(String parseMode) {
        this.parseMode = parseMode;
    }

    public Boolean getDisableWebPagePreview() {
        return disableWebPagePreview;
    }

    public void setDisableWebPagePreview(Boolean disableWebPagePreview) {
        this.disableWebPagePreview = disableWebPagePreview;
    }

    public Boolean getDisableNotification() {
        return disableNotification;
    }

    public void setDisableNotification(Boolean disableNotification) {
        this.disableNotification = disableNotification;
    }

    public Integer getReplytoMessageId() {
        return replytoMessageId;
    }

    public void setReplytoMessageId(Integer replytoMessageId) {
        this.replytoMessageId = replytoMessageId;
    }

    public KeyboardMarkup getReplyMarkup() {
        return replyMarkup;
    }

    public void setReplyMarkup(KeyboardMarkup replyMarkup) {
        this.replyMarkup = replyMarkup;
    }
}
