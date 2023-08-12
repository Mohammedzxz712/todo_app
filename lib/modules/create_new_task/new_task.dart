import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/custom_button.dart';
import 'package:todo_app/layout/app_layout.dart';
import 'package:todo_app/layout/cubit/cubit/cubit.dart';
import 'package:todo_app/layout/cubit/states/states.dart';
import '../../shared/constant/colors.dart';

class CreateNewTask extends StatelessWidget {
  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a value';
    }
    return null;
  }

  var dateController = TextEditingController();
  var startTimeController = TextEditingController();
  var endTimeController = TextEditingController();
  var taskNameController = TextEditingController();
  var descriptionController = TextEditingController();

  CreateNewTask({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text(
                'Create New Tasks',
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Task name',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      label: 'Ui Design',
                      prefixIcon: Iconsax.designtools,
                      controller: taskNameController,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Date & Time',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      type: TextInputType.datetime,
                      label: 'Date',
                      prefixIcon: Iconsax.calendar,
                      onTap: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2026))
                            .then((value) {
                          dateController.text =
                              DateFormat().add_yMMMd().format(value!);
                        });
                      },
                      isPassword: false,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      controller: dateController,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      height: 120,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Star Time',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: 140,
                                child: CustomTextFormField(
                                  type: TextInputType.datetime,
                                  label: 'Start',
                                  onTap: () {
                                    showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now())
                                        .then((value) {
                                      startTimeController.text =
                                          value!.format(context).toString();
                                    });
                                  },
                                  prefixIcon: Iconsax.clock,
                                  isPassword: false,
                                  controller: startTimeController,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'End Time',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: 140,
                                child: CustomTextFormField(
                                  type: TextInputType.datetime,
                                  label: 'End',
                                  onTap: () {
                                    showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now())
                                        .then((value) {
                                      endTimeController.text =
                                          value!.format(context).toString();
                                    });
                                  },
                                  prefixIcon: Iconsax.clock,
                                  isPassword: false,
                                  controller: endTimeController,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Text(
                      'Description',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomTextFormField(
                      label: 'Description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      controller: descriptionController,
                    ),
                    CustomButton(
                      text: 'Create Task',
                      style: GoogleFonts.aBeeZee(
                        color: Colors.white,
                      ),
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 18,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(
                          Style.kPrimaryColor,
                        ),
                        borderRadius: BorderRadius.circular(
                          15,
                        ),
                      ),
                      onPressed: () {
                        AppCubit.get(context).insertDatabase(
                          taskName: taskNameController.text,
                          date: dateController.text,
                          startTime: startTimeController.text,
                          endTime: endTimeController.text,
                          description: descriptionController.text,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
