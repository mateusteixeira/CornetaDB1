package br.com.corneta.domain.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;

import java.io.Serializable;

@AllArgsConstructor
public class MessageResponseDTO implements Serializable {

    @JsonProperty("mensagem")
    private String message;

}
