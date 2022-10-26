package br.com.corneta.translator;

import br.com.corneta.domain.Match;
import br.com.corneta.domain.dto.MatchDTO;
import org.springframework.stereotype.Service;

@Service
public class MatchTranslator {

    private final TeamTranslator teamTranslator;

    public MatchTranslator(TeamTranslator teamTranslator) {
        this.teamTranslator = teamTranslator;
    }

    public MatchDTO toDTO(Match match) {
        return MatchDTO.builder()
                .id(match.getId())
                .homeTeamDTO(teamTranslator.toDTO(match.getHomeTeam()))
                .visitingTeamDTO(teamTranslator.toDTO(match.getVisitingTeam()))
                .gameDate(match.getGameDate())
                .round(match.getRound().getName())
                .build();
    }

}
