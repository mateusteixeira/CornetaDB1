package br.com.corneta.repository;

import br.com.corneta.domain.Bet;
import br.com.corneta.domain.Match;
import br.com.genericcrud.repository.IJpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface MatchRepository extends IJpaRepository<Match, Long> {
}
