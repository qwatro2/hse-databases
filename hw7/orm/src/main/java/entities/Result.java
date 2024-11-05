package entities;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "results")
@Getter
@Setter
public class Result {



    @ManyToOne
    @MapsId("eventId")
    @JoinColumn(name = "event_id", referencedColumnName = "event_id")
    private Event event;

    @ManyToOne
    @MapsId("playerId")
    @JoinColumn(name = "player_id", referencedColumnName = "player_id")
    private Player player;

    @Column(name = "medal", length = 7)
    private String medal;

    @Column(name = "result")
    private Double result;

//    public Result() {
//    }
//
//    public Result(String eventId, String playerId, String medal, double result) {
//        this.eventId = eventId;
//        this.playerId = playerId;
//        this.medal = medal;
//        this.result = result;
//    }
}
