package br.com.corneta.domain;


import br.com.genericcrud.domain.AbstractEntity;
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
@Table(name = "team")
@SequenceGenerator(name = AbstractEntity.SEQ_NAME, sequenceName = "TEAM_SEQ", initialValue = 0, allocationSize = 1)
public class Team extends AbstractEntity<Long> {

    @Column(name = "NAME")
    private String name;

    @Column(name = "INITIALS")
    private String initials;

    @Column(name = "GROUP")
    private String group;

    @Column(name = "FLAG")
    private String flag;

    @Override
    public String getMainIdentifier() {
        return name;
    }

    @Override
    public String getSecondaryIdentifier() {
        return initials;
    }
}
