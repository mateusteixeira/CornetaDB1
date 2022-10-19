package br.com.corneta.domain.dto;

import br.com.genericcrud.domain.dto.AbstractDTO;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class BetDTO extends AbstractDTO {
    @Override
    public Long getId() {
        return null;
    }

    @Override
    public String getMainIdentifier() {
        return null;
    }

    @Override
    public String getSecondaryIdentifier() {
        return null;
    }
}
