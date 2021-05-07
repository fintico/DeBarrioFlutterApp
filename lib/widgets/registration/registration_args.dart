class RegistrationArgs {
  String phoneNumber;
  bool isReady;
  String errorMessage;
  bool alreadyExist;

  RegistrationArgs(
      {this.phoneNumber,
      this.isReady = false,
      this.errorMessage = '',
      this.alreadyExist = false});
}
