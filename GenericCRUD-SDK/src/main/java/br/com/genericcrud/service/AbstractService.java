package br.com.genericcrud.service;

import br.com.genericcrud.domain.AbstractEntity;
import br.com.genericcrud.domain.dto.AbstractDTO;
import br.com.genericcrud.exception.IEntityNotFoundException;
import br.com.genericcrud.repository.IJpaRepository;
import br.com.genericcrud.translator.AbstractTranslator;
import br.com.genericcrud.validator.AbstractValidator;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Pageable;

import java.io.Serializable;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Slf4j
public class AbstractService<T extends AbstractEntity<ID>, ID extends Serializable, R extends AbstractDTO> {

    protected final AbstractValidator<T, ID> abstractValidator;

    protected final IJpaRepository<T, ID> abstractRepository;

    protected final AbstractTranslator<T, ID, R> abstractTranslator;

    public AbstractService(AbstractValidator<T, ID> abstractValidator, IJpaRepository<T, ID> abstractRepository, AbstractTranslator<T, ID, R> abstractTranslator) {
        this.abstractValidator = abstractValidator;
        this.abstractRepository = abstractRepository;
        this.abstractTranslator = abstractTranslator;
    }


    public R createAbstract(R abstractDTO) {
        T iEntity = abstractTranslator.toEntity(abstractDTO);
        abstractValidator.validateExistent(iEntity);
        return abstractTranslator.toDTO(abstractRepository.save(iEntity));
    }

    public R getAbstractById(ID id) {
        T iEntity = getAbstractOrThrowNotFoundException(id);
        return abstractTranslator.toDTO(iEntity);
    }

    public T getAbstractOrThrowNotFoundException(ID id) {
        Optional<T> abstractOp = abstractRepository.findById(id);
        return abstractOp.orElseThrow(() -> new IEntityNotFoundException(String.format("Abstract for id %s not found", id)));
    }

    public List<R> getAllAbstracts(Pageable paging) {
        return abstractRepository.findAll(paging).stream().map(abstractTranslator::toDTO).collect(Collectors.toList());
    }

    public void updateAbstract(R abstractDTO, ID id) {
        T abstractEntity = getAbstractOrThrowNotFoundException(id);
        abstractTranslator.update(abstractEntity, abstractDTO);
        abstractRepository.save(abstractEntity);
    }

    public void deleteAbstract(ID idAbstract) {
        abstractRepository.deleteById(idAbstract);
    }

    public void deleteAllAbstracts() {
        abstractRepository.deleteAll();
    }
}
