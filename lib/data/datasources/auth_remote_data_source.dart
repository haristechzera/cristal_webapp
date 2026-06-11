import 'package:cristal_webapp/config/errors/error_message_model.dart';
import 'package:cristal_webapp/config/errors/exceptions.dart';
import 'package:cristal_webapp/data/models/getschool_model.dart';
import 'package:cristal_webapp/entity/getschool_entity.dart';
import 'package:cristal_webapp/params/schoolCodeRequest.dart';
import 'package:dio/dio.dart';


abstract class AuthRemoteDataSource {

  Future<FetchSchoolEntity> fetchSchools(FetchSchoolRequest request);

}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  Dio dio = Dio();


  @override
  Future<FetchSchoolEntity> fetchSchools(FetchSchoolRequest request) async {
    try {

      final url = "https://online.cristaledu.com/Api/public/api/get-school";
      print('🔹 Fetch School URL: $url');
      print('🔹 Request Body: ${request.toJson()}');

      final response = await dio.post(
        url,
        data: request.toJson(),
        options: Options(
          contentType: "application/json",
          headers: {"Accept": "application/json"},
        ),
      );

      print('🔹 Status Code: ${response.statusCode}');
      print('🔹 Response Data: ${response.data}');

      if (response.statusCode == 200) {
        return FetchSchoolResponseModel.fromJson(response.data);
      } else {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
      }
    } catch (e, stacktrace) {
      print('❌ Exception during fetchSchools: $e');
      print('Stacktrace: $stacktrace');
      rethrow;
    }
  }

}
