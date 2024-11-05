package entities;

import javax.persistence.Embeddable;
import java.io.Serializable;

@Embeddable
public class ResultId implements Serializable {

    private String eventId;
    private String playerId;

    public ResultId() {}

    public ResultId(String eventId, String playerId) {
        this.eventId = eventId;
        this.playerId = playerId;
    }

    // Getters, setters, equals, and hashCode
}
