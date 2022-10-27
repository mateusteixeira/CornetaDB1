package br.com.corneta.domain.dto;

import br.com.genericcrud.domain.dto.AbstractDTO;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class BetDTO extends AbstractDTO {

    @JsonProperty("id")
    private Long id;

    @JsonProperty("match")
    private MatchDTO matchDTO;

    @JsonProperty("contractHashCode")
    private String contractHashCode;

    @Override
    public Long getId() {
        return id;
    }

   }
