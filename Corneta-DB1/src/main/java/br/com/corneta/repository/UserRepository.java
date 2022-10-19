package br.com.corneta.repository;

import br.com.corneta.domain.User;
import br.com.genericcrud.repository.IJpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends IJpaRepository<User, Long> {

}
