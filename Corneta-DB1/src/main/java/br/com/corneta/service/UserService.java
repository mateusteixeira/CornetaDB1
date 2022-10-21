package br.com.corneta.service;

import br.com.corneta.domain.Bet;
import br.com.corneta.domain.User;
import br.com.corneta.domain.UserBet;
import br.com.corneta.domain.dto.BetDTO;
import br.com.corneta.domain.dto.UserBetDTO;
import br.com.corneta.domain.dto.UserDTO;
import br.com.corneta.translator.BetTranslator;
import br.com.corneta.translator.UserBetTranslator;
import br.com.corneta.translator.UserTranslator;
import br.com.genericcrud.repository.IJpaRepository;
import br.com.genericcrud.service.AbstractService;
import br.com.genericcrud.translator.AbstractTranslator;
import br.com.genericcrud.validator.AbstractValidator;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class UserService extends AbstractService<User, Long, UserDTO> {

    private final BetTranslator betTranslator;

    private final UserTranslator userTranslator;

    public UserService(AbstractValidator<User, Long> abstractValidator, IJpaRepository<User, Long> abstractRepository, AbstractTranslator<User, Long, UserDTO> abstractTranslator, BetTranslator betTranslator, UserTranslator userTranslator) {
        super(abstractValidator, abstractRepository, abstractTranslator);
        this.betTranslator = betTranslator;
        this.userTranslator = userTranslator;
    }

    public UserBetDTO getAllUserBets(Long idUser) {
        User user = super.getAbstractOrThrowNotFoundException(idUser);
        List<Bet> bets = user.getUserBets().stream().map(UserBet::getBet).collect(Collectors.toList());
        List<BetDTO> betDTOs = bets.stream().map(betTranslator::toDTO).collect(Collectors.toList());
        return UserBetDTO.builder()
                .userDTO(userTranslator.toDTO(user))
                .betDTOs(betDTOs)
                .build();
    }
}
