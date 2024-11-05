package entities;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.time.LocalDate;
import java.util.Set;

@Entity
@Table(name = "players")
@Getter
@Setter
public class Player {

    @Id
    @Column(name = "player_id", length = 10, nullable = false, unique = true)
    private String playerId;

    @Column(name = "name", length = 40)
    private String name;

    @ManyToOne
    @JoinColumn(name = "country_id", referencedColumnName = "country_id")
    private Country country;

    @Column(name = "birthdate")
    private LocalDate birthdate;

    @OneToMany(mappedBy = "player", cascade = CascadeType.ALL)
    private Set<Result> results;

    // Getters and setters
    // Constructor, equals, and hashCode if needed
}
