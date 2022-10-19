package br.com.corneta.domain.dto;

import br.com.genericcrud.domain.dto.AbstractDTO;
import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.annotations.ApiModelProperty;
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
    @ApiModelProperty(value = "Id do Usuário")
    private Long id;
    @JsonProperty("name")
    @ApiModelProperty(value = "Nome do Usuário")
    private String name;

    @JsonProperty("lastName")
    @ApiModelProperty(value = "Sobrenome do Usuário")
    private String lastName;

    @JsonProperty("nickName")
    @ApiModelProperty(value = "Apelido do Usuário")
    private String nickName;

    @JsonProperty("email")
    @ApiModelProperty(value = "Email do Usuário")
    private String email;

    @JsonProperty("blockChainCode")
    @ApiModelProperty(value = "Código na BlockChain")
    private String blockChainCode;

    @Override
    public Long getId() {
        return id;
    }

    @Override
    public String getMainIdentifier() {
        return getId().toString();
    }

    @Override
    public String getSecondaryIdentifier() {
        return getNickName();
    }
}
