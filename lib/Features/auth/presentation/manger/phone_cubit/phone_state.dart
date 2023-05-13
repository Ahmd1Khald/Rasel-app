part of 'phone_cubit.dart';

@immutable
abstract class PhoneState {}

class PhoneInitial extends PhoneState {}

class PhoneSuccessSendOtpState extends PhoneState {}

class PhoneErrorSendOtpState extends PhoneState {
  final String errorMsg;
  PhoneErrorSendOtpState(this.errorMsg);
}

class PhoneLoadingSendOtpState extends PhoneState {}

class PhoneSuccessConfirmOtpState extends PhoneState {
  final String uid;
  PhoneSuccessConfirmOtpState(this.uid);
}

class PhoneErrorConfirmOtpState extends PhoneState {
  final String errorMsg;
  PhoneErrorConfirmOtpState(this.errorMsg);
}

class PhoneLoadingConfirmOtpState extends PhoneState {}
