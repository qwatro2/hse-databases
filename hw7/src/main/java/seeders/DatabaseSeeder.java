package seeders;

import org.hibernate.Session;

public interface DatabaseSeeder {
    void seedCountries(Session session, int count);

    void seedOlympics(Session session, int count);

    void seedPlayers(Session session, int count);

    void seedEvents(Session session, int count);

    void seedResults(Session session, int count);
}
