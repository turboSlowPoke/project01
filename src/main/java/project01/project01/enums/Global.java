package project01.project01.enums;

public enum Global {
    BOT_LINK("https://t.me/tradebeepbot"),
    COD_WORD("C0d0v0eSl0v0"),
    WEBSITE_LINK("https://sandbox.dorado.su"),
    BOT_URL("https://api.telegram.org/bot376651530:AAH-aBiEkS_tezghZxNLTEi1ypnuXdbl-5M"),
    //nmenu


    FAIL("Неизвестная команда");

    Global(String text) {
        this.text = text;
    }

    private String text;

    public String getText() {
        return text;
    }

    public static Global getTYPE(String s){
        Global type = FAIL;
        for (Global tempTYPE : Global.values()){
            if (s.equals(tempTYPE.getText()))
                type = tempTYPE;
        }
        return type;
    }
}
