package br.com.corneta.domain.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MessageDTO implements Serializable {

    private String id;
    private Long idBetTo;
    private Long idUserFrom;
    private String message;
    private boolean viewed;

}
