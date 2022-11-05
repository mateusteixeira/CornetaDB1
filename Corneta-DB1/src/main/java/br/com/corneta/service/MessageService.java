package br.com.corneta.service;

import br.com.corneta.domain.Message;
import br.com.corneta.domain.dto.MessageDTO;
import br.com.corneta.repository.MessageRepository;
import br.com.corneta.translator.MessageTranslator;
import br.com.corneta.validator.MessageValidator;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Slf4j
@Service
public class MessageService {

    private final MessageValidator messageValidator;

    private final MessageRepository messageRepository;

    private final MessageTranslator messageTranslator;

    public MessageService(MessageValidator messageValidator, MessageRepository messageRepository, MessageTranslator messageTranslator) {
        this.messageValidator = messageValidator;
        this.messageRepository = messageRepository;
        this.messageTranslator = messageTranslator;
    }

    public MessageDTO createMessage(MessageDTO messageDTO) {
        log.info("Creating message userFrom {} to {}", messageDTO.getIdUserFrom(), messageDTO.getIdBetTo());
        Message message = messageTranslator.toEntity(messageDTO);
        messageValidator.validateMessage(message);
        MessageDTO toDTO = messageTranslator.toDTO(messageRepository.save(message));
        log.info("Created message userFrom {} to {}", messageDTO.getIdUserFrom(), messageDTO.getIdBetTo());
        return toDTO;
    }

    public List<MessageDTO> getAllUserMessages(Long idUser) {
        return messageRepository.findAllByIdBetTo(idUser).stream().map(messageTranslator::toDTO).collect(Collectors.toList());
    }

    public List<MessageDTO> getAllMessagesSentByUser(Long idUser) {
        return messageRepository.findAllByIdUserFrom(idUser).stream().map(messageTranslator::toDTO).collect(Collectors.toList());
    }

    public void setMessageAsViewed(String idMessage) {
        Optional<Message> messageOptional = messageRepository.findById(idMessage);
        messageOptional.ifPresent(message -> {
            message.setViewed(true);
            messageRepository.save(message);
        });
    }

}
