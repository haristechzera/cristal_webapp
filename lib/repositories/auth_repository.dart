

import 'package:cristal_webapp/config/utils/typedef.dart';


import 'package:cristal_webapp/entity/getschool_entity.dart';
import 'package:cristal_webapp/params/schoolCodeRequest.dart';

abstract class AuthRepository {

  ResultFuture<FetchSchoolEntity> fetchSchools(FetchSchoolRequest request);

}
