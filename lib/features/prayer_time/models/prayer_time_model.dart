class PrayerTimesModel {
  final String fajr;
  final String shuruk;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;

  PrayerTimesModel({
    required this.fajr,
    required this.shuruk,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
  });

  Map<String, String> toJson() {
    return {
      'Fajr': fajr,
      'Shuruk': shuruk,
      'Dhuhr': dhuhr,
      'Asr': asr,
      'Maghrib': maghrib,
      'Isha': isha,
    };
  }
}
