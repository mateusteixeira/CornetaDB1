package br.com.genericcrud.request;

import org.springframework.core.env.Environment;
import org.springframework.stereotype.Component;

@Component
public abstract class GenericCrudUrls implements ExternalUrls {

    protected final Environment environment;

    public GenericCrudUrls(Environment environment) {
        this.environment = environment;
    }

    public String getMockUrl() {
        return environment.getProperty(getUrl());
    }

    public String getMockPort() {
        return environment.getProperty(getPort());
    }
}
