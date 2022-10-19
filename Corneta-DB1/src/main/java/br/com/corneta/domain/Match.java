package br.com.corneta.domain;

import br.com.genericcrud.domain.AbstractEntity;
import lombok.*;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import java.time.LocalDateTime;

@Getter
@Setter
@Entity
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "match")
@SequenceGenerator(name = AbstractEntity.SEQ_NAME, sequenceName = "MATCH_SEQ", initialValue = 0, allocationSize = 1)
public class Match extends AbstractEntity<Long> {

    @Column(name = "ID_HOME_TEAM")
    private Team homeTeam;

    @Column(name = "ID_VISITING_TEAM")
    private Team visitingTeam;

    @Column(name = "GAME_DATE")
    private LocalDateTime gameDate;

    @Column(name = "ROUND")
    private String round;

    @Override
    public String getMainIdentifier() {
        return homeTeam.getMainIdentifier() + " x " + visitingTeam.getMainIdentifier();
    }

    @Override
    public String getSecondaryIdentifier() {
        return homeTeam.getInitials() + " x " + visitingTeam.getInitials();
    }
}
