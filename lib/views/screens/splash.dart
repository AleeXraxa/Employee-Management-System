import 'package:employee_management_system/core/app_exports.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> logoFadeAnimation;
  late Animation<double> logoScaleAnimation;
  late Animation<double> textFadeAnimation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );

    logoFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.33, curve: Curves.easeIn),
      ),
    );
    logoScaleAnimation = Tween<double>(begin: 0.6, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.50, 1, curve: Curves.easeInOutBack),
      ),
    );
    textFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.50, 0.70, curve: Curves.easeIn),
      ),
    );

    animationController.forward();
    navigate();
  }

  void navigate() async {
    await Future.delayed(
        animationController.duration! + const Duration(seconds: 2));
    Get.offAll(() => const Login());
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 0.1.sh),
            AnimatedBuilder(
              animation: animationController,
              builder: (_, child) {
                return Opacity(
                  opacity: logoFadeAnimation.value.clamp(0.0, 1.0),
                  child: Transform.scale(
                    scale: logoScaleAnimation.value,
                    child: child,
                  ),
                );
              },
              child: Container(
                width: 0.5.sw,
                height: 0.2.sh,
                child: Image.asset('assets/images/logo.png'),
              ),
            ),
            SizedBox(height: 0.05.sh),
            AnimatedBuilder(
              animation: animationController,
              builder: (_, child) {
                return Opacity(
                  opacity: textFadeAnimation.value.clamp(0.0, 1.0),
                  child: child,
                );
              },
              child: Text(
                'EMPLOYEE MANAGEMENT SYSTEM',
                style: AppTextStyles.splash,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
