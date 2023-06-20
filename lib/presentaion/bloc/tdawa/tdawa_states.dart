

abstract class TdawaStates{
}


class AppIntialState extends TdawaStates{


}

class displayFirstSuccessState extends TdawaStates{
}

class displaySecondSuccessState extends TdawaStates{
}

class displayThirdSuccessState extends TdawaStates{
}







class getPaymentsSuccessState extends TdawaStates{

}

class getPaymentsLoadingState extends TdawaStates{

}

class getPaymentsErrorState extends TdawaStates{
  String error;
  getPaymentsErrorState({required this.error});
}










class getAppointmentsSuccessState extends TdawaStates{
}

class getAppointmentsLoadingState extends TdawaStates{
}

class getAppointmentsErrorState extends TdawaStates{
  String error;

  getAppointmentsErrorState({required this.error});
}
class SalesCoinsSuccessState extends TdawaStates{

}

class SalesCoinsLoadingState extends TdawaStates{

}

class SalesCoinsErrorState extends TdawaStates{

  final String error;

  SalesCoinsErrorState(this.error);
}
class ModLoginSuccessState extends TdawaStates{
}

class ModLoginLoadingState extends TdawaStates{
}

class ModLoginErrorState extends TdawaStates{
  String error;

  ModLoginErrorState({required this.error});
}












class getBakaSuccessState extends TdawaStates{
}

class getBakaLoadingState extends TdawaStates{
}

class getBakaErrorState extends TdawaStates{
  String error;

  getBakaErrorState({required this.error});
}



class getModSuccessState extends TdawaStates{
}

class getModLoadingState extends TdawaStates{
}

class getModErrorState extends TdawaStates{
  String error;

  getModErrorState({required this.error});
}




class DeleteModSuccessState extends TdawaStates{
}

class DeleteModLoadingState extends TdawaStates{
}

class DeleteModErrorState extends TdawaStates{
  String error;

  DeleteModErrorState({required this.error});
}







class AddModSuccessState extends TdawaStates{
}

class AddModLoadingState extends TdawaStates{
}

class AddModErrorState extends TdawaStates{
  String error;

  AddModErrorState({required this.error});
}







class ChangeNumAdsSuccessState extends TdawaStates{
}

class ChangeNumAdsLoadingState extends TdawaStates{
}

class ChangeNumAdsErrorState extends TdawaStates{

}

















class getDoctorDataSuccessState extends TdawaStates{
}

class getDoctorDataLoadingState extends TdawaStates{
}

class getDoctorDataErrorState extends TdawaStates{
  String error;

  getDoctorDataErrorState({required this.error});
}



class getDoctorAdsSuccessState extends TdawaStates{
}

class getDoctorAdsLoadingState extends TdawaStates{
}

class getDoctorAdsErrorState extends TdawaStates{
  String error;

  getDoctorAdsErrorState({required this.error});
}

class UpdateDoctorAdsSuccessState extends TdawaStates{
}

class UpdateDoctorAdsLoadingState extends TdawaStates{
}

class UpdateDoctorAdsErrorState extends TdawaStates{
  String error;

  UpdateDoctorAdsErrorState({required this.error});
}


class RenewDoctorAdsSuccessState extends TdawaStates{
}

class RenewDoctorAdsLoadingState extends TdawaStates{
}

class RenewDoctorAdsErrorState extends TdawaStates{
  String error;

  RenewDoctorAdsErrorState({required this.error});
}




class UpdateBookingStatusSuccessState extends TdawaStates{
}

class UpdateBookingStatusLoadingState extends TdawaStates{
}

class UpdateBookingStatusErrorState extends TdawaStates{
  String error;

  UpdateBookingStatusErrorState({required this.error});
}







class addNewAdSuccessState extends TdawaStates{
}

class addNewAdLoadingState extends TdawaStates{
}

class addNewAdErrorState extends TdawaStates{
  String error;

  addNewAdErrorState({required this.error});
}

class setImageSuccessState extends TdawaStates{

}
