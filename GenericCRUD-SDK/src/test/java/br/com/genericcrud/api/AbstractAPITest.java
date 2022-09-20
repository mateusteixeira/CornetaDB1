package br.com.genericcrud.api;

import br.com.genericcrud.domain.AbstractEntity;
import br.com.genericcrud.domain.dto.AbstractDTO;
import br.com.genericcrud.service.AbstractService;
import lombok.Builder;
import org.assertj.core.util.Lists;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.*;

class AbstractAPITest {


    private static final Long ID_USER = 1L;

    @Mock
    private AbstractService<AbstractEntityTest, Long, AbstractDTOTest> abstractEntityService;

    @InjectMocks
    private AbstractAPI<AbstractEntityTest, Long, AbstractDTOTest> abstractEntityAPI;

    @BeforeEach
    public void before() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    public void should_create_abstractEntity_with_location_created() {
        MockHttpServletRequest request = new MockHttpServletRequest();
        RequestContextHolder.setRequestAttributes(new ServletRequestAttributes(request));
        AbstractDTOTest abstractDTOTest = mock(AbstractDTOTest.class);
        when(abstractEntityService.createAbstract(abstractDTOTest)).thenReturn(abstractDTOTest);
        when(abstractDTOTest.getId()).thenReturn(ID_USER);

        ResponseEntity<AbstractDTOTest> abstractDTOTestResponseEntity = abstractEntityAPI.createAbstractEntity(abstractDTOTest);
        assertNotNull(abstractDTOTestResponseEntity);
        assertEquals(HttpStatus.CREATED, abstractDTOTestResponseEntity.getStatusCode());
        assertNotNull(abstractDTOTestResponseEntity.getHeaders());
        assertNotNull(abstractDTOTestResponseEntity.getHeaders().getLocation());
        assertEquals("/" + ID_USER, abstractDTOTestResponseEntity.getHeaders().getLocation().getPath());
        assertNotNull(abstractDTOTestResponseEntity.getBody());
        verify(abstractEntityService).createAbstract(abstractDTOTest);
        verify(abstractDTOTest).getId();
    }

    @Test
    public void should_get_all_abstractEntitys_with_ok() {
        PageRequest pageRequest = PageRequest.of(0, 3);
        when(abstractEntityService.getAllAbstracts(pageRequest)).thenReturn(Lists.newArrayList(AbstractDTOTest.builder().build()));

        ResponseEntity<List<AbstractDTOTest>> abstractEntitysResponseEntity = abstractEntityAPI.getAbstractEntities(pageRequest);
        assertNotNull(abstractEntitysResponseEntity);
        assertEquals(HttpStatus.OK, abstractEntitysResponseEntity.getStatusCode());
        assertNotNull(abstractEntitysResponseEntity.getBody());
        verify(abstractEntityService).getAllAbstracts(any(PageRequest.class));
    }

    @Test
    public void should_get_all_abstractEntity_by_id_with_ok() {
        when(abstractEntityService.getAbstractById(ID_USER)).thenReturn(AbstractDTOTest.builder().build());

        ResponseEntity<AbstractDTOTest> abstractEntitysResponseEntity = abstractEntityAPI.getAbstractEntity(ID_USER);
        assertNotNull(abstractEntitysResponseEntity);
        assertEquals(HttpStatus.OK, abstractEntitysResponseEntity.getStatusCode());
        assertNotNull(abstractEntitysResponseEntity.getBody());
        verify(abstractEntityService).getAbstractById(ID_USER);
    }

    @Test
    public void should_update_abstractEntity_with_no_content() {
        AbstractDTOTest abstractDTOTest = AbstractDTOTest.builder().build();
        ResponseEntity<Object> responseEntity = abstractEntityAPI.updateAbstractEntity(abstractDTOTest, ID_USER);
        assertNotNull(responseEntity);
        assertEquals(HttpStatus.NO_CONTENT, responseEntity.getStatusCode());
        assertNull(responseEntity.getBody());
        verify(abstractEntityService).updateAbstract(eq(abstractDTOTest), eq(ID_USER));
    }

    @Test
    public void should_delete_abstractEntity_by_id_with_ok() {
        ResponseEntity<Object> responseEntity = abstractEntityAPI.deleteAbstractEntity(ID_USER);
        assertNotNull(responseEntity);
        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertNull(responseEntity.getBody());
        verify(abstractEntityService).deleteAbstract(ID_USER);
    }

    @Test
    public void should_delete_all_abstractEntitys_with_ok() {
        ResponseEntity<Object> responseEntity = abstractEntityAPI.deleteAllAbstractEntities();
        assertNotNull(responseEntity);
        assertEquals(HttpStatus.OK, responseEntity.getStatusCode());
        assertNull(responseEntity.getBody());
        verify(abstractEntityService).deleteAllAbstracts();
    }


    @Builder
    private static class AbstractEntityTest extends AbstractEntity<Long> {

        private Long id;

        @Override
        public String getMainIdentifier() {
            return String.valueOf(id);
        }

        @Override
        public String getSecondaryIdentifier() {
            return String.valueOf(id);
        }
    }

    @Builder
    private static class AbstractDTOTest extends AbstractDTO {

        private Long id;

        @Override
        public Long getId() {
            return id;
        }

        @Override
        public String getMainIdentifier() {
            return String.valueOf(id);
        }

        @Override
        public String getSecondaryIdentifier() {
            return String.valueOf(id);
        }
    }
}