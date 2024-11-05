import com.github.javafaker.Faker;
import lombok.experimental.UtilityClass;
import org.hibernate.Session;
import seeders.DatabaseSeeder;
import seeders.FakerDatabaseSeeder;
import utils.HibernateUtil;

import java.util.Random;

@UtilityClass
public class Main {
    public static void main(String[] args) {
        DatabaseSeeder databaseSeeder = new FakerDatabaseSeeder(new Faker(), new Random(142857));

        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            databaseSeeder.seedCountries(session, 10);
            databaseSeeder.seedOlympics(session, 5);
            databaseSeeder.seedPlayers(session, 50);
            databaseSeeder.seedEvents(session, 20);
            databaseSeeder.seedResults(session, 100);
        }
        HibernateUtil.shutdown();
    }
}
