package br.com.corneta.exception;

public class UserMessageNotValidException extends RuntimeException{

    public UserMessageNotValidException(String message) {
        super(message);
    }
}
