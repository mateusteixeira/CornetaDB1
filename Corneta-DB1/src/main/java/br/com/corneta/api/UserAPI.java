package br.com.corneta.api;

import br.com.corneta.domain.User;
import br.com.corneta.domain.dto.UserBetDTO;
import br.com.corneta.domain.dto.UserDTO;
import br.com.corneta.service.UserService;
import br.com.genericcrud.api.AbstractAPI;
import br.com.genericcrud.service.AbstractService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/user")
public class UserAPI extends AbstractAPI<User, Long, UserDTO> {

    private final UserService userService;

    protected UserAPI(AbstractService<User, Long, UserDTO> abstractService, UserService userService) {
        super(abstractService);
        this.userService = userService;
    }

    @GetMapping(value = "/{idUser}/bets")
    public ResponseEntity<UserBetDTO> getAllUserBets(@PathVariable("idUser") Long idUser) {
        return ResponseEntity.ok(userService.getAllUserBets(idUser));
    }
}
