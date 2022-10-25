package br.com.corneta.domain.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;

import java.io.Serializable;
import java.util.List;


@AllArgsConstructor
public class UserInfoResponseDTO implements Serializable {

    @JsonProperty("id")
    private Long id;

    @JsonProperty("nickName")
    private String nickName;

    @JsonProperty("email")
    private String email;

    @JsonProperty("roles")
    private List<String> roles;

}
