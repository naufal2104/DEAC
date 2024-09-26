part of 'onboarding_screen_bloc.dart';

@immutable
abstract class OnboardScreenState {}

class OnboardScreenInitial extends OnboardScreenState {}

class OnboardLoadingState extends OnboardScreenState {}

class OnboardSuccessState extends OnboardScreenState {
  final OnboardModel onboardData;
  OnboardSuccessState({required this.onboardData});
}

class NextButtonBoardingScreen extends OnboardScreenState {}

class OnboardErrorState extends OnboardScreenState {}
