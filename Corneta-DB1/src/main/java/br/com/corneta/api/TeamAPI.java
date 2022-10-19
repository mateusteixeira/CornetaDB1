package br.com.corneta.api;

import br.com.corneta.domain.dto.TeamDTO;
import br.com.corneta.service.TeamService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/teams")
public class TeamAPI {

    private final TeamService teamService;

    public TeamAPI(TeamService teamService) {
        this.teamService = teamService;
    }

    @GetMapping
    public ResponseEntity<List<TeamDTO>> getAllTeames() {
        return ResponseEntity.ok(teamService.getAll());
    }
}
