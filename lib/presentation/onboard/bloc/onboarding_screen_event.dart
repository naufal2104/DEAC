part of 'onboarding_screen_bloc.dart';

@immutable
sealed class OnboardingScreenEvent {}

class OnboardInitialEvent extends OnboardingScreenEvent {}

class ChangeEvent extends OnboardingScreenEvent {}
