package br.com.genericcrud.api;

import br.com.genericcrud.domain.AbstractEntity;
import br.com.genericcrud.domain.dto.AbstractDTO;
import br.com.genericcrud.service.AbstractService;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiResponse;
import io.swagger.annotations.ApiResponses;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.io.Serializable;
import java.net.URI;
import java.util.List;

@Slf4j
@ApiResponses(value = {
        @ApiResponse(code = 200, message = "Operação realizada com Sucesso!"),
        @ApiResponse(code = 403, message = "Você não tem permissão para acessar este recurso."),
        @ApiResponse(code = 500, message = "Ocorreu um erro interno."),
})
public class AbstractAPI<T extends AbstractEntity<ID>, ID extends Serializable, R extends AbstractDTO> {

    private final AbstractService<T, ID, R> abstractService;

    protected AbstractAPI(AbstractService<T, ID, R> abstractService) {
        this.abstractService = abstractService;
    }

    protected String teste() {
        return "";
    }

    @ApiOperation(value = "Cria um Registro")
    @PostMapping(produces = "application/json", consumes = "application/json")
    public ResponseEntity<R> createAbstractEntity(@RequestBody R abstractDTO) {
        log.info("Recebido request Create Entity {}", abstractDTO.getClass().getSimpleName());
        R savedAbstractDTO = this.abstractService.createAbstract(abstractDTO);
        URI location = getUriToHeader(savedAbstractDTO);
        return ResponseEntity.created(location).body(savedAbstractDTO);
    }


    @GetMapping(produces = "application/json")
    @ApiOperation(value = "Retorna todos os Registros")
    public ResponseEntity<List<R>> getAbstractEntities(Pageable pageable) {
        log.info("Recebido request ReturnAll");
        return ResponseEntity.ok(abstractService.getAllAbstracts(pageable));
    }

    @ApiOperation(value = "Retorna um Registro por Id.")
    @GetMapping(value = "{id}", produces = "application/json")
    public ResponseEntity<R> getAbstractEntity(@PathVariable(name = "id") ID idAbstractEntity) {
        log.info("Recebido request ReturnById");
        return ResponseEntity.ok(abstractService.getAbstractById(idAbstractEntity));
    }

    @ApiOperation(value = "Atualiza um Registro por Id.")
    @PutMapping(value = "{id}", produces = "application/text", consumes = "application/json")
    public ResponseEntity<Object> updateAbstractEntity(@RequestBody R abstractDTO, @PathVariable(name = "id") ID idAbstractEntity) {
        log.info("Recebido request updateAbstractEntity {} - {}", idAbstractEntity, abstractDTO.getClass().getSimpleName());
        abstractService.updateAbstract(abstractDTO, idAbstractEntity);
        return ResponseEntity.noContent().build();
    }

    @ApiOperation(value = "Deleta um Registro por Id.")
    @DeleteMapping(value = "{id}", produces = "application/text")
    public ResponseEntity<Object> deleteAbstractEntity(@PathVariable(name = "id") ID idAbstractEntity) {
        log.info("Recebido request deleteById");
        abstractService.deleteAbstract(idAbstractEntity);
        return ResponseEntity.ok().build();
    }

    @ApiOperation(value = "Deleta todos Registros.")
    @DeleteMapping(produces = "application/text")
    public ResponseEntity<Object> deleteAllAbstractEntities() {
        log.info("Recebido request deleteAll");
        abstractService.deleteAllAbstracts();
        return ResponseEntity.ok().build();
    }

    protected URI getUriToHeader(AbstractDTO abstractDTO) {
        return ServletUriComponentsBuilder
                .fromCurrentRequest()
                .path("/{id}")
                .buildAndExpand(abstractDTO.getId())
                .toUri();
    }
}
