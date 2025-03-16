import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:construct_app/features/project/domain/entities/project.dart';
import 'project_event.dart';
import 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  ProjectBloc(this._firestore, this._auth) : super(ProjectInitial()) {
    on<LoadProjects>(_onLoadProjects);
    on<CreateProject>(_onCreateProject);
  }

  Future<void> _onLoadProjects(LoadProjects event, Emitter<ProjectState> emit) async {
    print('Starting to load projects...');
    emit(ProjectLoading());
    try {
      final user = _auth.currentUser;
      print('Current user: ${user?.uid}');
      if (user == null) {
        print('No user logged in');
        emit(ProjectError('No user logged in'));
        return;
      }

      print('Fetching projects from Firestore for user: ${user.uid}');
      final snapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('projects')
          .get();
      print('Fetched ${snapshot.docs.length} projects');

      List<Project> projects = snapshot.docs.map((doc) {
        print('Mapping project: ${doc.id}');
        return Project.fromFirestore(doc.data(), doc.id);
      }).toList();

      if (projects.isEmpty) {
        print('No projects found, adding sample project');
        await _firestore
            .collection('users')
            .doc(user.uid)
            .collection('projects')
            .add({
          'name': 'Sample Project',
          'imageUrl': 'https://via.placeholder.com/150',
        });
        print('Sample project added');
        final newSnapshot = await _firestore
            .collection('users')
            .doc(user.uid)
            .collection('projects')
            .get();
        print('Fetched ${newSnapshot.docs.length} projects after adding sample');
        projects = newSnapshot.docs.map((doc) {
          print('Mapping new project: ${doc.id}');
          return Project.fromFirestore(doc.data(), doc.id);
        }).toList();
      }

      print('Emitting ProjectLoaded with ${projects.length} projects');
      emit(ProjectLoaded(projects));
    } catch (e) {
      print('Error loading projects: $e');
      emit(ProjectError(e.toString()));
    }
  }

  Future<void> _onCreateProject(CreateProject event, Emitter<ProjectState> emit) async {
    emit(ProjectLoading());
    try {
      final user = _auth.currentUser;
      if (user == null) {
        emit(ProjectError('No user logged in'));
        return;
      }

      print('Creating new project: ${event.name}');
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('projects')
          .add({
        'name': event.name,
        'imageUrl': event.imageUrl,
      });

      // Reload projects after adding a new one
      final snapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('projects')
          .get();

      List<Project> projects = snapshot.docs.map((doc) {
        return Project.fromFirestore(doc.data(), doc.id);
      }).toList();

      emit(ProjectLoaded(projects));
    } catch (e) {
      emit(ProjectError('Failed to create project: $e'));
    }
  }
}