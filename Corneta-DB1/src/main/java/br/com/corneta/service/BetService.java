package br.com.corneta.service;

import br.com.corneta.domain.dto.BetDTO;
import br.com.corneta.repository.BetRepository;
import br.com.corneta.translator.BetTranslator;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class BetService {

    private final BetRepository betRepository;

    private final BetTranslator  betTranslator;

    public BetService(BetRepository betRepository, BetTranslator betTranslator) {
        this.betRepository = betRepository;
        this.betTranslator = betTranslator;
    }

    public List<BetDTO> getAll() {
        return betRepository.findAll().stream().map(betTranslator::toDTO).collect(Collectors.toList());
    }
}
