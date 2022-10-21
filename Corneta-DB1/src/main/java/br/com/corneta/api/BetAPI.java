package br.com.corneta.api;

import br.com.corneta.domain.dto.BetDTO;
import br.com.corneta.service.BetService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/bet")
public class BetAPI {

    private final BetService betService;

    public BetAPI(BetService betService) {
        this.betService = betService;
    }

    @GetMapping
    public ResponseEntity<List<BetDTO>> getAllBets() {
        return ResponseEntity.ok(betService.getAll());
    }

    @PostMapping(value = "/{idBet}/user/{idUser}")
    public ResponseEntity doBet(@ResponseBody )

}
