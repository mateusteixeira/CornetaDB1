package br.com.corneta.domain.dto;

import br.com.genericcrud.domain.dto.AbstractDTO;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.stream.Collectors;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserBetDTO extends AbstractDTO {

    @JsonProperty("user")
    private UserDTO userDTO;

    @JsonProperty("bets")
    private List<BetDTO> betDTOs;

    @Override
    public Long getId() {
        return userDTO.getId();
    }

    @Override
    public String getMainIdentifier() {
        return userDTO.getMainIdentifier();
    }

    @Override
    public String getSecondaryIdentifier() {
        return betDTOs.stream().map(BetDTO::getMainIdentifier).collect(Collectors.joining(","));
    }
}
