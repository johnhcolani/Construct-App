import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'features/authentication/data/datasources/auth_remote_datasource.dart';
import 'features/authentication/data/datasources/forgot_password_remote_datasource.dart';
import 'features/authentication/data/repositories/auth_repository_impl.dart';
import 'features/authentication/data/repositories/forgot_password_repository_impl.dart';
import 'features/authentication/domain/repositories/auth_repository.dart';
import 'features/authentication/domain/repositories/forgot_password_repository.dart';
import 'features/authentication/domain/usecases/login_usecase.dart';
import 'features/authentication/domain/usecases/reset_password.dart';
import 'features/authentication/presentation/bloc/auth_bloc.dart';
import 'features/authentication/presentation/bloc/forgot_password_bloc.dart';
import 'features/project/presentation/bloc/project_bloc.dart';
import 'features/setting/data/datasources/settings_remote_datasource.dart';
import 'features/setting/data/repositories/settings_repository_impl.dart';
import 'features/setting/domain/repositories/settings_repository.dart';
import 'features/setting/domain/usecases/fetch_user_profile.dart';
import 'features/setting/domain/usecases/sign_out.dart';
import 'features/setting/presentation/bloc/settings_bloc.dart';
import 'features/splash/presentation/bloc/splash_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// External
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);

  /// Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<ForgotPasswordRemoteDataSource>(
        () => ForgotPasswordRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<SettingsRemoteDataSource>(
        () => SettingsRemoteDataSourceImpl(sl()),
  );

  /// Repositories
  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<ForgotPasswordRepository>(
        () => ForgotPasswordRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<SettingsRepository>(
        () => SettingsRepositoryImpl(sl()),
  );

  /// Use Cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => ResetPassword(sl()));
  sl.registerLazySingleton(() => FetchUserProfile(sl()));
  sl.registerLazySingleton(() => SignOut(sl()));


  /// Blocs
  sl.registerFactory(() => AuthBloc(sl()));
  sl.registerFactory(() => ForgotPasswordBloc(sl()));
  sl.registerFactory(() => ProjectBloc(sl(), sl()));
  sl.registerFactory(() => SplashBloc(sl()));
  sl.registerFactory(() => SettingsBloc(sl(), sl()));

}