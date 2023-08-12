import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/core/custom_navigator.dart';
import 'package:todo_app/generated/assets.dart';
import 'package:todo_app/shared/constant/colors.dart';

import '../../core/custom_button.dart';
import '../../layout/app_layout.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Image.asset(Assets.welcomeStudyingAmico),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Welcome to Go task',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'A workspace to over 10 million influences \n around the global of the world.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.caption,
            ),
            const Spacer(),
            CustomButton(
              text: 'let\'s start',
              style: GoogleFonts.aBeeZee(
                color: Colors.white,
              ),
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 18,
              ),
              onPressed: () {
                CustomNavigation.navigatorTo(context, AppLayout());
              },
              decoration: BoxDecoration(
                color: const Color(
                  Style.kPrimaryColor,
                ),
                borderRadius: BorderRadius.circular(
                  15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
