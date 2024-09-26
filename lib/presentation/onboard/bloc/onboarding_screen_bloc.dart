import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

import '../../../model/onboard_model.dart';

part 'onboarding_screen_event.dart';
part 'onboarding_screen_state.dart';

class OnboardingScreenBloc
    extends Bloc<OnboardingScreenEvent, OnboardScreenState> {
  int currentIndex = 0;
  OnboardingScreenBloc() : super(OnboardScreenInitial()) {
    on<OnboardInitialEvent>(onboardInitialEvent);
    on<ChangeEvent>(changeIndexData);
  }

  FutureOr<void> onboardInitialEvent(
      OnboardInitialEvent event, Emitter<OnboardScreenState> emit) async {
    emit(OnboardLoadingState());

    emit(OnboardSuccessState(onboardData: onboardData[currentIndex]));
  }

  FutureOr<void> changeIndexData(
    ChangeEvent event,
    Emitter<OnboardScreenState> emit,
  ) {
    currentIndex++;
    if (currentIndex >= onboardData.length) {
      currentIndex = 0;
    }
    emit(OnboardSuccessState(onboardData: onboardData[currentIndex]));
  }
}
