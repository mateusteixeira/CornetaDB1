package br.com.corneta.domain;


import br.com.genericcrud.domain.AbstractEntity;
import lombok.*;
import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

import javax.persistence.*;
import java.util.List;

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

    @Column(name = "GROUPS")
    private String group;

    @Column(name = "FLAG")
    private String flag;

    @LazyCollection(LazyCollectionOption.FALSE)
    @OneToMany(mappedBy = "homeTeam")
    private List<Match> matchesInHome;

    @LazyCollection(LazyCollectionOption.FALSE)
    @OneToMany(mappedBy = "visitingTeam")
    private List<Match> matchesAsVisiting;

}
