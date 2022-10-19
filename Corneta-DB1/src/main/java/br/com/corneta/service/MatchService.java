package br.com.corneta.service;

import br.com.corneta.domain.dto.MatchDTO;
import br.com.corneta.repository.MatchRepository;
import br.com.corneta.translator.MatchTranslator;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class MatchService {

    private final MatchRepository matchRepository;

    private final MatchTranslator matchTranslator;

    public MatchService(MatchRepository matchRepository, MatchTranslator matchTranslator) {
        this.matchRepository = matchRepository;
        this.matchTranslator = matchTranslator;
    }

    public List<MatchDTO> getAll() {
        return matchRepository.findAll()
                .stream()
                .map(matchTranslator::toDTO)
                .collect(Collectors.toList());

    }
}
