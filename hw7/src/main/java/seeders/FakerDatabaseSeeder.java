package seeders;

import com.github.javafaker.Faker;
import entities.*;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.sql.Date;
import java.time.LocalDate;
import java.util.HashSet;
import java.util.List;
import java.util.Random;
import java.util.Set;

public class FakerDatabaseSeeder implements DatabaseSeeder {
    private final Faker faker;
    private final Random random;

    public FakerDatabaseSeeder(Faker faker, Random random) {
        this.faker = faker;
        this.random = random;
    }

    @Override
    public void seedCountries(Session session, int count) {
        Transaction transaction = session.beginTransaction();

        for (int i = 0; i < count; i++) {
            Country country = new Country();
            country.setName(faker.letterify("?".repeat(40)));
            country.setCountryId(faker.letterify("?".repeat(3)));
            country.setAreaSqkm(faker.number().numberBetween(5000, 3000000));
            country.setPopulation(faker.number().numberBetween(100000, 1500000000));
            session.save(country);
        }

        transaction.commit();
    }

    @Override
    public void seedOlympics(Session session, int count) {
        Transaction transaction = session.beginTransaction();
        List<Country> countries = session.createQuery("from Country", Country.class).list();

        for (int i = 0; i < count; i++) {
            Olympics olympics = new Olympics();
            olympics.setOlympicId(faker.letterify("?".repeat(7)));
            olympics.setCountry(countries.get(random.nextInt(countries.size())));
            olympics.setCity(faker.letterify("?".repeat(50)));
            olympics.setYear(faker.number().numberBetween(1980, 2024));
            olympics.setStartDate(Date.valueOf(LocalDate.of(olympics.getYear(), 7, 1)));
            olympics.setEndDate(Date.valueOf(olympics.getStartDate()
                    .toLocalDate().plusDays(faker.number().numberBetween(10, 30))));
            session.save(olympics);
        }
        transaction.commit();
    }

    @Override
    public void seedPlayers(Session session, int count) {
        Transaction transaction = session.beginTransaction();
        List<Country> countries = session.createQuery("from Country", Country.class).list();

        for (int i = 0; i < count; i++) {
            Player player = new Player();
            player.setName(faker.letterify("?".repeat(40)));
            player.setPlayerId(faker.letterify("?".repeat(10)));
            player.setCountry(countries.get(random.nextInt(countries.size())));
            player.setBirthDate(Date.valueOf(faker.date().birthday(18, 40).toInstant()
                    .atZone(java.time.ZoneId.systemDefault()).toLocalDate()));
            session.save(player);
        }
        transaction.commit();
    }

    @Override
    public void seedEvents(Session session, int count) {
        Transaction transaction = session.beginTransaction();
        List<Olympics> olympics = session.createQuery("from Olympics", Olympics.class).list();

        for (int i = 0; i < count; i++) {
            Event event = new Event();
            event.setEventId(faker.letterify("?".repeat(7)));
            event.setName(faker.letterify("?".repeat(40)));
            event.setEventType(faker.options().option("Individual", "Team"));
            event.setOlympics(olympics.get(random.nextInt(olympics.size())));
            event.setIsTeamEvent("Team".equals(event.getEventType()) ? 1 : 0);
            event.setNumPlayersInTeam(event.getIsTeamEvent() == 1 ? faker.number().numberBetween(2, 11) : 1);
            event.setResultNotedIn(faker.options().option("Time", "Distance", "Score"));
            session.save(event);
        }
        transaction.commit();
    }

    @Override
    public void seedResults(Session session, int count) {
        Transaction transaction = session.beginTransaction();
        List<Event> events = session.createQuery("from Event", Event.class).list();
        List<Player> players = session.createQuery("from Player", Player.class).list();

        for (int i = 0; i < count; i++) {
            Result result = new Result();
            result.setEvent(events.get(random.nextInt(events.size())));
            result.setPlayer(players.get(random.nextInt(players.size())));
            result.setMedal(faker.options().option("GOLD", "SILVER", "BRONZE", null));
            result.setResult(faker.number().randomDouble(2, 1, 100));
            session.merge(result);
        }
        transaction.commit();
    }
}
