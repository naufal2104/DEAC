import 'package:DEAC/presentation/Login_Register/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/onboard_model.dart';
import '../../../util/ucolors.dart';
import '../../../util/usizes.dart';
import '../bloc/onboarding_screen_bloc.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  @override
  void initState() {
    homebloc.add(OnboardInitialEvent());
    super.initState();
  }

  final homebloc = OnboardingScreenBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocConsumer<OnboardingScreenBloc, OnboardScreenState>(
            bloc: homebloc,
            listener: (context, state) {},
            builder: (context, state) {
              switch (state.runtimeType) {
                case OnboardSuccessState:
                  final currentState = state as OnboardSuccessState;
                  final OnboardModel onboard = currentState.onboardData;
                  return Column(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              fixedSize: const Size(80, 40),
                              backgroundColor:
                                   Color(0xFF88D8FF)),
                          child: const Text(
                            "Skip",
                            style: TextStyle(
                              color: UColors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: USizes.deviceWidth(context) * 1,
                        height: USizes.deviceHeight(context) * 0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: AssetImage(onboard.imagePath),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 60),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  onboard.title,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 60,
                                vertical: 12,
                              ),
                              child: Text(
                                onboard.subtitle,
                                style: const TextStyle(fontSize: 14),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 12,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  for (int i = 0; i < onboardData.length; i++)
                                    Padding(
                                      padding: const EdgeInsets.all(4),
                                      child: Container(
                                        width: i == onboard.id - 1 ? 36 : 12,
                                        height: 6,
                                        decoration: BoxDecoration(
                                          color: i == onboard.id - 1
                                              ?  Color(0xFF88D8FF)
                                              :  Color(0xFF88D8FF)
                                                  .withOpacity(
                                                  0.5,
                                                ),
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (homebloc.currentIndex < 2) {
                                    homebloc.add(ChangeEvent());
                                  } else {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginScreen(),
                                      ),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(200, 40),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    backgroundColor:
                                         Color(0xFF88D8FF)),
                                child: const Text(
                                  "Selanjutnya",
                                  style: TextStyle(
                                    color: UColors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );

                default:
                  return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
