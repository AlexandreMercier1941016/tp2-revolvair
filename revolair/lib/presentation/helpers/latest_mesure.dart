import 'package:revolvair/domain/entities/measures_station/latest%20stats/average_latest_stats.dart';

String getLatestMesureText(AverageLatestStats? averageLatestStats) {
  if(averageLatestStats?.tenMinutes != null) {
    return "Il y a 10 minutes";
  }
  else if(averageLatestStats?.thirtyMinutes != null) {
    return "Il y a 30 minutes";
  }
  else if(averageLatestStats?.oneHour != null) {
    return "Il y a 1 heure";
  }
  else if(averageLatestStats?.sixHours != null) {
    return "Il y a 6 heures";
  }
  else if(averageLatestStats?.oneDay != null) {
    return "Il y a un 1 jour";
  }
  else if(averageLatestStats?.oneWeek != null) {
    return "Il y a une semaine";
  }
  return "Aucune modification";
}