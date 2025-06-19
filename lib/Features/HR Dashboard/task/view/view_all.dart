import 'package:employee_management_system/core/app_exports.dart';

class ViewAllTasks extends StatefulWidget {
  const ViewAllTasks({super.key});

  @override
  State<ViewAllTasks> createState() => _ViewAllTasksState();
}

class _ViewAllTasksState extends State<ViewAllTasks> {
  final _taskController = Get.find<TaskController>();

  @override
  void initState() {
    super.initState();
    _taskController.searchController.addListener(() {
      _taskController.filterTasksByName();
    });
    _taskController.filteredTasks.assignAll(_taskController.taskList);
  }

  @override
  void dispose() {
    _taskController.searchController.removeListener(() {});
    _taskController.searchController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0.1.sh,
          backgroundColor: AppColors.primaryColor,
          title: Text(
            "Employee's Tasks",
            style: AppTextStyles.screenName,
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Obx(() {
            final groupedTasks = _taskController
                .getWeekdayWiseTasks(_taskController.filteredTasks);
            return SingleChildScrollView(
              child: Container(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Column(
                    children: [
                      CustomTextField(
                        prefix: FontAwesomeIcons.magnifyingGlass,
                        labelText: 'Search',
                        type: TextInputType.text,
                        controller: _taskController.searchController,
                        validator: (value) =>
                            AppValidators.validateName(value, 'Search'),
                      ),
                      _taskController.filteredTasks.isEmpty
                          ? Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Center(
                                child: Text(
                                  'No Tasks',
                                  style: AppTextStyles.bodyText,
                                ),
                              ),
                            )
                          : Container(
                              height: 0.7.sh,
                              child: ListView.builder(
                                itemCount: groupedTasks.keys.length,
                                itemBuilder: (context, index) {
                                  final day =
                                      groupedTasks.keys.elementAt(index);
                                  final tasksForDay = groupedTasks[day]!;

                                  if (tasksForDay.isEmpty) return SizedBox();

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 0.02.sh),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 16),
                                        child: Text('$day Task:',
                                            style: AppTextStyles.bodyText),
                                      ),
                                      ListView.builder(
                                        itemCount: tasksForDay.length,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, taskIndex) {
                                          final task = tasksForDay[taskIndex];
                                          return TaskCard(
                                            task: task,
                                            onTap: () {
                                              Get.to(() =>
                                                  UpdateTask(tasks: task));
                                            },
                                            onDelete: () {
                                              showCustomDialog(
                                                icon: FontAwesomeIcons
                                                    .solidCircleCheck,
                                                title: 'Confirm Delete',
                                                message:
                                                    'Do you want to Delete this Task?',
                                                buttonText: 'Delete',
                                                onPressed: () {
                                                  _taskController
                                                      .deleteTask(task.id!);
                                                },
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ));
  }
}
