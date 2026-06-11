import 'package:cristal_webapp/config/utils/typedef.dart';
import 'package:cristal_webapp/data/datasources/auth_remote_data_source.dart';
import 'package:cristal_webapp/entity/getschool_entity.dart';
import 'package:cristal_webapp/params/schoolCodeRequest.dart';
import 'package:cristal_webapp/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../config/errors/exceptions.dart';
import '../../config/errors/failure.dart';



class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});



  @override
  ResultFuture<FetchSchoolEntity> fetchSchools(
      FetchSchoolRequest request,
      ) async {
    try {
      final result = await remoteDataSource.fetchSchools(request);

      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    } on DioException catch (failure) {
      return Left(ServerFailure(failure.message.toString()));
    }
  }


}
