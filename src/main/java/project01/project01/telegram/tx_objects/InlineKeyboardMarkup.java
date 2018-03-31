package project01.project01.telegram.tx_objects;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.List;
@JsonInclude(JsonInclude.Include.NON_NULL)
public class InlineKeyboardMarkup extends KeyboardMarkup {
    @JsonProperty("inline_keyboard")
    List<List<InlineKeyboardButton>> inlineKeyBoard;

    public InlineKeyboardMarkup(List<List<InlineKeyboardButton>> inlineKyeBoard) {
        this.inlineKeyBoard=inlineKyeBoard;
    }
}
