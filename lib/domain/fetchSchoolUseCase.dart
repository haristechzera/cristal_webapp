import 'package:cristal_webapp/config/general_usecases.dart';
import 'package:cristal_webapp/config/utils/typedef.dart';
import 'package:cristal_webapp/entity/getschool_entity.dart';
import 'package:cristal_webapp/params/schoolCodeRequest.dart';
import 'package:cristal_webapp/repositories/auth_repository.dart';

class FetchSchoolUseCase
    implements UseCaseWithParams<FetchSchoolEntity, FetchSchoolRequest> {
  final AuthRepository _authRepository;

  FetchSchoolUseCase(this._authRepository);

  @override
  ResultFuture<FetchSchoolEntity> call(FetchSchoolRequest request) async {
    return _authRepository.fetchSchools(request);
  }
}