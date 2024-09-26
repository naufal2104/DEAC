class OnboardModel {
  final int id;
  final String imagePath;
  final String title;
  final String subtitle;

  OnboardModel(
      {required this.id,
      required this.imagePath,
      required this.title,
      required this.subtitle});
}

List<OnboardModel> onboardData = [
  OnboardModel(
    id: 1,
    imagePath: "assets/images/onboard1.png",
    title: "Belajar Lebih dalam Seputar Komputer",
    subtitle:
        "Sebuah Aplikasi E-learning yang membantumu Meningkatkan kemampuan di bidang komputer",
  ),
  OnboardModel(
    id: 2,
    imagePath: "assets/images/onboard2.png",
    title: "Semua Bahasa dalam Genggaman Anda",
    subtitle: "Dari Python hingga JavaScript, akses pembelajaran di mana saja dan kapan saja",
  ),
    OnboardModel(
    id: 3,
    imagePath: "assets/images/onboard3.png",
    title: "Asah Kemampuanmu!",
    subtitle: "Evaluasi dan kembangkan keterampilanmu dengan post-test yang kami berikan",
  ),
];
