package project01.project01.telegram.commands;

public enum MainCommand {
    START("/start"),

    BOTTOM011("кнопка 1.1"),
    BOTOOM012("конка 1.2"),
    BOTTOM021("кнопка 2.1"),
    BOTTOM022("кнопка 2.2"),
    BOTTOM031("Кнопка 3.1"),
    //mainmenu
    SIGNALS("Сигналы"),
    NEWS("Новости"),
    CHAT("Чат"),
    SUBSCRIBE("Подписка"),
    REFERALPROG("Реферальная программа"),
    //подписка
    SUBSCRIPTION1("Месяц 50$"),
    SUBSCRIPTION2("Три месяца 120$"),
    SUBSCRIPTION3("Шесть месяцев 200$"),

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
