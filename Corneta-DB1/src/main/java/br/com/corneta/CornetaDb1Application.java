package br.com.corneta;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.PropertySource;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.data.mongodb.repository.config.EnableMongoRepositories;

@SpringBootApplication
@EnableAutoConfiguration
@EntityScan(basePackages = "br.com.corneta.domain")
@EnableJpaRepositories(basePackages = "br.com.corneta.repository")
@EnableMongoRepositories(basePackages = "br.com.corneta.repository")
@PropertySource("classpath:application.properties")
@ComponentScan("br.com.corneta")
public class CornetaDb1Application {

	public static void main(String[] args) {
		SpringApplication.run(CornetaDb1Application.class, args);
	}

}
