package br.com.corneta.validator;

import br.com.corneta.domain.User;
import br.com.genericcrud.validator.AbstractValidator;
import org.springframework.stereotype.Component;

@Component
public class UserValidator extends AbstractValidator<User, Long> {
    @Override
    public void validateExistent(User abstractEntity) {

    }

    @Override
    public String getValidatorName() {
        return null;
    }
}
