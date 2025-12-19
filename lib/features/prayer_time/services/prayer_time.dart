import 'dart:convert';
import 'package:adhan/adhan.dart';
import 'package:dhikras/features/prayer_time/models/prayer_time_model.dart';
import 'package:dhikras/features/prayer_time/services/geolocator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

Future<Map<String, dynamic>> getTimeZoneFromCoordinates(double lat, double lng) async {
  
  final apiKey = dotenv.env['GOOGLE_API_KEY'] ?? '';
  
  final timestamp = (DateTime.now().millisecondsSinceEpoch / 1000).round();

  final url = Uri.parse(
    'https://maps.googleapis.com/maps/api/timezone/json?location=$lat,$lng&timestamp=$timestamp&key=$apiKey',
  );

  final response = await http.get(url);
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return {
      'timeZoneId': data['timeZoneId'],
      'rawOffset': data['rawOffset'],
      'dstOffset': data['dstOffset'],
    };
  } else {
    throw Exception('Не удалось получить часовой пояс');
  }
}
Future<PrayerTimesModel> getPrayerTime() async {
  final position = await determinePosition();

  final coordinates = Coordinates(position.latitude, position.longitude);

  final timezone = await getTimeZoneFromCoordinates(
    position.latitude,
    position.longitude,
  );

  final rawOffset = timezone['rawOffset'] ?? 0;
  final dstOffset = timezone['dstOffset'] ?? 0;

  final nowUtc = DateTime.now().toUtc();
  final localTime = nowUtc.add(
    Duration(seconds: rawOffset + dstOffset),
  );

  final date = DateComponents.from(localTime);
  final params = CalculationMethod.muslim_world_league.getParameters();
  params.madhab = Madhab.shafi;

  final prayerTimes = PrayerTimes(coordinates, date, params);
  final format = DateFormat.Hm();

  return PrayerTimesModel(
    fajr: format.format(prayerTimes.fajr),
    shuruk: format.format(prayerTimes.sunrise),
    dhuhr: format.format(prayerTimes.dhuhr),
    asr: format.format(prayerTimes.asr),
    maghrib: format.format(prayerTimes.maghrib),
    isha: format.format(prayerTimes.isha),
  );
}




