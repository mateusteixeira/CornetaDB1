package br.com.genericcrud.exception;

import br.com.genericcrud.domain.dto.ErrorHandleDTO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.lang.Nullable;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

@Slf4j
@ControllerAdvice
public class GenericCrudExceptionHandler extends ResponseEntityExceptionHandler {

    @ExceptionHandler(value = {IEntityNotFoundException.class})
    protected ResponseEntity<ErrorHandleDTO> handleNotFound(RuntimeException ex, WebRequest request) {
        log.error("Handling notFound. Error: {}", ex.getMessage());
        return this.handleExceptionInternal(ex, ErrorHandleDTO.builder().message(String.format("Resource Not Found: %s", ex.getMessage())).build(),
                new HttpHeaders(), HttpStatus.NOT_FOUND, request);
    }

    @ExceptionHandler(value = {IEntityAlreadyExistsException.class})
    protected ResponseEntity<ErrorHandleDTO> handleConflict(RuntimeException ex, WebRequest request) {
        log.error("Handling conflict. Error: {}", ex.getMessage());
        return this.handleExceptionInternal(ex, ErrorHandleDTO.builder().message(String.format("Resource Already Exists: %s", ex.getMessage())).build(),
                new HttpHeaders(), HttpStatus.CONFLICT, request);
    }

    @ExceptionHandler(value = {RuntimeException.class, RequestExecutorException.class})
    protected ResponseEntity<ErrorHandleDTO> handleErrors(RuntimeException ex, WebRequest request) {
        log.error("Handling error. Error: {}", ex.getMessage());
        return this.handleExceptionInternal(ex, ErrorHandleDTO.builder().message(String.format("Error in application: %s", ex.getMessage())).build(),
                new HttpHeaders(), HttpStatus.INTERNAL_SERVER_ERROR, request);
    }

    protected ResponseEntity<ErrorHandleDTO> handleExceptionInternal(Exception ex, @Nullable ErrorHandleDTO body, HttpHeaders headers, HttpStatus status, WebRequest request) {
        if (HttpStatus.INTERNAL_SERVER_ERROR.equals(status)) {
            request.setAttribute("javax.servlet.error.exception", ex, 0);
        }
        return ResponseEntity
                .status(status)
                .headers(headers)
                .body(body);
    }
}
