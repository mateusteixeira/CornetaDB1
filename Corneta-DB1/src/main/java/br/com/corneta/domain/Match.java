package br.com.corneta.domain;

import br.com.genericcrud.domain.AbstractEntity;
import lombok.*;

import javax.persistence.*;
import java.time.LocalDateTime;

@Getter
@Setter
@Entity
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "matches")
@SequenceGenerator(name = AbstractEntity.SEQ_NAME, sequenceName = "MATCH_SEQ", initialValue = 0, allocationSize = 1)
public class Match extends AbstractEntity<Long> {

    @Column(name = "ID_HOME_TEAM")
    private Team homeTeam;

    @Column(name = "ID_VISITING_TEAM")
    private Team visitingTeam;

    @Column(name = "GAME_DATE")
    private LocalDateTime gameDate;

    @OneToMany
    @JoinColumn(name = "ID_ROUND")
    private Round round;

    @Override
    public String getMainIdentifier() {
        return homeTeam.getMainIdentifier() + " x " + visitingTeam.getMainIdentifier();
    }

    @Override
    public String getSecondaryIdentifier() {
        return homeTeam.getInitials() + " x " + visitingTeam.getInitials();
    }
}
