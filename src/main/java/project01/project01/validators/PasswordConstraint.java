package project01.project01.validators;

import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.*;

@Documented
@Constraint(validatedBy = PasswordValidatorConstarint.class)
@Target({ElementType.METHOD,ElementType.FIELD,ElementType.PARAMETER})
@Retention(RetentionPolicy.RUNTIME)
public @interface PasswordConstraint {
    String message() default "Некоректный пароль";
    Class<?>[] groups() default {};
    Class<? extends Payload>[] payload() default {};
}
