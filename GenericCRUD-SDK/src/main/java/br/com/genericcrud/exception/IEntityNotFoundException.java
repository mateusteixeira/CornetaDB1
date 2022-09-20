package br.com.genericcrud.exception;

public class IEntityNotFoundException extends RuntimeException {

    public IEntityNotFoundException(String message) {
        super(message);
    }
}
