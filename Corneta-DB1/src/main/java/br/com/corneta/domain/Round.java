package br.com.corneta.domain;

import br.com.genericcrud.domain.AbstractEntity;
import lombok.*;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

@Getter
@Setter
@Entity
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "round")
@SequenceGenerator(name = AbstractEntity.SEQ_NAME, sequenceName = "ROUND_SEQ", initialValue = 0, allocationSize = 1)
public class Round extends AbstractEntity<Long> {

    @Column(name = "NAME")
    private String name;

    @Column(name = "INITIAL_DATE")
    private LocalDateTime initialDate;

    @Column(name = "END_DATE")
    private LocalDateTime endDate;

    @OneToMany(mappedBy = "round", fetch = FetchType.EAGER)
    private List<Match> matches;

}
