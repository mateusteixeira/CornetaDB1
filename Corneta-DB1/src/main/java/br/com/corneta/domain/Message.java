package br.com.corneta.domain;

import br.com.genericcrud.domain.AbstractEntity;
import lombok.Builder;
import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.io.Serializable;

@Data
@Builder
@Document("Message")
public class Message implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    private String id;
    private Long idUserFrom;
    private Long idUserTo;
    private String message;
    private boolean viewed;
    //TODO adicionar bet (grupo)

}
