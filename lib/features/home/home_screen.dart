import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController cityController = TextEditingController();

  void searchWeather() {
    String city = cityController.text.trim();

    if (city.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a city name first'),
        ),
      );
      return;
    }

    context.read<WeatherProvider>().searchWeather(city);

    FocusScope.of(context).unfocus();
  }

  @override
  void dispose() {
    cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(
              Icons.cloud_rounded,
              color: colors.primary,
            ),
            const SizedBox(width: 10),
            const Text(
              'Weatherly',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Consumer<WeatherProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(
              width < 600 ? 20 : 40,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Check the Weather',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  'Search for any city around the world.',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),

                const SizedBox(height: 25),

                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: colors.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: colors.outlineVariant,
                    ),
                  ),
                  child: TextField(
                    controller: cityController,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (_) {
                      searchWeather();
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter city name',
                      prefixIcon: Icon(
                        Icons.location_on_outlined,
                        color: colors.primary,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          cityController.clear();
                        },
                        icon: const Icon(
                          Icons.clear,
                        ),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: FilledButton.icon(
                    onPressed: provider.isLoading
                        ? null
                        : searchWeather,
                    icon: provider.isLoading
                        ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                        : const Icon(
                      Icons.search_rounded,
                    ),
                    label: Text(
                      provider.isLoading
                          ? 'Searching...'
                          : 'Search Weather',
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                if (provider.isLoading)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: colors.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      children: [
                        CircularProgressIndicator(
                          color: colors.primary,
                        ),
                        const SizedBox(height: 18),
                        Text(
                          'Getting weather...',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Please wait while we fetch the latest data.',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  )
                else if (provider.errorMessage.isNotEmpty)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: colors.errorContainer,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.cloud_off_rounded,
                          size: 55,
                          color: colors.error,
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Weather not available',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          provider.errorMessage,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 15),
                        OutlinedButton.icon(
                          onPressed: searchWeather,
                          icon: const Icon(Icons.refresh),
                          label: const Text('Try Again'),
                        ),
                      ],
                    ),
                  )
                else if (provider.weather == null)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: colors.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.search_rounded,
                            size: 60,
                            color: colors.primary,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Search for a city first',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Enter a city name above to see its current weather.',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Card(
                      elevation: 4,
                      color: colors.surfaceContainerHighest,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_rounded,
                                  color: colors.primary,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    provider.weather!.city,
                                    style: theme.textTheme.headlineSmall
                                        ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 4),

                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 32),
                                child: Text(
                                  provider.weather!.country,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: colors.onSurfaceVariant,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 25),

                            Text(
                              provider.weather!.icon,
                              style: const TextStyle(
                                fontSize: 75,
                              ),
                            ),

                            const SizedBox(height: 10),

                            Text(
                              '${provider.weather!.temperature.toStringAsFixed(1)}°C',
                              style: theme.textTheme.displayMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              provider.weather!.condition,
                              style: theme.textTheme.titleLarge?.copyWith(
                                color: colors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            const SizedBox(height: 25),

                            Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: colors.surface,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.location_searching,
                                          color: colors.primary,
                                        ),
                                        const SizedBox(height: 6),
                                        const Text('Latitude'),
                                        const SizedBox(height: 3),
                                        Text(
                                          provider.weather!.latitude
                                              .toStringAsFixed(2),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Container(
                                    height: 45,
                                    width: 1,
                                    color: colors.outlineVariant,
                                  ),

                                  Expanded(
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.explore_outlined,
                                          color: colors.primary,
                                        ),
                                        const SizedBox(height: 6),
                                        const Text('Longitude'),
                                        const SizedBox(height: 3),
                                        Text(
                                          provider.weather!.longitude
                                              .toStringAsFixed(2),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 20),

                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: OutlinedButton.icon(
                                onPressed: searchWeather,
                                icon: const Icon(
                                  Icons.refresh_rounded,
                                ),
                                label: const Text(
                                  'Refresh Weather',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
              ],
            ),
          );
        },
      ),
    );
  }
}