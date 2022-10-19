package br.com.corneta.repository;

import br.com.corneta.domain.Match;
import br.com.corneta.domain.Team;
import br.com.genericcrud.repository.IJpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TeamRepository extends IJpaRepository<Team, Long> {
}
