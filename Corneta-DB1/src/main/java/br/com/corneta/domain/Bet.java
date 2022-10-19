package br.com.corneta.domain;


import br.com.genericcrud.domain.AbstractEntity;
import lombok.*;

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
@Table(name = "bet")
@SequenceGenerator(name = AbstractEntity.SEQ_NAME, sequenceName = "BET_SEQ", initialValue = 0, allocationSize = 1)
public class Bet extends AbstractEntity <Long>{

    @Override
    public String getMainIdentifier() {
        return null;
    }

    @Override
    public String getSecondaryIdentifier() {
        return null;
    }
}
