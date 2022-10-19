package br.com.corneta.service;

import br.com.corneta.domain.dto.TeamDTO;
import br.com.corneta.repository.TeamRepository;
import br.com.corneta.translator.TeamTranslator;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class TeamService {

    private final TeamRepository teamRepository;

    private final TeamTranslator teamTranslator;

    public TeamService(TeamRepository teamRepository, TeamTranslator teamTranslator) {
        this.teamRepository = teamRepository;
        this.teamTranslator = teamTranslator;
    }

    public List<TeamDTO> getAll() {
        return teamRepository.findAll()
                .stream()
                .map(teamTranslator::toDTO)
                .collect(Collectors.toList());

    }
}
