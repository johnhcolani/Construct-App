import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/color_manager.dart';
import '../bloc/project_bloc.dart';
import '../bloc/project_state.dart';

class ProjectDashboardPage extends StatelessWidget {
  final List<Map<String, dynamic>> menuItems = [
    {'icon': Icons.info_outline, 'title': 'Overview'},
    {'icon': Icons.attach_money, 'title': 'Financials'},
    {'icon': Icons.description, 'title': 'Specs & Selections'},
    {'icon': Icons.edit, 'title': 'Change Orders'},
    {'icon': Icons.file_copy, 'title': 'Files'},
    {'icon': Icons.photo, 'title': 'Photos'},
    {'icon': Icons.check_circle, 'title': 'To-Dos'},
    {'icon': Icons.message, 'title': 'Communication'},
    {'icon': Icons.help_outline, 'title': 'Questions'},
    {'icon': Icons.work, 'title': 'Job Log'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundLight, // Light background
      body: BlocBuilder<ProjectBloc, ProjectState>(
        builder: (context, state) {
          if (state is ProjectLoading) {
            return Center(child: CircularProgressIndicator(color: ColorManager.primaryBlue));
          } else if (state is ProjectLoaded) {
            final project = state.projects.first; // Assuming first project
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Image.network(
                          project.imageUrl,
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 150,
                              width: double.infinity,
                              color: ColorManager.neutralLight,
                              child: Icon(
                                Icons.broken_image,
                                color: ColorManager.neutralDark,
                                size: 50,
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 10),
                        Text(
                          project.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: ColorManager.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: menuItems.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(
                          menuItems[index]['icon'],
                          color: ColorManager.neutralDark,
                        ),
                        title: Text(
                          menuItems[index]['title'],
                          style: TextStyle(color: ColorManager.textPrimary),
                        ),
                        onTap: () {
                          // Navigate to respective page
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          } else if (state is ProjectError) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(color: ColorManager.errorRed),
              ),
            );
          }
          return Center(
            child: Text(
              'Press to load projects',
              style: TextStyle(color: ColorManager.textSecondary),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: ColorManager.primaryBlue,
        unselectedItemColor: ColorManager.neutralDark,
        backgroundColor: ColorManager.backgroundWhite,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Projects'),
          BottomNavigationBarItem(icon: Icon(Icons.inbox), label: 'Inbox'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}