package br.com.corneta.repository;

import br.com.corneta.domain.User;
import br.com.genericcrud.repository.IJpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepository extends IJpaRepository<User, Long> {

    Optional<User> findByNickName(String username);

    Optional<User> findByBlockChainCode(String username);
}
