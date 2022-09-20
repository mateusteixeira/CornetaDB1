package br.com.genericcrud.queues.senders;

import br.com.genericcrud.queues.messages.AsyncOperationMessage;

public interface OperationQueueSender {

    void sendMessage(AsyncOperationMessage asyncOperationMessage);

}
