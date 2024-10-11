import 'package:animations/animations.dart';
import 'package:fluid_dialog/fluid_dialog.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Données statiques pour la démonstration
    final String title = 'Fluid Dialog Demo';
    final String version = 'Version 1.0.0';
    final String message = 'This is a static message for the About page.';

    return SizedBox(
      // width: 800,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // IconButton(
                //   onPressed: () => DialogNavigator.of(context).pop(),
                //   icon: const Icon(Icons.arrow_back),
                //   color: Theme.of(context).colorScheme.onSurface,
                // ),
                IconButton(
                  // Close the dialog completely.
                  onPressed: () => DialogNavigator.of(context).close(),
                  icon: const Icon(Icons.close),
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ],
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              version,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(message),
          ],
        ),
      ),
    );
  }
}
