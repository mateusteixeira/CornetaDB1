package br.com.genericcrud.request;

import br.com.genericcrud.exception.RequestExecutorException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.RequestEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriTemplate;

import java.net.URI;
import java.util.Map;

@Slf4j
@Component
public abstract class AbstractRequestExecutorService<R extends GenericCrudUrls> {

    private final RestTemplate restTemplate;

    private final R genericCrudUrls;

    public AbstractRequestExecutorService(RestTemplate restTemplate, R genericCrudUrls) {
        this.restTemplate = restTemplate;
        this.genericCrudUrls = genericCrudUrls;
    }

    public <T> ResponseEntity<T> get(final String url, final Map<String, String> pathParams, final Map<String, String> queryParams, final Class<T> responseType) {
        return execute(url, HttpMethod.GET, null, pathParams, queryParams, responseType);
    }

    public <T> ResponseEntity<T> post(final String url, final Object value, final Map<String, String> pathParams, final Map<String, String> queryParams, final Class<T> responseType) {
        return execute(url, HttpMethod.POST, value, pathParams, queryParams, responseType);
    }

    private <T> ResponseEntity<T> execute(final String url, final HttpMethod method, final Object value, final Map<String, String> pathParams, final Map<String, String> queryParams, final Class<T> responseType) {
        String finalUrl = buildUrl(url);
        final URI uri = new UriTemplate(finalUrl).expand(pathParams);

        final RequestEntity<Object> request = new RequestEntity<>(value, new HttpHeaders(), method, uri);
        try {
            log.info("Fazendo request method {} to {}", method, url);
            return restTemplate.exchange(request, responseType);
        } catch (Exception e) {
            log.error("Erro ao fazer request, error: {}", e.getMessage());
            throw new RequestExecutorException(e.getMessage());
        }
    }

    private String buildUrl(String url) {
        String mockUrl = genericCrudUrls.getMockUrl();
        String mockPort = genericCrudUrls.getMockPort();
        return mockUrl.concat(":").concat(mockPort).concat(url);
    }

}
