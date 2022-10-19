package br.com.corneta.api;

import br.com.corneta.domain.Bet;
import br.com.corneta.domain.dto.BetDTO;
import br.com.genericcrud.api.AbstractAPI;
import br.com.genericcrud.service.AbstractService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/user")
public class BetAPI extends AbstractAPI<Bet, Long, BetDTO> {

    protected BetAPI(AbstractService<Bet, Long, BetDTO> abstractService) {
        super(abstractService);
    }
}
