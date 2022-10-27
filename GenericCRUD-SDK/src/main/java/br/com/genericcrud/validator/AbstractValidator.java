package br.com.genericcrud.validator;

import br.com.genericcrud.domain.AbstractEntity;
import br.com.genericcrud.exception.IEntityAlreadyExistsException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.io.Serializable;
import java.util.Objects;

@Slf4j
@Service
public abstract class AbstractValidator<T extends AbstractEntity<ID>, ID extends Serializable> implements IValidator {

    protected void validate(T abstractEntity) {
        if (Objects.nonNull(abstractEntity)) {
            log.error("Error validate {}. Already Exists", getValidatorName());
            throw new IEntityAlreadyExistsException(String.format("%s already exists for %s", getValidatorName(), abstractEntity.getId()));
        }
    }

    public abstract void validateExistent(T abstractEntity);
}
