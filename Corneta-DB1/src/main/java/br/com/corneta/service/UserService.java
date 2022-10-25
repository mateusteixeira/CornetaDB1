package br.com.corneta.service;

import br.com.corneta.domain.User;
import br.com.corneta.domain.UserBet;
import br.com.corneta.domain.dto.UserBetDTO;
import br.com.corneta.domain.dto.UserDTO;
import br.com.corneta.repository.UserBetRepository;
import br.com.corneta.translator.UserBetTranslator;
import br.com.genericcrud.repository.IJpaRepository;
import br.com.genericcrud.service.AbstractService;
import br.com.genericcrud.translator.AbstractTranslator;
import br.com.genericcrud.validator.AbstractValidator;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class UserService extends AbstractService<User, Long, UserDTO> {

    private final UserBetRepository userBetRepository;

    private final UserBetTranslator userBetTranslator;

    public UserService(AbstractValidator<User, Long> abstractValidator, IJpaRepository<User, Long> abstractRepository, AbstractTranslator<User, Long, UserDTO> abstractTranslator, UserBetRepository userBetRepository, UserBetTranslator userBetTranslator) {
        super(abstractValidator, abstractRepository, abstractTranslator);
        this.userBetRepository = userBetRepository;
        this.userBetTranslator = userBetTranslator;
    }

    public List<UserBetDTO> getAllUserBets(Long idUser) {
        User user = super.getAbstractOrThrowNotFoundException(idUser);
        List<UserBet> allUserBets = userBetRepository.findAllByUser(user);
        return allUserBets.stream().map(userBetTranslator::toDTO).collect(Collectors.toList());
    }
}
