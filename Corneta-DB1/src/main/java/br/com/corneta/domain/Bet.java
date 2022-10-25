package br.com.corneta.domain;


import br.com.genericcrud.domain.AbstractEntity;
import lombok.*;

import javax.persistence.*;
import java.util.List;

@Getter
@Setter
@Entity
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "bet")
@SequenceGenerator(name = AbstractEntity.SEQ_NAME, sequenceName = "BET_SEQ", initialValue = 0, allocationSize = 1)
public class Bet extends AbstractEntity<Long> {

    @OneToOne
    @JoinColumn(name = "id_match")
    private Match match;

    @Column(name = "contract_hash_code")
    private String contractHashCode;

    @OneToMany(mappedBy = "bet", fetch = FetchType.EAGER)
    private List<UserBet> userBets;

    @Override
    public String getMainIdentifier() {
        return null;
    }

    @Override
    public String getSecondaryIdentifier() {
        return null;
    }
}
