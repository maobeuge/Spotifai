import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

enum NavigationEnum {
  landing,
}

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationEnum actualIndex = NavigationEnum.landing;

  NavigationBloc() : super(NavigationInitial()) {
    on<LoadIndexNavigation>((event, emit) {
      emit(NavigationLoaded(index: actualIndex));
    });

    on<ChangeIndexNavigation>((event, emit) {
      actualIndex = event.index;
      emit(NavigationLoaded(index: actualIndex));
    });
  }
}
