package br.com.corneta.validator;

import br.com.corneta.domain.Message;
import br.com.corneta.exception.InvalidMessageException;
import br.com.corneta.exception.UserMessageNotValidException;
import jdk.internal.joptsimple.internal.Strings;
import org.springframework.stereotype.Component;

import java.util.Objects;

import static java.util.Objects.*;

@Component
public class MessageValidator {

    public void validateMessage(Message message) {
        if (isNull(message.getIdUserTo())) {
            throw new UserMessageNotValidException("Usuário remetente não informado");
        }

        if (isNull(message.getIdUserFrom())) {
            throw new UserMessageNotValidException("Usuário destinatário não informado");
        }

        if (Strings.isNullOrEmpty(message.getMessage())) {
            throw new InvalidMessageException("Mensagem não pode ser vazia");
        }
    }

}
