package br.com.corneta.domain;

import br.com.genericcrud.domain.AbstractEntity;
import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.annotations.ApiModelProperty;
import lombok.*;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;


@Getter
@Setter
@Entity
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "\"user\"")
@SequenceGenerator(name = AbstractEntity.SEQ_NAME, sequenceName = "USER_SEQ", initialValue = 0, allocationSize = 1)
public class User extends AbstractEntity<Long> {

    private static final long serialVersionUID = 1L;

    @Column(name = "NAME")
    private String name;

    @Column(name = "LAST_NAME")
    private String lastName;

    @Column(name = "NICK_NAME")
    private String nickName;

    @Column(name = "EMAIL")
    private String email;

    @Column(name = "BLOCK_CHAIN_CODE")
    private String blockChainCode;

    @Override
    public String getMainIdentifier() {
        return this.getId().toString();
    }

    @Override
    public String getSecondaryIdentifier() {
        return this.nickName;
    }
}
