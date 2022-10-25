package br.com.corneta.validator;

import br.com.corneta.domain.Bet;
import br.com.genericcrud.validator.AbstractValidator;
import org.springframework.stereotype.Component;

@Component
public class BetValidator extends AbstractValidator<Bet, Long> {
    @Override
    public void validateExistent(Bet abstractEntity) {

    }

    @Override
    public String getValidatorName() {
        return null;
    }
}
