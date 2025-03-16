import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/color_manager.dart';
import '../bloc/settings_bloc.dart';
import '../bloc/settings_event.dart';
import '../bloc/settings_state.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dispatch FetchUserProfileRequested when the page loads
    context.read<SettingsBloc>().add(FetchUserProfileRequested());

    return Scaffold(
      backgroundColor: ColorManager.backgroundWhite,
      body: BlocConsumer<SettingsBloc, SettingsState>(
        listener: (context, state) {
          if (state is SignOutSuccess) {
            Navigator.pushReplacementNamed(context, '/login');
          } else if (state is SettingsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                  style: TextStyle(color: ColorManager.textWhite),
                ),
                backgroundColor: ColorManager.errorRed,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is SettingsLoading) {
            return Center(child: CircularProgressIndicator(color: ColorManager.primaryBlue));
          } else if (state is SettingsLoaded) {
            final userProfile = state.userProfile;
            final initials = userProfile.name.isNotEmpty
                ? userProfile.name.split(' ').map((e) => e[0]).take(2).join()
                : userProfile.email.substring(0, 2).toUpperCase();

            return Column(
              children: [
                // User Profile Section
                Container(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: ColorManager.neutralLight,
                        child: Text(
                          initials,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: ColorManager.textPrimary,
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userProfile.name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: ColorManager.textPrimary,
                            ),
                          ),
                          Text(
                            userProfile.email,
                            style: TextStyle(
                              fontSize: 14,
                              color: ColorManager.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(color: ColorManager.neutralLight),
                // Settings Options
                Expanded(
                  child: ListView(
                    children: [
                      ListTile(
                        leading: Icon(Icons.notifications, color: ColorManager.neutralDark),
                        title: Text(
                          'Notifications',
                          style: TextStyle(color: ColorManager.textPrimary),
                        ),
                        onTap: () {
                          // Navigate to Notifications page (placeholder)
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.support_agent, color: ColorManager.neutralDark),
                        title: Text(
                          'Contact Support',
                          style: TextStyle(color: ColorManager.textPrimary),
                        ),
                        onTap: () {
                          // Navigate to Contact Support page (placeholder)
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.help_outline, color: ColorManager.neutralDark),
                        title: Text(
                          'Help Center',
                          style: TextStyle(color: ColorManager.textPrimary),
                        ),
                        onTap: () {
                          // Navigate to Help Center page (placeholder)
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.security, color: ColorManager.neutralDark),
                        title: Text(
                          'Privacy Policy',
                          style: TextStyle(color: ColorManager.textPrimary),
                        ),
                        onTap: () {
                          // Navigate to Privacy Policy page (placeholder)
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.description, color: ColorManager.neutralDark),
                        title: Text(
                          'Terms of Use',
                          style: TextStyle(color: ColorManager.textPrimary),
                        ),
                        onTap: () {
                          // Navigate to Terms of Use page (placeholder)
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.logout, color: ColorManager.neutralDark),
                        title: Text(
                          'Sign Out',
                          style: TextStyle(color: ColorManager.textPrimary),
                        ),
                        onTap: () {
                          context.read<SettingsBloc>().add(SignOutRequested());
                        },
                      ),
                    ],
                  ),
                ),
                // App Version
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'App Version 3.21.7',
                    style: TextStyle(
                      fontSize: 12,
                      color: ColorManager.textSecondary,
                    ),
                  ),
                ),
              ],
            );
          } else if (state is SettingsError) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(color: ColorManager.errorRed),
              ),
            );
          }
          return Center(
            child: Text(
              'Loading settings...',
              style: TextStyle(color: ColorManager.textSecondary),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: ColorManager.primaryBlue,
        unselectedItemColor: ColorManager.neutralDark,
        backgroundColor: ColorManager.backgroundWhite,
        currentIndex: 2, // Highlight Settings tab
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/dashboard');
          } else if (index == 1) {
            // Navigate to Inbox (placeholder)
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Projects'),
          BottomNavigationBarItem(icon: Icon(Icons.inbox), label: 'Inbox'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}