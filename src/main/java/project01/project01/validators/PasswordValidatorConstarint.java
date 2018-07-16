package project01.project01.validators;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

public class PasswordValidatorConstarint implements ConstraintValidator<PasswordConstraint,String> {

    @Override
    public void initialize(PasswordConstraint constraintAnnotation) {
    }

    @Override
    public boolean isValid(String password, ConstraintValidatorContext context) {
        if (password!=null
                &&!password.isEmpty()
                &&password.length()>6
                &&password.length()<100){
            return true;
        }
        else {
            return false;
        }
    }
}
