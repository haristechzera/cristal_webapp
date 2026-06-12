
import 'package:cristal_webapp/config/shared_preference_helper.dart';
import 'package:cristal_webapp/domain/fetchSchoolUseCase.dart';
import 'package:cristal_webapp/entity/getschool_entity.dart';
import 'package:cristal_webapp/params/schoolCodeRequest.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';




class RegisterCubit extends Cubit<RegisterState> {

  final FetchSchoolUseCase _fetchSchoolUseCase;

  RegisterCubit({
    required FetchSchoolUseCase fetchSchoolUseCase,

  }) :
        _fetchSchoolUseCase = fetchSchoolUseCase,

        super(FetchSchoolLoading());



  Future<void> fetchSchools(FetchSchoolRequest request) async {
    print('FetchSchoolRequest: ${request.toJson()}');

    emit(FetchSchoolLoading());

    try {
      final result = await _fetchSchoolUseCase(request);

      result.fold(
            (failure) {
          print('❌ FetchSchool failure: ${failure.message}');
          emit(FetchSchoolFailure(failure.message));
        },
            (response) async {

          if(response.status==200 || response.status==201) {

            final pref = SharedPreferenceHelper();
            await pref.setAppStoreVersion(
                response.schoolDetails!.first.appStoreVersion!);
            await pref.setPlayStoreVersion(
                response.schoolDetails!.first.playStoreVersion!);
            //AppData.schoolName=response.schoolDetails!.first.schoolName!;
            emit(FetchSchoolSuccess(response));
          }
          else {

            emit(FetchSchoolSuccess(response));
          }
        },
      );
    } catch (e, stacktrace) {
      print('❌ Exception during fetchSchools: $e');
      print('Stacktrace: $stacktrace');
      emit(FetchSchoolFailure('An unexpected error occurred'));
    }
  }

}