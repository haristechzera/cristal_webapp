

import 'package:cristal_webapp/data/datasources/auth_remote_data_source.dart';
import 'package:cristal_webapp/data/repositories/auth_repository_impl.dart';
import 'package:cristal_webapp/domain/fetchSchoolUseCase.dart';
import 'package:cristal_webapp/registrationCubit/register_cubit.dart';
import 'package:cristal_webapp/repositories/auth_repository.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class ServiceLocator {
  static Future<void> init() async {
    // ------------------- AUTH -------------------
    //  Cubit
    sl.registerFactory(
      () => RegisterCubit(
        fetchSchoolUseCase: sl(),

      ),
    );
    // usecase

    sl.registerLazySingleton(() => FetchSchoolUseCase(sl()));


    // Data Source
    sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(),
    );

    // repository
    sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteDataSource: sl()),
    );

  }
}
