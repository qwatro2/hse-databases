package repositories;

import entities.Event;
import org.apache.commons.lang3.NotImplementedException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class OlympicRepositoryImpl implements OlympicRepository {

    private final Session session;

    public OlympicRepositoryImpl(Session session) {
        this.session = session;
    }

    @Override
    public List<Map<String, Object>> getBirthYearStatisticsFor2004() {
        String hql = "SELECT YEAR(p.birthDate), COUNT(p.playerId), SUM(CASE WHEN r.medal = 'GOLD' THEN 1 ELSE 0 END) " +
                "FROM Player p " +
                "JOIN Result r ON p.playerId = r.player.playerId " +
                "JOIN Event e ON r.event.eventId = e.eventId " +
                "JOIN Olympics o ON e.olympics.id = o.olympicId " +
                "WHERE o.year = 2004 " +
                "GROUP BY YEAR(p.birthDate)";

        List<Map<String, Object>> results = new ArrayList<>();

        Query<Object[]> query = session.createQuery(hql, Object[].class);
        List<Object[]> queryResults = query.getResultList();

        for (Object[] row : queryResults) {
            Map<String, Object> resultMap = new HashMap<>();
            resultMap.put("birthYear", row[0]);
            resultMap.put("playerCount", row[1]);
            resultMap.put("goldMedalCount", row[2]);
            results.add(resultMap);
        }

        return results;
    }

    @Override
    public List<Event> getIndividualEventsWithTies() {
        String hql = "SELECT e FROM Event e " +
                "JOIN Result r ON e.eventId = r.event.eventId " +
                "WHERE e.isTeamEvent = 0 AND r.medal = 'GOLD' " +
                "GROUP BY e.eventId, e.name, e.eventType, e.olympics.id," +
                " e.isTeamEvent, e.numPlayersInTeam, e.resultNotedIn " +
                "HAVING COUNT(DISTINCT r.player.playerId) > 1";
        Query<Event> query = session.createQuery(hql, Event.class);
        return query.getResultList();
    }

    @Override
    public List<Map<String, String>> getPlayersWithMedals() {
        String hql = "SELECT p.name, o.olympicId " +
                "FROM Player p " +
                "JOIN Result r ON p.playerId = r.player.playerId " +
                "JOIN Event e ON r.event.eventId = e.eventId " +
                "JOIN Olympics o ON e.olympics.id = o.olympicId " +
                "WHERE r.medal IN ('GOLD', 'SILVER', 'BRONZE') " +
                "GROUP BY p.name, o.olympicId";
        List<Map<String, String>> results = new ArrayList<>();

        Query<Object[]> query = session.createQuery(hql, Object[].class);
        List<Object[]> queryResults = query.getResultList();

        for (Object[] row : queryResults) {
            Map<String, String> resultMap = new HashMap<>();
            resultMap.put("playerName", (String) row[0]);
            resultMap.put("olympicId", (String) row[1]);
            results.add(resultMap);
        }

        return results;
    }

    @Override
    public Map<String, Object> getCountryWithHighestVowelPlayerPercentage() {
        String hql = "SELECT c.name, " +
                "COUNT(p.playerId) AS totalPlayers, " +
                "SUM(CASE WHEN LOWER(p.name) LIKE :vowelCondition THEN 1 ELSE 0 END) AS vowelPlayers " +
                "FROM Country c " +
                "JOIN Player p ON c.countryId = p.country.countryId " +
                "GROUP BY c.name " +
                "ORDER BY (SUM(CASE WHEN LOWER(p.name) LIKE :vowelCondition THEN 1 ELSE 0 END) / COUNT(p.playerId)) DESC";
        Map<String, Object> result = new HashMap<>();
        Query<Object[]> query = session.createQuery(hql, Object[].class);
        query.setParameter("vowelCondition", "'a%' OR p.name LIKE 'e%' OR " +
                "p.name LIKE 'i%' OR p.name LIKE 'o%' OR p.name LIKE 'u%'");
        List<Object[]> results = query.getResultList();
        if (!results.isEmpty()) {
            result.put("country", results.getFirst()[0]);
            result.put("percentage", results.getFirst()[1]);
        }

        return result;
    }

    @Override
    public List<String> getCountriesWithLowestTeamMedalRatio2000() {
        String hql = "WITH ss AS materialized(" +
                "SELECT c.name as name, COUNT(r.medal) / c.population as foo " +
                "FROM Country c " +
                "JOIN Player p ON c.countryId = p.country.id " +
                "JOIN Result r ON p.playerId = r.player.id " +
                "JOIN Event e ON r.event.id = e.id " +
                "JOIN Olympics o ON e.olympics.id = o.olympicId " +
                "WHERE o.year = 2000 AND e.isTeamEvent = 1 " +
                "GROUP BY c.name, c.population " +
                ") SELECT name FROM ss ORDER BY foo LIMIT 5";

        String hql2 = "SELECT name FROM (" +
                    "SELECT c.name as name, COUNT(r.medal) / c.population as avg" +
                    "FROM Country c" +
                    "JOIN Player p ON c.country_id = p.country_id" +
                    "JOIN Result r ON p.player_id = r.played_id" +
                    "JOIN Event e ON r.event_id = e.event_id" +
                    "JOIN Olympics o ON e.olympic.olympics_id = o.olympic_id" +
                    "WHERE o.year = 2000 AND e.is_team_event = 1" +
                    "GROUP BY c.name, c.population" +
                ") " +
                "ORDER BY avg" +
                "LIMIT 5";

        Query<String> query = session.createQuery(hql, String.class);
        return query.getResultList();
    }
}
