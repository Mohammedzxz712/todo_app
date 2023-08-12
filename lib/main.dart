import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/core/bloc_observer.dart';
import 'package:todo_app/layout/cubit/cubit/cubit.dart';
import 'package:todo_app/shared/constant/colors.dart';

import 'modules/welcome_screen/welcome_screen.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()..createDatabase(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: Color(Style.kPrimaryColor)),
            appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
                color: Colors.white,
              ),
              backgroundColor: Color(Style.kPrimaryColor),
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                selectedItemColor: Color(Style.kPrimaryColor)),
            textTheme: TextTheme(
              bodyMedium: GoogleFonts.aBeeZee(
                color: Colors.black,
              ),
            )),
        home: WelcomeScreen(),
      ),
    );
  }
}
