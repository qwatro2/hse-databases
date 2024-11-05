import com.github.javafaker.Faker;
import entities.Event;
import lombok.experimental.UtilityClass;
import org.hibernate.Session;
import repositories.OlympicRepository;
import repositories.OlympicRepositoryImpl;
import seeders.DatabaseSeeder;
import seeders.FakerDatabaseSeeder;
import utils.HibernateUtil;

import java.util.List;
import java.util.Map;
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

        List<Map<String, Object>> task1;
        List<Event> task2;
        List<Map<String, String>> task3;
        Map<String, Object> task4;
        List<Map<String, Object>> task5;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            OlympicRepository olympicRepository = new OlympicRepositoryImpl(session);
            task1 = olympicRepository.getBirthYearStatisticsFor2004();
            task2 = olympicRepository.getIndividualEventsWithTies();
            task3 = olympicRepository.getPlayersWithMedals();
            task4 = olympicRepository.getCountryWithHighestVowelPlayerPercentage();
            task5 = olympicRepository.getCountriesWithLowestTeamMedalRatio2000();
        }

        print("task1", task1);
        System.out.println("task2: " + task2);
        print("task3", task3);
        print("task4", List.of(task4));
        print("task5", task5);

        HibernateUtil.shutdown();
    }

    private static <T> void print(String title, List<Map<String, T>> list) {
        if (list == null) {
            System.out.println("null");
            return;
        }

        System.out.println("\"" + title + "\": [");
        for (Map<String, T> map : list) {
            System.out.println("\t{");
            for (String key : map.keySet()) {
                System.out.println("\t\t\"" + key + "\": " + map.get(key) + ",");
            }
            System.out.println("\t},");
        }
        System.out.println("]");
    }
}
