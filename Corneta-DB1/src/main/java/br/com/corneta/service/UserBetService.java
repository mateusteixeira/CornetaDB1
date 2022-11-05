package br.com.corneta.service;

import br.com.corneta.domain.Bet;
import br.com.corneta.domain.User;
import br.com.corneta.domain.UserBet;
import br.com.corneta.domain.dto.UserBetDTO;
import br.com.corneta.repository.UserBetRepository;
import br.com.corneta.translator.UserBetTranslator;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
public class UserBetService {

    private final UserBetRepository userBetRepository;

    private final UserBetTranslator userBetTranslator;

    public UserBetService(UserBetRepository userBetRepository, UserBetTranslator userBetTranslator) {
        this.userBetRepository = userBetRepository;
        this.userBetTranslator = userBetTranslator;
    }

    public UserBetDTO createBetForUser(UserBetDTO userBetDTO, User user, Bet bet) {
        UserBet userBet = UserBet.builder()
                .bet(bet)
                .user(user)
                .betDate(LocalDateTime.now())
                .guessHomeTeam(userBetDTO.getGuessHomeTeam())
                .guessVisitingTeam(userBetDTO.getGuessVisitingTeam())
                .discountFromWallet(userBetDTO.isDiscountFromWallet())
                .betMade(true)
                .betMadeDate(LocalDateTime.now())
                .build();
        userBet = userBetRepository.save(userBet);
        return userBetTranslator.toDTO(userBet);
    }

    public UserBetDTO doEffect(User user, Bet bet) {
        UserBet userBet = userBetRepository.findByUserAndBet(user, bet);
        userBet.setBetMade(true);
        userBet.setBetMadeDate(LocalDateTime.now());
        userBet = userBetRepository.save(userBet);
        return userBetTranslator.toDTO(userBet);
    }

    public UserBetDTO getUserBetDTO(User user, Bet bet) {
        UserBet userBet = userBetRepository.findByUserAndBet(user, bet);
        return userBetTranslator.toDTO(userBet);
    }
}
