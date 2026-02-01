import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/presentation/choose_mode/bloc/theme_cubit.dart';

class ModeButton extends StatelessWidget {
  final String icon;
  final String label;
  const ModeButton({
    super.key, 
    required this.icon,
    required this.label,
    }
  );
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: icon != 'dark' ? (){
        context.read<ThemeCubit>().updateTheme(ThemeMode.light);
      } : (){
        context.read<ThemeCubit>().updateTheme( ThemeMode.dark);
      },
      child: Column(
        children: [
          Container(
            width: 73,
            height: 73,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.1),
            ),
            child: Icon(
              icon == 'dark' ? Icons.dark_mode : Icons.light_mode,
              color: Colors.white,
              size: 42,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500
            ),
          )
        ],
      ),
    );
  }
}