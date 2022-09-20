package br.com.genericcrud.translator;


import br.com.genericcrud.domain.AbstractEntity;
import br.com.genericcrud.domain.dto.AbstractDTO;
import org.mapstruct.MappingTarget;

import java.io.Serializable;

public interface AbstractTranslator<T extends AbstractEntity<ID>, ID extends Serializable, R extends AbstractDTO> extends ITranslator {

    R toDTO(T iEntity);

    T toEntity(R abstractDTO);

    void update(@MappingTarget T iEntity, R abstractDTO);
}
