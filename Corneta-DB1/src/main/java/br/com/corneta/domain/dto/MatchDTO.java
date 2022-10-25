package br.com.corneta.domain.dto;

import br.com.genericcrud.domain.dto.AbstractDTO;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MatchDTO extends AbstractDTO {

    @JsonProperty("id")
    private Long id;

    @JsonProperty("homeTeam")
    private TeamDTO homeTeamDTO;

    @JsonProperty("visitingTeam")
    private TeamDTO visitingTeamDTO;

    @JsonProperty("gameDate")
    private LocalDateTime gameDate;

    @JsonProperty("round")
    private String round;

    @Override
    public Long getId() {
        return id;
    }

    @Override
    public String getMainIdentifier() {
        return homeTeamDTO.getMainIdentifier() + " x " + visitingTeamDTO.getMainIdentifier();
    }

    @Override
    public String getSecondaryIdentifier() {
        return homeTeamDTO.getInitials() + " x " + visitingTeamDTO.getInitials();
    }
}
