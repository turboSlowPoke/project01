package project01.project01.enums;

public enum PaidServices {
    SIGNALS01("signals01"),
    SIGNALS02("signals02"),
    SIGNALS03("signals03"),
    TRAINING01("training01"),
    TRAINING02("training02"),
    TRAINING03("training03"),
    //mainmenu


    FAIL("Неизвестная команда");

    PaidServices(String text) {
        this.text = text;
    }

    private String text;

    public String getText() {
        return text;
    }

    public static PaidServices getTYPE(String s){
        PaidServices type = FAIL;
        for (PaidServices tempTYPE : PaidServices.values()){
            if (s.equals(tempTYPE.getText()))
                type = tempTYPE;
        }
        return type;
    }
}
