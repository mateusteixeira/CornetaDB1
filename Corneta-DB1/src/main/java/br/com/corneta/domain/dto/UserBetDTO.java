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
public class UserBetDTO extends AbstractDTO {

    @JsonProperty("guessHomeTeam")
    private int guessHomeTeam;

    @JsonProperty("guessVisitingTeam")
    private int guessVisitingTeam;

    @JsonProperty("betMade")
    private boolean betMade;

    @JsonProperty("betDate")
    private LocalDateTime betDate;

    @JsonProperty("betMadeDate")
    private LocalDateTime betMadeDate;

    @JsonProperty("discountFromWallet")
    private boolean discountFromWallet;

    @JsonProperty("bet")
    private BetDTO betDTO;

    @Override
    public Long getId() {
        return betDTO.getId();
    }

    @Override
    public String getMainIdentifier() {
        return betDTO.getMainIdentifier();
    }

    @Override
    public String getSecondaryIdentifier() {
        return betDTO.getSecondaryIdentifier();
    }
}
