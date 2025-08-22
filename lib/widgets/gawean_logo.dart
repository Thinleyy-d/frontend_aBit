import 'package:flutter/material.dart';

class GaweanLogo extends StatelessWidget {
  final double iconSize;
  final double fontSize;
  final String? tagline;

  const GaweanLogo({
    super.key,
    this.iconSize = 64.0,
    this.fontSize = 28.0,
    this.tagline,
    
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: iconSize,
          height: iconSize,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(iconSize * 0.25),
          ),
          child: Center(
            child: Image.asset(
              'assets/gawean_icon.png',
              width: iconSize * 0.6,
              height: iconSize * 0.6,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Gawean',
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        if (tagline != null) ...[
          const SizedBox(height: 8),
          Text(
            tagline!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ],
      ],
    );
  }
}