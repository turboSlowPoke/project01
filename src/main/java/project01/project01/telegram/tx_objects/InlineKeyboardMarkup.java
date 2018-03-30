package project01.project01.telegram.tx_objects;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.List;

public class InlineKeyboardMarkup extends KeyboardMarkup {
    @JsonProperty("inline_keyboard")
    List<List<InlineKeyboardButton>> inlineKeyBoard;
}
