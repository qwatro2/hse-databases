package entities;

import lombok.Getter;

import java.io.Serializable;
import java.util.Objects;

@Getter
public class ResultId implements Serializable {
    private String event;
    private String player;

    public ResultId() {}

    public ResultId(String event, String player) {
        this.event = event;
        this.player = player;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ResultId that = (ResultId) o;
        return Objects.equals(event, that.event) && Objects.equals(player, that.player);
    }

    @Override
    public int hashCode() {
        return Objects.hash(event, player);
    }
}
