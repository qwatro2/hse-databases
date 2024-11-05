package entities;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.time.LocalDate;
import java.util.Set;

@Entity
@Table(name = "olympics")
@Getter
@Setter
public class Olympic {

    @Id
    @Column(name = "olympic_id", length = 7, nullable = false, unique = true)
    private String olympicId;

    @ManyToOne
    @JoinColumn(name = "country_id", referencedColumnName = "country_id")
    private Country country;

    @Column(name = "city", length = 50)
    private String city;

    @Column(name = "year")
    private Integer year;

    @Column(name = "startdate")
    private LocalDate startDate;

    @Column(name = "enddate")
    private LocalDate endDate;

    @OneToMany(mappedBy = "olympic", cascade = CascadeType.ALL)
    private Set<Event> events;

    // Getters and setters
    // Constructor, equals, and hashCode if needed
}
