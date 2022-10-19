package br.com.corneta.api;

import br.com.corneta.domain.dto.MessageDTO;
import br.com.corneta.service.MessageService;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.net.URI;
import java.util.List;

@Slf4j
@RestController
@RequestMapping("/message")
public class MessageAPI {

    private final MessageService messageService;

    public MessageAPI(MessageService messageService) {
        this.messageService = messageService;
    }

    @ApiOperation("Cria uma mensagem")
    @PostMapping(produces = {"application/json"}, consumes = {"application/json"})
    public ResponseEntity<MessageDTO> createMessage(@RequestBody MessageDTO messageDTO) {
        log.info("Recebido request message userFrom: {} to: {}", messageDTO.getIdUserFrom(), messageDTO.getIdUserTo());
        MessageDTO savedMessageDTO = messageService.createMessage(messageDTO);
        URI location = this.getUriToHeader(savedMessageDTO);
        return ResponseEntity.created(location).body(savedMessageDTO);
    }

    @ApiOperation("Retorna todos as mensagens recebidas do usuário")
    @GetMapping(value = "/mymessages/{idUser}", produces = {"application/json"})
    public ResponseEntity<List<MessageDTO>> getAllUserMessages(@PathVariable(name = "idUser") Long idUser) {
        return ResponseEntity.ok(messageService.getAllUserMessages(idUser));
    }


    @ApiOperation("Retorna todos as mensagens enviadas do usuário")
    @GetMapping(value = "/mymessagessent/{idUser}", produces = {"application/json"})
    public ResponseEntity<List<MessageDTO>> getAllMessagesSent(@PathVariable(name = "idUser") Long idUser) {
        return ResponseEntity.ok(messageService.getAllMessagesSentByUser(idUser));
    }

    @ApiOperation("Marca mensagem como lida")
    @PutMapping(
            value = {"{id}"},
            produces = {"application/text"},
            consumes = {"application/json"}
    )
    public ResponseEntity<Object> markAsViewed(@PathVariable(name = "id") String idMessage) {
        messageService.setMessageAsViewed(idMessage);
        return ResponseEntity.noContent().build();
    }

    protected URI getUriToHeader(MessageDTO messageDTO) {
        return ServletUriComponentsBuilder.fromCurrentRequest().path("/{id}").buildAndExpand(new Object[]{messageDTO.getId()}).toUri();
    }
}
