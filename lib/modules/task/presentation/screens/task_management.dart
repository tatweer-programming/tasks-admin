import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:tasks_admin/core/utils/color_manager.dart';
import 'package:tasks_admin/modules/task/data/model/task.dart';
import 'package:tasks_admin/modules/task/presentation/cubit/task_cubit.dart';
import 'package:tasks_admin/modules/task/presentation/task_management_appbar.dart';

class TaskManagementScreen extends StatefulWidget {
  const TaskManagementScreen({super.key});

  @override
  State<TaskManagementScreen> createState() => _TaskManagementScreenState();
}

class _TaskManagementScreenState extends State<TaskManagementScreen> {
  TaskStatus filterSelected = TaskStatus.all;
  late TaskCubit taskCubit;

  @override
  void initState() {
    taskCubit = context.read<TaskCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TaskManagementAppBar(),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: ColorManager.white,
                ),
                hintText: 'Search tasks...',
                hintStyle: TextStyle(
                  color: ColorManager.white,
                ),
                fillColor: ColorManager.grey.withValues(alpha: 0.2),
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none),
              ),
            ),
            SizedBox(height: 2.h),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterButton(TaskStatus.all),
                  _buildFilterButton(TaskStatus.pending),
                  _buildFilterButton(TaskStatus.approved),
                  _buildFilterButton(TaskStatus.inProgress),
                  _buildFilterButton(TaskStatus.cancelled),
                  _buildFilterButton(TaskStatus.completed),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  _buildTaskCard(
                    'Update Website Content',
                    'Sarah Wilson',
                    'Dec 15, 2023',
                    TaskStatus.cancelled,
                  ),
                  _buildTaskCard(
                    'Design New Landing Page',
                    'Michael Chen',
                    'Dec 16, 2023',
                    TaskStatus.inProgress,
                  ),
                  _buildTaskCard(
                    'Review Marketing Strategy',
                    'Emily Davis',
                    null, // No date in the screenshot
                    TaskStatus.approved,
                  ),
                  _buildTaskCard(
                    'Review Marketing Strategy',
                    'Emily Davis',
                    null, // No date in the screenshot
                    TaskStatus.pending,
                  ),
                  _buildTaskCard(
                    'Review Marketing Strategy',
                    'Emily Davis',
                    null, // No date in the screenshot
                    TaskStatus.completed,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(TaskStatus text) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        if (state is FilterTaskByStatus) {
          filterSelected = state.status;
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: ElevatedButton(
            onPressed: () {
              taskCubit.filterTasksByStatus(filterSelected);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: filterSelected.name == text.name
                  ? ColorManager.orange
                  : ColorManager.grey.withValues(alpha: 0.2),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              text.name,
              style: TextStyle(
                color: ColorManager.white,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTaskCard(
      String title, String assignedTo, String? date, TaskStatus status) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.symmetric(vertical: 1.5.h),
      child: Padding(
        padding:
            EdgeInsetsDirectional.symmetric(horizontal: 4.w, vertical: 1.5.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 3.w, vertical: .7.h),
                  decoration: BoxDecoration(
                    color: _getStatusColor(status),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    status.name,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 1.h),
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage:
                      NetworkImage('https://via.placeholder.com/150'),
                ),
                SizedBox(width: 2.w),
                Text(
                  assignedTo,
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (date != null) ...[
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16),
                      SizedBox(width: 2.w),
                      Text(date),
                    ],
                  ),
                ],
                Spacer(),
                _deleteEditTask(false),
                SizedBox(width: 2.w),
                _deleteEditTask(true),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _deleteEditTask(bool isDeleteButton) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: isDeleteButton ? ColorManager.red : ColorManager.orange,
        borderRadius: BorderRadius.circular(15),
      ),
      child: IconButton(
        icon: Icon(
          isDeleteButton ? Icons.delete : Icons.edit,
          color: ColorManager.white,
          size: 20,
        ),
        onPressed: () {},
      ),
    );
  }

  Color _getStatusColor(TaskStatus status) {
    switch (status) {
      case TaskStatus.pending:
        return ColorManager.yellow;
      case TaskStatus.approved:
        return ColorManager.green;
      case TaskStatus.inProgress:
        return ColorManager.blue;
      case TaskStatus.cancelled:
        return ColorManager.red;
      case TaskStatus.completed:
        return ColorManager.grey;
      default:
        return Colors.transparent;
    }
  }
}
