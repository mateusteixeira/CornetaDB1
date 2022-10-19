package br.com.corneta.api;

import br.com.corneta.domain.User;
import br.com.corneta.domain.dto.UserDTO;
import br.com.genericcrud.api.AbstractAPI;
import br.com.genericcrud.service.AbstractService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/user")
public class UserAPI extends AbstractAPI<User, Long, UserDTO> {

    protected UserAPI(AbstractService<User, Long, UserDTO> abstractService) {
        super(abstractService);
    }

}
