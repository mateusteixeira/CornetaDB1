package br.com.corneta.translator;

import br.com.corneta.domain.Match;
import br.com.corneta.domain.UserBet;
import br.com.corneta.domain.dto.MatchDTO;
import br.com.corneta.domain.dto.UserBetDTO;
import org.springframework.stereotype.Service;

@Service
public class UserBetTranslator {

    private final TeamTranslator teamTranslator;

    public UserBetTranslator(TeamTranslator teamTranslator) {
        this.teamTranslator = teamTranslator;
    }

    public UserBetDTO toDTO(UserBet userBet) {
        return UserBetDTO.builder()
                .guessHomeTeam(userBet.getGuessHomeTeam())
                .guessVisitingTeam(userBet.getGuessVisitinTeam())
                .betMade(userBet.getBetMade())
                .betDate(userBet.getBetDate())
                .betMadeDate(userBet.getBetMateDate())
                .discountFromWallet(userBet.getDiscountFromWallet())
                .build();

    }

}
