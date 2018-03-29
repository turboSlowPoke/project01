package project01.project01.telegram.commands;

public enum MainCommand {
    START("/start"),

    SIGNALS("Сигналы"),
    TRAINING("Обучение"),
    REFERALS_PROG("Реферальная программа"),
    SUBSCRIPTIONS("Подписка"),
    ACCAUNT("Аккаунт"),
    //mainmenu


    FAIL("Неизвестная команда");

    MainCommand(String text) {
        this.text = text;
    }

    private String text;

    public String getText() {
        return text;
    }

    public static MainCommand getTYPE(String s){
        MainCommand type = FAIL;
        for (MainCommand tempTYPE : MainCommand.values()){
            if (s.equals(tempTYPE.getText()))
                type = tempTYPE;
        }
        return type;
    }
}
