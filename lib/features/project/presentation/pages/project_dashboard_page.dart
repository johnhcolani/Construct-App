import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

   ProjectDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProjectBloc, ProjectState>(
        builder: (context, state) {
          if (state is ProjectLoading) {
            return Center(child: CircularProgressIndicator());
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
                        ),
                        SizedBox(height: 10),
                        Text(
                          project.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
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
                        leading: Icon(menuItems[index]['icon']),
                        title: Text(menuItems[index]['title']),
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
            return Center(child: Text(state.message));
          }
          return Center(child: Text('Press to load projects'));
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Projects'),
          BottomNavigationBarItem(icon: Icon(Icons.inbox), label: 'Inbox'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}