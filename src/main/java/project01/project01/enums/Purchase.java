package project01.project01.enums;

public enum Purchase {
    SIGNALS01("signals01"),
    SIGNALS02("signals02"),
    SIGNALS03("signals03"),
    TRAINING01("training01"),
    TRAINING02("training02"),
    TRAINING03("training03"),
    //mainmenu


    FAIL("Неизвестная покупка");

    Purchase(String text) {
        this.text = text;
    }

    private String text;

    public String getText() {
        return text;
    }

    public static Purchase getTYPE(String s){
        Purchase type = FAIL;
        for (Purchase tempTYPE : Purchase.values()){
            if (s.equals(tempTYPE.getText()))
                type = tempTYPE;
        }
        return type;
    }
}
