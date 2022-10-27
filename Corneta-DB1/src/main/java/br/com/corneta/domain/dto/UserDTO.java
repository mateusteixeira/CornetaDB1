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
public class UserDTO extends AbstractDTO {

    @JsonProperty("id")
    private Long id;

    @JsonProperty("name")
    private String name;

    @JsonProperty("lastName")
    private String lastName;

    @JsonProperty("nickName")
    private String nickName;

    @JsonProperty("email")
    private String email;

    @JsonProperty("blockChainCode")
    private String blockChainCode;

    @Override
    public Long getId() {
        return id;
    }

}
