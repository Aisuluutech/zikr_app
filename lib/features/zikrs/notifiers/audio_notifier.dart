import 'package:dhikras/features/zikrs/services/audio_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class AudioNotifier extends StateNotifier<bool> {
  AudioNotifier() : super(false) {
    AudioService.audioPlayer.onPlayerComplete.listen((event) {
      state = false;
    });
  }

  Future<void> play(String path) async {
    await AudioService.playAsset(path);
    state = true;
  }

  Future<void> pause() async {
    await AudioService.pause();
    state = false;

  }

  Future<void> toggle(String path) async {
    if (state) {
      await pause();
    } else {
      await play(path);
    }
  }
}

