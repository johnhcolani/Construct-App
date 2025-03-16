import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/color_manager.dart';
import '../bloc/project_bloc.dart';
import '../bloc/project_event.dart';
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

  final TextEditingController nameController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();

  void _showCreateProjectDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Create New Project'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Project Name'),
              ),
              TextField(
                controller: imageUrlController,
                decoration: InputDecoration(labelText: 'Image URL'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (nameController.text.isNotEmpty && imageUrlController.text.isNotEmpty) {
                  context.read<ProjectBloc>().add(
                    CreateProject(
                      name: nameController.text,
                      imageUrl: imageUrlController.text,
                    ),
                  );
                  nameController.clear();
                  imageUrlController.clear();
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please fill in all fields'),
                      backgroundColor: ColorManager.errorRed,
                    ),
                  );
                }
              },
              child: Text('Create'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundLight,
      body: BlocBuilder<ProjectBloc, ProjectState>(
        builder: (context, state) {
          if (state is ProjectLoading) {
            return Center(child: CircularProgressIndicator(color: ColorManager.primaryBlue));
          } else if (state is ProjectLoaded) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  // List of projects
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.projects.length,
                    itemBuilder: (context, index) {
                      final project = state.projects[index];
                      return Card(
                        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                project.name,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: ColorManager.textPrimary,
                                ),
                              ),
                            ),
                            // Menu items for this project
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: menuItems.length,
                              itemBuilder: (context, menuIndex) {
                                return ListTile(
                                  leading: Icon(
                                    menuItems[menuIndex]['icon'],
                                    color: ColorManager.neutralDark,
                                  ),
                                  title: Text(
                                    menuItems[menuIndex]['title'],
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
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () => _showCreateProjectDialog(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.primaryBlue,
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: Text(
                        'Add New Project',
                        style: TextStyle(
                          fontSize: 18,
                          color: ColorManager.textWhite,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.errorRed,
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: Text(
                        'Sign Out',
                        style: TextStyle(
                          fontSize: 18,
                          color: ColorManager.textWhite,
                        ),
                      ),
                    ),
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