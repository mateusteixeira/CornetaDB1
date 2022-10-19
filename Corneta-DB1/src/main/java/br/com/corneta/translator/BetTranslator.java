package br.com.corneta.translator;

import br.com.corneta.domain.Bet;
import br.com.corneta.domain.dto.BetDTO;
import br.com.genericcrud.translator.AbstractTranslator;
import org.mapstruct.Mapper;
import org.mapstruct.MappingInheritanceStrategy;


@Mapper(mappingInheritanceStrategy = MappingInheritanceStrategy.AUTO_INHERIT_ALL_FROM_CONFIG)
public interface BetTranslator extends AbstractTranslator<Bet, Long, BetDTO> {
}
