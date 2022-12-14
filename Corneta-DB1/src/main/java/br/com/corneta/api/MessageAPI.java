package br.com.corneta.api;

import br.com.corneta.domain.dto.MessageDTO;
import br.com.corneta.service.MessageService;
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

    @PostMapping(produces = {"application/json"}, consumes = {"application/json"})
    public ResponseEntity<MessageDTO> createMessage(@RequestBody MessageDTO messageDTO) {
        log.info("Recebido request message userFrom: {} to: {}", messageDTO.getIdUserFrom(), messageDTO.getIdBetTo());
        MessageDTO savedMessageDTO = messageService.createMessage(messageDTO);
        URI location = this.getUriToHeader(savedMessageDTO);
        return ResponseEntity.created(location).body(savedMessageDTO);
    }

    @GetMapping(value = "/my-messages/{idUser}", produces = {"application/json"})
    public ResponseEntity<List<MessageDTO>> getAllUserMessages(@PathVariable(name = "idUser") Long idUser) {
        return ResponseEntity.ok(messageService.getAllUserMessages(idUser));
    }

    @GetMapping(value = "/my-messages-sent/{idUser}", produces = {"application/json"})
    public ResponseEntity<List<MessageDTO>> getAllMessagesSent(@PathVariable(name = "idUser") Long idUser) {
        return ResponseEntity.ok(messageService.getAllMessagesSentByUser(idUser));
    }

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
