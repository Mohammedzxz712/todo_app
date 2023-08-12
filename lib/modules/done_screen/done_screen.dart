import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:todo_app/core/custom_divider.dart';
import 'package:todo_app/layout/cubit/cubit/cubit.dart';
import 'package:todo_app/layout/cubit/states/states.dart';

class DoneScreen extends StatelessWidget {
  const DoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List<dynamic> tasks = AppCubit.get(context).doneTasks;
        return ListView.separated(
          separatorBuilder: (context, index) => const CustomDivide(),
          itemCount: tasks.length,
          itemBuilder: (context, index) => SafeArea(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: Colors.purpleAccent,
                          ),
                          color: Colors.purple[50],
                        ),
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${tasks[index]['taskName']}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                '${tasks[index]['date']}',
                                style: const TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                '${tasks[index]['startTime']}',
                                style: const TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                '${tasks[index]['endTime']}',
                                style: const TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                '${tasks[index]['description']}',
                                style: const TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  MaterialButton(
                                    child: const Icon(
                                      Icons.check_box,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {
                                      AppCubit.get(context).updateData(
                                          status: 'done',
                                          id: tasks[index]['id']);
                                    },
                                  ),
                                  MaterialButton(
                                    child: const Icon(Iconsax.archive,
                                        color: Colors.grey),
                                    onPressed: () {
                                      AppCubit.get(context).updateData(
                                          status: 'archive',
                                          id: tasks[index]['id']);
                                    },
                                  ),
                                  MaterialButton(
                                    child: const Icon(Icons.delete,
                                        color: Colors.grey),
                                    onPressed: () {
                                      AppCubit.get(context).updateData(
                                          status: 'delete',
                                          id: tasks[index]['id']);
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        )),
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
