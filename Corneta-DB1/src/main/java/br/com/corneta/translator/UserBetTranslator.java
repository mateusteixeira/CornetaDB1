package br.com.corneta.translator;

import br.com.corneta.domain.Match;
import br.com.corneta.domain.dto.MatchDTO;
import org.springframework.stereotype.Service;

@Service
public class UserBetTranslator {

    private final TeamTranslator teamTranslator;

    public UserBetTranslator(TeamTranslator teamTranslator) {
        this.teamTranslator = teamTranslator;
    }

    public Match toEntity(MatchDTO matchDTO) {
        return Match.builder()
                .homeTeam(teamTranslator.toEntity(matchDTO.getHomeTeamDTO()))
                .visitingTeam(teamTranslator.toEntity(matchDTO.getVisitingTeamDTO()))
                .gameDate(matchDTO.getGameDate())
                .round(matchDTO.getRound())
                .build();
    }

    public MatchDTO toDTO(Match match) {
        return MatchDTO.builder()
                .id(match.getId())
                .homeTeamDTO(teamTranslator.toDTO(match.getHomeTeam()))
                .visitingTeamDTO(teamTranslator.toDTO(match.getVisitingTeam()))
                .gameDate(match.getGameDate())
                .round(match.getRound())
                .build();
    }

}
