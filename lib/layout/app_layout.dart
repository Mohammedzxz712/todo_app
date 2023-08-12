import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/custom_navigator.dart';
import '../modules/create_new_task/new_task.dart';
import 'cubit/cubit/cubit.dart';
import 'cubit/states/states.dart';

class CustomTextFormField extends StatelessWidget {
  final TextInputType? type;
  final String label;
  String? hint;
  int? length;
  final IconData? prefixIcon;
  final bool isPassword;
  final OutlineInputBorder border;
  final TextEditingController? controller;
  final void Function()? onTap;
  CustomTextFormField({
    Key? key,
    this.type,
    required this.label,
    this.hint,
    this.prefixIcon,
    this.isPassword = false,
    required this.border,
    this.controller,
    this.onTap,
  }) : super(key: key);
  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a value';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: type,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefixIcon),
        border: border,
        hintText: hint,
      ),
      obscureText: isPassword,
      controller: controller,
      maxLines: length,
      onTap: onTap,
    );
  }
}

class AppLayout extends StatefulWidget {
  const AppLayout({super.key});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var scaffoldKey = GlobalKey<ScaffoldState>();
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          key: scaffoldKey,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          body: cubit.screens[cubit.currentIndex],
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              CustomNavigation.navigatorTo(context, CreateNewTask());
              // if (cubit.changeFloatingButton == true) {
              //   Navigator.pop(context);
              //   cubit.changeFloatingButton = false;
              //   cubit.changeFab = Iconsax.edit;
              //   // cubit.changeFabIcon(
              //   //   icon: Iconsax.edit,
              //   //   isShow: false,
              //   // );
              // } else {
              //   scaffoldKey.currentState?.showBottomSheet(
              //     (context) => Container(
              //       height: MediaQuery.of(context).size.height / 1.5,
              //       child: Column(
              //         mainAxisSize: MainAxisSize.min,
              //         children: [
              //           CustomTextFormField(
              //             type: TextInputType.text,
              //             label: 'Text',
              //             prefixIcon: Iconsax.text,
              //             isPassword: false,
              //             border: OutlineInputBorder(),
              //             controller: textController,
              //           ),
              //           const SizedBox(
              //             height: 15,
              //           ),
              //           CustomTextFormField(
              //             type: TextInputType.datetime,
              //             label: 'Time',
              //             onTap: () {
              //               showTimePicker(
              //                       context: context,
              //                       initialTime: TimeOfDay.now())
              //                   .then((value) {
              //                 timeController.text =
              //                     value!.format(context).toString();
              //               });
              //             },
              //             prefixIcon: Iconsax.watch,
              //             isPassword: false,
              //             border: const OutlineInputBorder(),
              //             controller: timeController,
              //           ),
              //           const SizedBox(
              //             height: 15,
              //           ),
              //           CustomTextFormField(
              //             type: TextInputType.datetime,
              //             label: 'Date',
              //             prefixIcon: Iconsax.calendar,
              //             onTap: () {
              //               showDatePicker(
              //                       context: context,
              //                       initialDate: DateTime.now(),
              //                       firstDate: DateTime.now(),
              //                       lastDate: DateTime(2026))
              //                   .then((value) {
              //                 dateController.text =
              //                     DateFormat().add_yMMMd().format(value!);
              //               });
              //             },
              //             isPassword: false,
              //             border: const OutlineInputBorder(),
              //             controller: dateController,
              //           ),
              //         ],
              //       ),
              //     ),
              //   );
              //   // cubit.changeFabIcon(icon: Iconsax.close_circle, isShow: true);
              //   cubit.changeFloatingButton = true;
              //   cubit.changeFab = Iconsax.close_circle;
              // }
            },
            child: Icon(cubit.changeFab),
          ),
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            currentIndex: cubit.currentIndex,
            items: cubit.items,
          ),
        );
      },
    );
  }
}
