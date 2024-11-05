package entities;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name = "events")
@Getter
@Setter
public class Event {

    @Id
    @Column(name = "event_id", length = 7, nullable = false, unique = true)
    private String eventId;

    @Column(name = "name", length = 40)
    private String name;

    @Column(name = "eventtype", length = 20)
    private String eventType;

    @ManyToOne
    @JoinColumn(name = "olympic_id", referencedColumnName = "olympic_id")
    private Olympic olympic;

    @Column(name = "is_team_event")
    private Integer isTeamEvent;

    @Column(name = "num_players_in_team")
    private Integer numPlayersInTeam;

    @Column(name = "result_noted_in", length = 100)
    private String resultNotedIn;

    @OneToMany(mappedBy = "event", cascade = CascadeType.ALL)
    private Set<Result> results;

    // Getters and setters
    // Constructor, equals, and hashCode if needed
}
