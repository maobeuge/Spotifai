import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

part 'recorder_event.dart';
part 'recorder_state.dart';

class RecorderBloc extends Bloc<RecorderEvent, RecorderState> {
  final FlutterSoundRecorder recorder = FlutterSoundRecorder();

  late String tempDir;
  bool isRecording = false;

  RecorderBloc() : super(RecorderInitial()) {
    on<LoadRecorder>((event, emit) async {
      final PermissionStatus statusMic = await Permission.microphone.request();

      if (statusMic.isGranted) {
        final directory = await getTemporaryDirectory();
        tempDir = directory.path;

        emit(RecorderLoaded());
      }
    });

    on<PressRecordButton>((event, emit) async {
      if (!isRecording) {
        await recorder.openRecorder();
        await recorder.startRecorder(
          toFile: '$tempDir/audio.wav',
          codec: Codec.pcm16WAV,
          numChannels: 1,
          sampleRate: 44100,
        );
        isRecording = true;
        emit(RecorderRecording());
      } else {
        await recorder.stopRecorder();
        isRecording = false;

        emit(AudioRecorded(filePath: '$tempDir/audio.wav'));
      }
    });
  }

  @override
  Future<void> close() {
    recorder.closeRecorder();
    return super.close();
  }
}
