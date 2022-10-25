package br.com.corneta.exception;

public class BetNotFoundException extends RuntimeException {

    public BetNotFoundException(String message) {
        super(message);
    }
}
