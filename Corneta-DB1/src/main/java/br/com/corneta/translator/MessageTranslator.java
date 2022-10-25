package br.com.corneta.translator;

import br.com.corneta.domain.Message;
import br.com.corneta.domain.dto.MessageDTO;
import org.mapstruct.Mapper;
import org.mapstruct.MappingTarget;

@Mapper
public interface MessageTranslator {

    MessageDTO toDTO(Message message);

    Message toEntity(MessageDTO messageDTO);

    void update(@MappingTarget Message message, MessageDTO messageDTO);

//    public Message toEntity(MessageDTO messageDTO) {
//        return Message.builder()
//                .idUserTo(messageDTO.getIdUserTo())
//                .idUserFrom(messageDTO.getIdUserFrom())
//                .message(messageDTO.getMessage())
//                .viewed(false).build();
//    }
//
//    public MessageDTO toDTO(Message message) {
//        return MessageDTO.builder()
//                .idUserTo(message.getIdUserTo())
//                .idUserFrom(message.getIdUserFrom())
//                .message(message.getMessage())
//                .viewed(message.isViewed())
//                .build();
//    }


}
