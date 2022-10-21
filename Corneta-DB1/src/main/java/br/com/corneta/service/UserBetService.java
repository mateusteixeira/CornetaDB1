package br.com.corneta.service;

import br.com.corneta.domain.dto.UserBetDTO;
import br.com.corneta.repository.UserBetRepository;
import br.com.corneta.translator.UserBetTranslator;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserBetService {

    private final UserBetRepository userBetRepository;

    private final UserBetTranslator userBetTranslator;

    public UserBetService(UserBetRepository userBetRepository, UserBetTranslator userBetTranslator) {
        this.userBetRepository = userBetRepository;
        this.userBetTranslator = userBetTranslator;
    }


    public List<UserBetDTO> getAllForUser(Long idUser) {


    }
}
