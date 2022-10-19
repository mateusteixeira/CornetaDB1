package br.com.corneta.service;

import br.com.corneta.domain.User;
import br.com.corneta.domain.dto.UserDTO;
import br.com.genericcrud.repository.IJpaRepository;
import br.com.genericcrud.service.AbstractService;
import br.com.genericcrud.translator.AbstractTranslator;
import br.com.genericcrud.validator.AbstractValidator;
import org.springframework.stereotype.Service;

@Service
public class UserService extends AbstractService<User, Long, UserDTO> {

    public UserService(AbstractValidator<User, Long> abstractValidator, IJpaRepository<User, Long> abstractRepository, AbstractTranslator<User, Long, UserDTO> abstractTranslator) {
        super(abstractValidator, abstractRepository, abstractTranslator);
    }

}
