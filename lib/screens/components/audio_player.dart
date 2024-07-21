import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotifai/services/audio/audio_bloc.dart';
import 'package:spotifai/services/character/character_bloc.dart';

class AudioPlayerComponent extends StatelessWidget {
  const AudioPlayerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioBloc, AudioState>(
      builder: (context, state) {
        if (state is AudioSent) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BlocBuilder<CharacterBloc, CharacterState>(
                      builder: (context, characterState) {
                        if (characterState is CharacterLoaded) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 16, right: 20),
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(
                                      characterState.character.imageUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        } else {
                          return const SizedBox(
                            width: 76,
                          );
                        }
                      },
                    ),
                    const Spacer(),
                    AnimatedPlayButton(isPlaying: state.isPlaying),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 16, top: 2),
                      child: SizedBox(
                        width: 60,
                        height: 30,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.transparent),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  side: const BorderSide(
                                    width: 1,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              elevation: MaterialStateProperty.all<double>(0),
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                const EdgeInsets.all(10),
                              )),
                          onPressed: () {},
                          child: const SizedBox(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: Slider(
                  min: 0,
                  max: state.duration.inMilliseconds.toDouble(),
                  onChanged: (position) {
                    context
                        .read<AudioBloc>()
                        .add(SeekAudio(position: position));
                  },
                  value: state.position.inMilliseconds != -1
                      ? state.position.inMilliseconds.toDouble()
                      : 0,
                  activeColor: Colors.purple,
                  inactiveColor: Colors.white,
                  thumbColor: Colors.white,
                ),
              ),
            ],
          );
        }

        if (state is AudioLoaded) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BlocBuilder<CharacterBloc, CharacterState>(
                      builder: (context, characterState) {
                        if (characterState is CharacterLoaded) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 16, right: 20),
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(
                                      characterState.character.imageUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        } else {
                          return const SizedBox(
                            width: 76,
                          );
                        }
                      },
                    ),
                    const Spacer(),
                    AnimatedPlayButton(isPlaying: state.isPlaying),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 16, top: 2),
                      child: SizedBox(
                        width: 60,
                        height: 30,
                        child: BlocBuilder<CharacterBloc, CharacterState>(
                          builder: (context, characterState) {
                            if (characterState is CharacterLoaded) {
                              return ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.transparent),
                                    shape: MaterialStateProperty.all<
                                        OutlinedBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18),
                                        side: const BorderSide(
                                          width: 1,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    elevation:
                                        MaterialStateProperty.all<double>(0),
                                    padding: MaterialStateProperty.all<
                                        EdgeInsetsGeometry>(
                                      const EdgeInsets.all(10),
                                    )),
                                onPressed: () => context.read<AudioBloc>().add(
                                    SendAudio(
                                        voiceId:
                                            characterState.character.voiceId)),
                                child: LayoutBuilder(
                                    builder: (context, constraint) {
                                  return Text(
                                    'AI-ME',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: constraint.biggest.height,
                                    ),
                                  );
                                }),
                              );
                            } else {
                              return ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.transparent),
                                    shape: MaterialStateProperty.all<
                                        OutlinedBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18),
                                        side: const BorderSide(
                                          width: 1,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    elevation:
                                        MaterialStateProperty.all<double>(0),
                                    padding: MaterialStateProperty.all<
                                        EdgeInsetsGeometry>(
                                      const EdgeInsets.all(10),
                                    )),
                                onPressed: () {},
                                child: LayoutBuilder(
                                    builder: (context, constraint) {
                                  return Text(
                                    'AI-ME',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: constraint.biggest.height,
                                    ),
                                  );
                                }),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: Slider(
                  min: 0,
                  max: state.duration.inMilliseconds.toDouble(),
                  onChanged: (position) {
                    context
                        .read<AudioBloc>()
                        .add(SeekAudio(position: position));
                  },
                  value: state.position.inMilliseconds != -1
                      ? state.position.inMilliseconds.toDouble()
                      : 0,
                  activeColor: Colors.purple,
                  inactiveColor: Colors.white,
                  thumbColor: Colors.white,
                ),
              ),
            ],
          );
        }

        if (state is NoAudioLoaded) {
          return Column(
            children: [
              Row(
                children: [
                  BlocBuilder<CharacterBloc, CharacterState>(
                    builder: (context, characterState) {
                      if (characterState is CharacterLoaded) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 16, right: 20),
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(
                                    characterState.character.imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox(
                          width: 76,
                        );
                      }
                    },
                  ),
                  const Spacer(),
                  const Padding(
                    padding: EdgeInsets.only(top: 12, bottom: 4),
                    child: Icon(
                      Icons.play_arrow,
                      size: 32,
                      color: Colors.grey,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(
                    width: 76,
                  )
                ],
              ),
              SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: Slider(
                  min: 0,
                  max: 1,
                  onChanged: (position) {},
                  value: 0,
                  activeColor: Colors.purple,
                  inactiveColor: Colors.grey,
                  thumbColor: Colors.grey,
                ),
              ),
            ],
          );
        }

        return const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        );
      },
    );
  }
}

class AnimatedPlayButton extends StatefulWidget {
  final bool isPlaying;

  const AnimatedPlayButton({required this.isPlaying, super.key});

  @override
  State<AnimatedPlayButton> createState() => _AnimatedPlayButtonState();
}

class _AnimatedPlayButtonState extends State<AnimatedPlayButton>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  bool playing = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    animation = Tween<double>(begin: 0, end: 1).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (playing != widget.isPlaying) {
      if (widget.isPlaying) {
        controller.forward();
      } else {
        controller.reverse();
      }
      playing = widget.isPlaying;
    }

    return SizedBox(
      width: 40,
      height: 40,
      child: Center(
        child: InkWell(
          onTap: () {
            if (widget.isPlaying) {
              context.read<AudioBloc>().add(PauseAudio());
            } else {
              context.read<AudioBloc>().add(PlayAudio());
            }
          },
          child: AnimatedIcon(
            icon: AnimatedIcons.play_pause,
            progress: animation,
            size: 32,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
