import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_projects_usecase.dart';
import 'project_event.dart';
import 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final GetProjectsUseCase getProjectsUseCase;

  ProjectBloc(this.getProjectsUseCase) : super(ProjectInitial()) {
    on<FetchProjects>((event, emit) async {
      emit(ProjectLoading());
      final result = await getProjectsUseCase(NoParams());
      result.fold(
            (failure) => emit(ProjectError(failure.message)),
            (projects) => emit(ProjectLoaded(projects)),
      );
    });
  }
}