package br.com.corneta.repository;

import br.com.corneta.domain.Message;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MessageRepository extends MongoRepository<Message, String> {

    List<Message> findAllByIdUserTo(Long idUser);

    List<Message> findAllByIdUserFrom(Long idUser);
}
