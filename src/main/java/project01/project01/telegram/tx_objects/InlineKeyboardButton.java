package project01.project01.telegram.tx_objects;

import com.fasterxml.jackson.annotation.JsonProperty;

public class InlineKeyboardButton {
    private String text;
    private String url;
    @JsonProperty("callback_data")
    private String callbackData;
    @JsonProperty("switch_inline_query")
    private String switchInlineQuery;
    @JsonProperty("switch_inline_query_current_chat")
    private String switchInlineQueryCurrentChat;
}
