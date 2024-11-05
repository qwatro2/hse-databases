package entities;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table(name = "olympics")
@Getter
@Setter
public class Olympics {
    @Id
    @Column(name = "olympic_id", length = 7, nullable = false, unique = true)
    private String olympicId;

    @ManyToOne
    @JoinColumn(name = "country_id")
    private Country country;

    @Column(name = "city", length = 50)
    private String city;

    @Column(name = "year")
    private Integer year;

    @Column(name = "startdate")
    private java.sql.Date startDate;

    @Column(name = "enddate")
    private java.sql.Date endDate;
}
