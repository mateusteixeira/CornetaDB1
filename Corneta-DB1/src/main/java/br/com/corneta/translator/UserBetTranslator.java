package br.com.corneta.translator;

import br.com.corneta.domain.UserBet;
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
                .id(userBet.getId())
                .guessHomeTeam(userBet.getGuessHomeTeam())
                .guessVisitingTeam(userBet.getGuessVisitingTeam())
                .betMade(userBet.isBetMade())
                .betDate(userBet.getBetDate())
                .betMadeDate(userBet.getBetMadeDate())
                .discountFromWallet(userBet.isDiscountFromWallet())
                .build();

    }

}
