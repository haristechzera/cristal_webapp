part of 'register_cubit.dart';

@immutable

sealed class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}
final class FetchSchoolLoading extends RegisterState {}
class FetchSchoolFailure extends RegisterState {
  final String message;

  const FetchSchoolFailure(this.message);
}
class FetchSchoolSuccess extends RegisterState {
  final FetchSchoolEntity response;

  const FetchSchoolSuccess(this.response);
}
