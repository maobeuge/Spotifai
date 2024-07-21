import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotifai/screens/components/character_modal.dart';
import 'package:spotifai/screens/recorder_screen.dart';
import 'package:spotifai/services/audio/audio_bloc.dart';
import 'package:spotifai/services/character/character_bloc.dart';
import 'package:spotifai/services/navigation/navigation_bloc.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1f1f1f),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  NavigationBloc()..add(const LoadIndexNavigation())),
          BlocProvider(
              create: (context) => AudioBloc()..add(InitializePlayer())),
          BlocProvider(
              create: (context) => CharacterBloc()..add(InitializeCharacter())),
        ],
        child: SafeArea(
          child: Stack(
            children: [
              BlocBuilder<NavigationBloc, NavigationState>(
                builder: (context, state) {
                  if (state is NavigationLoaded) {
                    if (state.index == NavigationEnum.landing) {
                      return const RecorderScreen();
                    }
                  }

                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                },
              ),
              const CharacterModal(),
            ],
          ),
        ),
      ),
    );
  }
}
