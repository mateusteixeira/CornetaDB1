package br.com.corneta.translator;

import br.com.corneta.domain.Message;
import br.com.corneta.domain.Team;
import br.com.corneta.domain.dto.MessageDTO;
import br.com.corneta.domain.dto.TeamDTO;
import br.com.genericcrud.translator.AbstractTranslator;
import org.mapstruct.Mapper;
import org.mapstruct.MappingInheritanceStrategy;
import org.mapstruct.MappingTarget;


@Mapper(mappingInheritanceStrategy = MappingInheritanceStrategy.AUTO_INHERIT_ALL_FROM_CONFIG)
public interface TeamTranslator extends AbstractTranslator<Team, Long, TeamDTO> {

}
