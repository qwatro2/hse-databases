package entities;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table(name = "results")
@Getter
@Setter
@IdClass(ResultId.class)
public class Result {

    @Id
    @ManyToOne
    @JoinColumn(name = "event_id", nullable = false)
    private Event event;

    @Id
    @ManyToOne
    @JoinColumn(name = "player_id", nullable = false)
    private Player player;

    @Column(name = "medal", length = 7)
    private String medal;

    @Column(name = "result")
    private Double result;
}
