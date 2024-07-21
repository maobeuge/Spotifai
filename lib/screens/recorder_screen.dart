import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotifai/services/audio/audio_bloc.dart';
import 'package:spotifai/services/recorder/recorder_bloc.dart';

class RecorderScreen extends StatelessWidget {
  const RecorderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xff1f1f1f),
      body: SafeArea(
        child: Center(
          child: BlocProvider(
            create: (context) => RecorderBloc()..add(LoadRecorder()),
            child: BlocBuilder<RecorderBloc, RecorderState>(
              builder: (context, state) {
                if (state is AudioRecorded) {
                  Future.delayed(
                      Duration.zero,
                      () => context
                          .read<AudioBloc>()
                          .add(LoadAudio(filePath: state.filePath)));

                  return Column(
                    children: [
                      SizedBox(
                        width: size.width,
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 16, left: 16),
                              child: Text(
                                "Record",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 38,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 0, left: 16),
                              child: Text(
                                "Your voice",
                                style: TextStyle(
                                  color: Colors.purple,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          width: size.width * .6,
                          height: size.width * .6,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 6,
                              color: Colors.white,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              elevation: MaterialStateProperty.all<double>(0),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                const CircleBorder(),
                              ),
                            ),
                            onPressed: () {
                              context
                                  .read<RecorderBloc>()
                                  .add(PressRecordButton());
                            },
                            child:
                                LayoutBuilder(builder: (context, constraint) {
                              return Icon(
                                Icons.mic_outlined,
                                color: Colors.grey,
                                size: constraint.biggest.height * .35,
                              );
                            }),
                          ),
                        ),
                      ),
                      const Spacer(),
                    ],
                  );
                }

                if (state is RecorderRecording) {
                  return Column(
                    children: [
                      SizedBox(
                        width: size.width,
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 16, left: 16),
                              child: Text(
                                "Record",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 38,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 0, left: 16),
                              child: Text(
                                "Your voice",
                                style: TextStyle(
                                  color: Colors.purple,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          width: size.width * .6,
                          height: size.width * .6,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 6,
                              color: Colors.white,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              elevation: MaterialStateProperty.all<double>(0),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                const CircleBorder(),
                              ),
                            ),
                            onPressed: () {
                              context
                                  .read<RecorderBloc>()
                                  .add(PressRecordButton());
                            },
                            child:
                                LayoutBuilder(builder: (context, constraint) {
                              return Icon(
                                Icons.stop_rounded,
                                color: Colors.grey,
                                size: constraint.biggest.height * .4,
                              );
                            }),
                          ),
                        ),
                      ),
                      const Spacer(),
                    ],
                  );
                }

                if (state is RecorderLoaded) {
                  return Column(
                    children: [
                      SizedBox(
                        width: size.width,
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 16, left: 16),
                              child: Text(
                                "Record",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 38,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 0, left: 16),
                              child: Text(
                                "Your voice",
                                style: TextStyle(
                                  color: Colors.purple,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          width: size.width * .6,
                          height: size.width * .6,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 6,
                              color: Colors.white,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              elevation: MaterialStateProperty.all<double>(0),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                const CircleBorder(),
                              ),
                            ),
                            onPressed: () {
                              context
                                  .read<RecorderBloc>()
                                  .add(PressRecordButton());
                            },
                            child:
                                LayoutBuilder(builder: (context, constraint) {
                              return Icon(
                                Icons.mic_outlined,
                                color: Colors.grey,
                                size: constraint.biggest.height * .35,
                              );
                            }),
                          ),
                        ),
                      ),
                      const Spacer(),
                    ],
                  );
                }

                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
