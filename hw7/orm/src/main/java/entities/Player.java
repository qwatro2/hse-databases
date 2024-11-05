package entities;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.time.LocalDate;
import java.util.List;
import java.util.Set;

@Entity
@Table(name = "players")
@Getter
@Setter
public class Player {
    @Id
    @Column(name = "player_id", length = 10, nullable = false, unique = true)
    private String playerId;

    @Column(name = "name", length = 40, nullable = false)
    private String name;

    @ManyToOne
    @JoinColumn(name = "country_id")
    private Country country;

    @Column(name = "birthdate")
    private java.sql.Date birthDate;
}
