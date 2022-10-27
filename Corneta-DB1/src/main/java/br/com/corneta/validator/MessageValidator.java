package br.com.corneta.validator;

import br.com.corneta.domain.Message;
import br.com.corneta.exception.UserMessageNotValidException;
import org.springframework.stereotype.Component;

import static java.util.Objects.isNull;

@Component
public class MessageValidator {

    public void validateMessage(Message message) {
        if (isNull(message.getIdUserTo())) {
            throw new UserMessageNotValidException("Usuário remetente não informado");
        }

        if (isNull(message.getIdUserFrom())) {
            throw new UserMessageNotValidException("Usuário destinatário não informado");
        }
    }

}
