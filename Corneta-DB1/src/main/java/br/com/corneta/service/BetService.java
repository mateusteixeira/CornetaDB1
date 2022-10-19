package br.com.corneta.service;

import br.com.corneta.domain.Bet;
import br.com.corneta.domain.dto.BetDTO;
import br.com.genericcrud.repository.IJpaRepository;
import br.com.genericcrud.service.AbstractService;
import br.com.genericcrud.translator.AbstractTranslator;
import br.com.genericcrud.validator.AbstractValidator;
import org.springframework.stereotype.Service;

@Service
public class BetService extends AbstractService <Bet, Long, BetDTO> {

    public BetService(AbstractValidator<Bet, Long> abstractValidator, IJpaRepository<Bet, Long> abstractRepository, AbstractTranslator<Bet, Long, BetDTO> abstractTranslator) {
        super(abstractValidator, abstractRepository, abstractTranslator);
    }
}
