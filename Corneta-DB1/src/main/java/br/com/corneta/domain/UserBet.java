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
@Table(name = "user_bet")
@SequenceGenerator(name = AbstractEntity.SEQ_NAME, sequenceName = "USER_BET_SEQ", initialValue = 0, allocationSize = 1)
public class UserBet extends AbstractEntity<Long> {

    @Column(name = "guess_home_team")
    private int guessHomeTeam;

    @Column(name = "guess_visiting_team")
    private int guessVisitingTeam;

    @Column(name = "bet_made")
    private boolean betMade = false;

    @Column(name = "bet_date")
    private LocalDateTime betDate;

    @Column(name = "bet_made_date")
    private LocalDateTime betMadeDate;

    @Column(name = "discount_from_wallet")
    private boolean discountFromWallet;

    @ManyToOne
    @JoinColumn(name = "id_user")
    private User user;

    @ManyToOne
    @JoinColumn(name = "id_bet")
    private Bet bet;


    @Override
    public String getMainIdentifier() {
        return null;
    }

    @Override
    public String getSecondaryIdentifier() {
        return null;
    }
}
