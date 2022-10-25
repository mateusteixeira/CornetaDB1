package br.com.corneta.translator;


import br.com.corneta.domain.User;
import br.com.corneta.domain.dto.UserDTO;
import br.com.genericcrud.translator.AbstractTranslator;
import org.mapstruct.Mapper;
import org.mapstruct.MappingInheritanceStrategy;

@Mapper(mappingInheritanceStrategy = MappingInheritanceStrategy.AUTO_INHERIT_ALL_FROM_CONFIG)
public interface UserTranslator extends AbstractTranslator<User, Long, UserDTO> {
}
