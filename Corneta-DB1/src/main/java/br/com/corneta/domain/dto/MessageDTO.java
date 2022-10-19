package br.com.corneta.domain.dto;

import br.com.genericcrud.domain.dto.AbstractDTO;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.Random;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MessageDTO implements Serializable {

    private String id;
    private Long idUserTo;
    private Long idUserFrom;
    private String message;
    private boolean viewed;

}
