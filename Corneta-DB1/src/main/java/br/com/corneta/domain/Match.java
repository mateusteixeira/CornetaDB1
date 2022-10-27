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

    @ManyToOne
    @JoinColumn(name = "ID_HOME_TEAM")
    private Team homeTeam;

    @ManyToOne
    @JoinColumn(name = "ID_VISITING_TEAM")
    private Team visitingTeam;

    @Column(name = "GAME_DATE")
    private LocalDateTime gameDate;

    @ManyToOne
    @JoinColumn(name = "ID_ROUND")
    private Round round;

}
