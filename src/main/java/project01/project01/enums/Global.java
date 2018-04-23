package project01.project01.enums;

public enum Global {
    BOT_LINK("https://t.me/tradebeepbot"),
    COD_WORD("C0d0v0eSl0v0"),
    //текс в полях с услугами
    SIGNALS01("Сигналы 1 месяц"),
    SIGNALS02("Сигналы 2 месяца"),
    SIGNALS03("Сигналы 3 месяца"),
    TRAINING01("Обучение 1 месяц"),
    TRAINING02("Обучение 2 месяца"),
    TRAINING03("Обучение 3 месяца"),
    //mainmenu


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
