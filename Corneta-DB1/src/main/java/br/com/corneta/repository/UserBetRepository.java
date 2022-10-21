package br.com.corneta.repository;

import br.com.corneta.domain.Bet;
import br.com.corneta.domain.User;
import br.com.corneta.domain.UserBet;
import br.com.genericcrud.repository.IJpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserBetRepository extends IJpaRepository<UserBet, Long> {
    List<UserBet> findAllByUser(User user);
}
