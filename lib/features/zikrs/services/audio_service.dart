import 'package:audioplayers/audioplayers.dart';


class AudioService {
  static final AudioPlayer audioPlayer = AudioPlayer();


  static Future<void> playAsset(String path) async {
    await audioPlayer.stop();
    await audioPlayer.play(AssetSource(path));
  }

  static Future<void> pause() async {
    await audioPlayer.pause();
  } 

  static Future<void> stop() async {
    await audioPlayer.stop();
  }

  static bool get isPlaying => audioPlayer.state == PlayerState.playing;
  static bool get isPaused => audioPlayer.state == PlayerState.paused;
  static bool get isStopped => audioPlayer.state == PlayerState.stopped;
}
