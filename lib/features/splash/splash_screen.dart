import 'package:flutter/material.dart';
import '../home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colorScheme.surface,
              colorScheme.primaryContainer.withOpacity(0.3),
              colorScheme.surface,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Expanded(
                flex: 2,
                child: SizedBox(),
              ),

              Container(
                width: size.width * 0.45,
                height: size.height * 0.45,
                  decoration: BoxDecoration(

                    color: Colors.blue,

                    borderRadius: BorderRadius.circular(25)
                  ),
                  child: Image.asset(
                    'assets/logo/app_logo.png',
                    width: size.width * 0.45,
                    height: size.height * 0.45,

                  ),
                ),

              SizedBox(height: size.height * 0.015),
              Text(
                'Weatherly',
                style: TextStyle(
                  fontSize: size.width * 0.08,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              SizedBox(height: size.height * 0.01),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.08,
                ),
                child: Text(
                  'Your weather, anywhere in the world.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: size.width * 0.035,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              const Expanded(
                flex: 2,
                child: SizedBox(),
              ),
              CircularProgressIndicator(
                strokeWidth: 3,
                color: colorScheme.primary,
              ),
              SizedBox(height: size.height * 0.015),
              Text(
                'Checking the latest weather...',
                style: TextStyle(
                  fontSize: size.width * 0.03,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const Expanded(
                flex: 2,
                child: SizedBox(),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: size.height * 0.02,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.public_rounded,
                      size: size.width * 0.04,
                      color: colorScheme.primary,
                    ),
                    SizedBox(width: size.width * 0.015),
                    Text(
                      'Weather for every city',
                      style: TextStyle(
                        fontSize: size.width * 0.028,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
