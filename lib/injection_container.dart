import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'features/authentication/data/datasources/auth_remote_datasource.dart';
import 'features/authentication/data/repositories/auth_repository_impl.dart';
import 'features/authentication/domain/repositories/auth_repository.dart';
import 'features/authentication/domain/usecases/login_usecase.dart';
import 'features/authentication/presentation/bloc/auth_bloc.dart';
import 'features/project/data/datasources/project_remote_datasource.dart';
import 'features/project/data/repositories/project_repository_impl.dart';
import 'features/project/domain/repositories/project_repository.dart';
import 'features/project/domain/usecases/get_projects_usecase.dart';
import 'features/project/presentation/bloc/project_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BLoC
  sl.registerFactory(() => AuthBloc(sl()));
  sl.registerFactory(() => ProjectBloc(sl()));

  // Use Cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => GetProjectsUseCase(sl()));

  // Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<ProjectRepository>(() => ProjectRepositoryImpl(sl()));

  // Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<ProjectRemoteDataSource>(() => ProjectRemoteDataSourceImpl(sl()));

  // External
  sl.registerLazySingleton(() => http.Client());
}