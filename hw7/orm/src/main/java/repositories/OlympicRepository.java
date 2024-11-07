package repositories;

import entities.Event;

import java.util.List;
import java.util.Map;

public interface OlympicRepository {
    List<Map<String, Object>> getBirthYearStatisticsFor2004();

    List<Event> getIndividualEventsWithTies();

    List<Map<String, String>> getPlayersWithMedals();

    Map<String, Object> getCountryWithHighestVowelPlayerPercentage();

    List<String> getCountriesWithLowestTeamMedalRatio2000();
}
