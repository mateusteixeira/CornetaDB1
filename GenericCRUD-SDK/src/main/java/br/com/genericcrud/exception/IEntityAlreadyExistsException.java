package br.com.genericcrud.exception;

public class IEntityAlreadyExistsException extends RuntimeException {

    public IEntityAlreadyExistsException(String message) {
        super(message);
    }
}
