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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final size = MediaQuery.of(context).size;

    final bool isTablet = size.width >= 600;

    final double horizontalPadding =
    isTablet ? size.width * 0.12 : size.width * 0.08;

    final double logoWidth = isTablet
        ? size.width * 0.32
        : size.width * 0.58;

    final double titleSize = isTablet ? 42 : 34;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colorScheme.surface,
              colorScheme.primaryContainer.withOpacity(0.35),
              colorScheme.surface,
            ],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: size.height * 0.04,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),

                        Container(
                          padding: EdgeInsets.all(
                            isTablet ? 20 : 14,
                          ),
                          decoration: BoxDecoration(
                            color: colorScheme.surface.withOpacity(0.65),
                            borderRadius: BorderRadius.circular(
                              isTablet ? 32 : 26,
                            ),
                            border: Border.all(
                              color: colorScheme.outlineVariant
                                  .withOpacity(0.5),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: colorScheme.primary.withOpacity(0.12),
                                blurRadius: 35,
                                spreadRadius: 4,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              isTablet ? 24 : 20,
                            ),
                            child: Image.asset(
                              'assets/logo/app_logo.png',
                              width: logoWidth,
                              height: logoWidth,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        SizedBox(height: size.height * 0.045),

                        Text(
                          'Weatherly',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.displaySmall?.copyWith(
                            fontSize: titleSize,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5,
                            color: colorScheme.onSurface,
                          ),
                        ),

                        SizedBox(height: size.height * 0.012),

                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: 600,
                          ),
                          child: Text(
                            'Your weather, anywhere in the world.',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontSize: isTablet ? 19 : 16,
                              height: 1.5,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),

                        SizedBox(height: size.height * 0.045),

                        SizedBox(
                          width: isTablet ? 180 : 140,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: LinearProgressIndicator(
                              minHeight: isTablet ? 5 : 4,
                              backgroundColor:
                              colorScheme.surfaceContainerHighest,
                            ),
                          ),
                        ),

                        SizedBox(height: size.height * 0.018),

                        Text(
                          'Checking the latest weather...',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontSize: isTablet ? 14 : 12,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),

                        const Spacer(),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.public_rounded,
                              size: isTablet ? 20 : 18,
                              color: colorScheme.primary,
                            ),
                            const SizedBox(width: 7),
                            Text(
                              'Weather for every city',
                              style: theme.textTheme.labelMedium?.copyWith(
                                fontSize: isTablet ? 14 : 12,
                                color: colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}