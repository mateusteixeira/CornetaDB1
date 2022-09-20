package br.com.genericcrud.service;

import br.com.genericcrud.domain.dto.AbstractDTO;
import br.com.genericcrud.exception.IEntityNotFoundException;
import br.com.genericcrud.modeltest.AbstractDTOTest;
import br.com.genericcrud.modeltest.AbstractEntityTest;
import br.com.genericcrud.repository.IJpaRepository;
import br.com.genericcrud.translator.AbstractTranslator;
import br.com.genericcrud.validator.AbstractValidator;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;

import java.util.Collections;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

class AbstractServiceTest {


    private static final Long ID_USER = 1L;

    @Mock
    private AbstractValidator<AbstractEntityTest, Long> abstractEntityTestValidator;

    @Mock
    private IJpaRepository<AbstractEntityTest, Long> abstractEntityTestRepository;

    @Mock
    private AbstractTranslator<AbstractEntityTest, Long, AbstractDTO> abstractEntityTestTranslator;

    @InjectMocks
    private AbstractService<AbstractEntityTest, Long, AbstractDTO> abstractEntityTestService;

    @BeforeEach
    public void before() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    public void should_save_new_abstractEntityTest() {
        AbstractDTOTest abstractDTO = AbstractDTOTest.builder().build();
        AbstractEntityTest abstractEntityTest = mock(AbstractEntityTest.class);
        when(abstractEntityTestTranslator.toEntity(abstractDTO)).thenReturn(abstractEntityTest);
        when(abstractEntityTestRepository.save(abstractEntityTest)).thenReturn(abstractEntityTest);
        when(abstractEntityTestTranslator.toDTO(abstractEntityTest)).thenReturn(abstractDTO);

        AbstractDTO abstractEntityTestCreatedDTO = abstractEntityTestService.createAbstract(abstractDTO);
        assertNotNull(abstractEntityTestCreatedDTO);
        verify(abstractEntityTestValidator).validateExistent(abstractEntityTest);
        verify(abstractEntityTestRepository).save(abstractEntityTest);
    }

    @Test
    public void should_get_abstractEntityTest_by_id() {
        AbstractEntityTest abstractEntityTest = AbstractEntityTest.builder().build();
        AbstractDTOTest abstractDTO = AbstractDTOTest.builder().build();
        when(abstractEntityTestRepository.findById(ID_USER)).thenReturn(Optional.of(abstractEntityTest));
        when(abstractEntityTestTranslator.toDTO(abstractEntityTest)).thenReturn(abstractDTO);

        AbstractDTO abstractEntityTestFindDTO = abstractEntityTestService.getAbstractById(ID_USER);
        assertNotNull(abstractEntityTestFindDTO);

        verify(abstractEntityTestRepository).findById(ID_USER);
        verify(abstractEntityTestTranslator).toDTO(abstractEntityTest);
    }

    @Test
    public void should_throws_exception_when_get_abstractEntityTest_by_id_not_found() {
        when(abstractEntityTestRepository.findById(ID_USER)).thenReturn(Optional.empty());

        assertThrows(IEntityNotFoundException.class, () -> abstractEntityTestService.getAbstractById(ID_USER));

        verify(abstractEntityTestRepository).findById(ID_USER);
        verify(abstractEntityTestTranslator, never()).toDTO(any());
    }

    @Test
    public void should_get_all_abstractEntityTests() {
        AbstractEntityTest abstractEntityTest = AbstractEntityTest.builder().build();
        AbstractDTOTest abstractDTO = AbstractDTOTest.builder().build();
        PageImpl<AbstractEntityTest> abstractEntityTests = new PageImpl<>(Collections.singletonList(abstractEntityTest));
        when(abstractEntityTestRepository.findAll(Pageable.unpaged())).thenReturn(abstractEntityTests);
        when(abstractEntityTestTranslator.toDTO(abstractEntityTest)).thenReturn(abstractDTO);

        List<AbstractDTO> allAbstractEntityTests = abstractEntityTestService.getAllAbstracts(Pageable.unpaged());
        assertNotNull(allAbstractEntityTests);
        assertEquals(1, allAbstractEntityTests.size());

        verify(abstractEntityTestRepository).findAll(any(Pageable.class));
        verify(abstractEntityTestTranslator).toDTO(abstractEntityTest);
    }

    @Test
    public void should_update_abstractEntityTest() {
        AbstractEntityTest abstractEntityTest = mock(AbstractEntityTest.class);
        AbstractDTO abstractDTO = mock(AbstractDTO.class);
        when(abstractEntityTestRepository.findById(ID_USER)).thenReturn(Optional.of(abstractEntityTest));

        abstractEntityTestService.updateAbstract(abstractDTO, ID_USER);
        verify(abstractEntityTestRepository).findById(ID_USER);
        verify(abstractEntityTestRepository).save(abstractEntityTest);
    }

    @Test
    public void should_not_update_abstractEntityTest_when_abstractEntityTest_not_found() {
        when(abstractEntityTestRepository.findById(ID_USER)).thenReturn(Optional.empty());

        assertThrows(IEntityNotFoundException.class, () -> abstractEntityTestService.getAbstractById(ID_USER));

        verify(abstractEntityTestRepository).findById(ID_USER);
        verify(abstractEntityTestRepository, never()).save(any());
    }

    @Test
    public void should_delete_abstractEntityTest_by_id() {
        abstractEntityTestService.deleteAbstract(ID_USER);
        verify(abstractEntityTestRepository).deleteById(ID_USER);
    }

    @Test
    public void should_delete_all_abstractEntityTests() {
        abstractEntityTestService.deleteAllAbstracts();
        verify(abstractEntityTestRepository).deleteAll();
    }
}