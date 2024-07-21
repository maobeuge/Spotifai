import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotifai/constants/ui_helper.dart';
import 'package:spotifai/domain/ai_repository/ai_repository.dart';

part 'audio_event.dart';
part 'audio_state.dart';

class AudioBloc extends Bloc<AudioEvent, AudioState> {
  final AudioPlayer player = AudioPlayer();
  final AiRepository aiRepository = AiRepository();
  bool isAudioEmpty = true;
  bool isPlaying = false;
  late String directory;
  Duration position = Duration.zero;
  Duration trackLength = Duration.zero;
  StreamSubscription? positionStream;
  StreamSubscription? endAudio;
  StreamSubscription? durationStream;
  late String filePath;

  AudioBloc() : super(AudioInitial()) {
    on<InitializePlayer>((event, emit) {
      emit(NoAudioLoaded());
    });

    on<LoadAudio>((event, emit) async {
      directory = (await getTemporaryDirectory()).path;

      try {
        filePath = event.filePath;
        await player.setAudioSource(AudioSource.file(filePath));

        trackLength = player.duration ?? const Duration(seconds: 0);

        positionStream ??= player.positionStream.listen((newPosition) {
          add(AudioIsProgressing(position: newPosition));
        });

        endAudio ??= player.playerStateStream.listen((playerState) {
          if (playerState.processingState == ProcessingState.completed) {
            add(AudioIsCompleted());
          }
        });

        isAudioEmpty = false;
        emit(AudioLoaded(
          isAudioEmpty: isAudioEmpty,
          isPlaying: isPlaying,
          position: position,
          duration: trackLength,
          filePath: filePath,
        ));
      } catch (e) {
        emit(NoAudioLoaded());
      }
    });

    on<PlayAudio>((event, emit) async {
      player.play();
      isPlaying = true;

      emit(AudioLoaded(
        isAudioEmpty: isAudioEmpty,
        isPlaying: isPlaying,
        position: position,
        duration: trackLength,
        filePath: filePath,
      ));
    });

    on<AudioIsCompleted>((event, emit) async {
      await player.pause();
      await player.seek(Duration.zero);
      filePath = '$directory/audio.wav';
      isPlaying = false;

      emit(AudioLoaded(
        isAudioEmpty: isAudioEmpty,
        isPlaying: isPlaying,
        position: position,
        duration: trackLength,
        filePath: filePath,
      ));
    });

    on<PauseAudio>((event, emit) async {
      await player.pause();
      isPlaying = false;

      emit(AudioLoaded(
        isAudioEmpty: isAudioEmpty,
        isPlaying: isPlaying,
        position: position,
        duration: trackLength,
        filePath: filePath,
      ));
    });

    on<SeekAudio>((event, emit) async {
      final Duration newPosition =
          Duration(milliseconds: event.position.toInt());
      await player.seek(newPosition);

      emit(AudioLoaded(
        isAudioEmpty: isAudioEmpty,
        isPlaying: isPlaying,
        position: position,
        duration: trackLength,
        filePath: filePath,
      ));
    });

    on<AudioIsProgressing>((event, emit) async {
      position = event.position;

      emit(AudioLoaded(
        isAudioEmpty: isAudioEmpty,
        isPlaying: isPlaying,
        position: position,
        duration: trackLength,
        filePath: filePath,
      ));
    });

    on<DurationChanged>((event, emit) {
      trackLength = event.length;
      emit(AudioLoaded(
        isAudioEmpty: isAudioEmpty,
        isPlaying: isPlaying,
        position: position,
        duration: trackLength,
        filePath: filePath,
      ));
    });

    on<SendAudio>((event, emit) async {
      emit(
        AudioSent(
            isAudioEmpty: isAudioEmpty,
            isPlaying: isPlaying,
            position: position,
            duration: trackLength,
            filePath: filePath,
            progression: 0),
      );
      final ResponseModel response =
          await aiRepository.generateVoice(filePath, event.voiceId);
      if (response.httpCode == 200) {
        add(LoadAudio(filePath: response.content['file']));
      } else {
        emit(AudioLoaded(
            isAudioEmpty: isAudioEmpty,
            isPlaying: isPlaying,
            position: position,
            duration: trackLength,
            filePath: filePath));
      }
    });
  }

  @override
  Future<void> close() async {
    positionStream?.cancel();
    endAudio?.cancel();
    durationStream?.cancel();
    await player.stop();
    return super.close();
  }
}
