package br.com.corneta.exception;

public class InvalidMessageException extends RuntimeException {

    public InvalidMessageException(String message) {
        super(message);
    }
}
