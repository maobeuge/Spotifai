import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotifai/screens/components/audio_player.dart';
import 'package:spotifai/services/character/character_bloc.dart';

class CharacterModal extends StatefulWidget {
  const CharacterModal({super.key});

  @override
  State<CharacterModal> createState() => _CharacterModalState();
}

class _CharacterModalState extends State<CharacterModal> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return AnimatedPositioned(
      top: isOpen ? 0 : size.height * .8,
      duration: const Duration(milliseconds: 350),
      child: AnimatedContainer(
        alignment: Alignment.topCenter,
        height: isOpen ? size.height : size.height * .2,
        width: size.width,
        duration: const Duration(milliseconds: 350),
        decoration: BoxDecoration(
          borderRadius:
              isOpen ? BorderRadius.circular(0) : BorderRadius.circular(24),
          border: Border.all(width: 0),
          color: const Color(0xff2f2f2f).withOpacity(.9),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => setState(() {
                isOpen = !isOpen;
              }),
              child: Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 32,
                      height: 4,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            BlocBuilder<CharacterBloc, CharacterState>(
              builder: (context, state) {
                if (state is CharacterLoaded) {
                  print(state.characterList.toString());
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 16),
                      child: GridView.builder(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 16),
                        itemCount: state.characterList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                        ),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              context.read<CharacterBloc>().add(LoadCharacter(
                                  character: state.characterList[index]));
                              setState(() {
                                isOpen = !isOpen;
                              });
                            },
                            child: Column(
                              children: [
                                Expanded(
                                  child: LayoutBuilder(
                                      builder: (context, constraint) {
                                    return Container(
                                      width: constraint.biggest.width * .8,
                                      height: constraint.biggest.height * .8,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(state
                                              .characterList[index].imageUrl),
                                          fit: BoxFit.cover,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }

                if (state is NoCharacterLoaded) {
                  print(state.characterList);
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 16),
                      child: GridView.builder(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 16),
                        itemCount: state.characterList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                        ),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              context.read<CharacterBloc>().add(LoadCharacter(
                                  character: state.characterList[index]));
                              setState(() {
                                isOpen = !isOpen;
                              });
                            },
                            child: Column(
                              children: [
                                Expanded(
                                  child: LayoutBuilder(
                                      builder: (context, constraint) {
                                    return Container(
                                      width: constraint.biggest.width * .8,
                                      height: constraint.biggest.height * .8,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: NetworkImage(state
                                              .characterList[index].imageUrl),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
                log('TESTESTTES');

                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * .2 - 24,
                  child: const AudioPlayerComponent(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
