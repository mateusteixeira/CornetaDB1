package br.com.corneta.service;

import br.com.corneta.domain.Bet;
import br.com.corneta.domain.User;
import br.com.corneta.domain.dto.BetDTO;
import br.com.corneta.domain.dto.UserBetDTO;
import br.com.corneta.exception.BetNotFoundException;
import br.com.corneta.repository.BetRepository;
import br.com.corneta.translator.BetTranslator;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class BetService {

    private final UserService userService;

    private final BetRepository betRepository;

    private final BetTranslator betTranslator;

    private final UserBetService userBetService;

    public BetService(BetRepository betRepository, BetTranslator betTranslator, UserService userService, UserBetService userBetService) {
        this.betRepository = betRepository;
        this.betTranslator = betTranslator;
        this.userService = userService;
        this.userBetService = userBetService;
    }

    public List<BetDTO> getAll() {
        return betRepository.findAll().stream().map(betTranslator::toDTO).collect(Collectors.toList());
    }

    public UserBetDTO doBetForUser(UserBetDTO userBetDTO, Long idBet, Long idUser) {
        User user = userService.getAbstractOrThrowNotFoundException(idUser);
        Bet bet = betRepository.findById(idBet).orElseThrow(() -> new BetNotFoundException("Bet Not Found"));
        return userBetService.createBetForUser(userBetDTO, user, bet);
    }

    public UserBetDTO doEffect(Long idBet, Long idUser) {
        User user = userService.getAbstractOrThrowNotFoundException(idUser);
        Bet bet = betRepository.findById(idBet).orElseThrow(() -> new BetNotFoundException("Bet Not Found"));
        return userBetService.doEffect(user, bet);
    }
}
