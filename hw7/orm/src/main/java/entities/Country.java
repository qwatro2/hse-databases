package entities;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table(name = "countries")
@Getter
@Setter
public class Country {
    @Id
    @Column(name = "country_id", length = 3, nullable = false, unique = true)
    private String countryId;

    @Column(name = "name", length = 40, nullable = false)
    private String name;

    @Column(name = "area_sqkm")
    private Integer areaSqkm;

    @Column(name = "population")
    private Integer population;
}
