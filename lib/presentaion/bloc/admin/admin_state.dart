

abstract class AdminStates{
}


class AppIntialState extends AdminStates{


}

class GetAllDoctorsSuccessState extends AdminStates{


  GetAllDoctorsSuccessState();
}

class GetAllDoctorsLoadingState extends AdminStates{


  GetAllDoctorsLoadingState();
}


class GetAllDoctorsErrorState extends AdminStates{

  final String error;

  GetAllDoctorsErrorState(this.error);
}

class GetAllAdsSuccessState extends AdminStates{


  GetAllAdsSuccessState();
}

class GetAllAdsLoadingState extends AdminStates{


  GetAllAdsLoadingState();
}


class GetAllAdsErrorState extends AdminStates{

  final String error;

  GetAllAdsErrorState(this.error);
}


class GetAllBookingSuccessState extends AdminStates{


  GetAllBookingSuccessState();
}


class GetAllBookingLoadingState extends AdminStates{


  GetAllBookingLoadingState();
}


class GetAllBookingErrorState extends AdminStates{

  final String error;

  GetAllBookingErrorState(this.error);
}
class getBakaSuccessState extends AdminStates{
}

class getBakaLoadingState extends AdminStates{
}

class getBakaErrorState extends AdminStates{
  String error;
  getBakaErrorState({required this.error});
}


class  DeleteDoctorsSuccessState extends AdminStates{

  DeleteDoctorsSuccessState();
}

 class DeleteDoctorsLoadingState extends AdminStates{

   DeleteDoctorsLoadingState();
}


class DeleteDoctorsErrorState extends AdminStates{
  final String error;
  DeleteDoctorsErrorState(this.error);
}


class  DeleteAdSuccessState extends AdminStates{


  DeleteAdSuccessState();
}

class DeleteAdLoadingState extends AdminStates{

  DeleteAdLoadingState();
}


class DeleteAdErrorState extends AdminStates{
  final String error;
  DeleteAdErrorState(this.error);
}
class  DeleteBakaSuccessState extends AdminStates{


  DeleteBakaSuccessState();
}

class DeleteBakaLoadingState extends AdminStates{

  DeleteBakaLoadingState();
}


class DeleteBakaErrorState extends AdminStates{
  final String error;
  DeleteBakaErrorState(this.error);
}



class  DeleteCountrySuccessState extends AdminStates{


  DeleteCountrySuccessState();
}

class DeleteCountryLoadingState extends AdminStates{

  DeleteCountryLoadingState();
}


class DeleteCountryErrorState extends AdminStates{
  String error;
  DeleteCountryErrorState({required this.error});
}




class  DeleteCatSuccessState extends AdminStates{


  DeleteCatSuccessState();
}

class DeleteCatLoadingState extends AdminStates{

  DeleteCatLoadingState();
}

class  AddCatSuccessState extends AdminStates{


  AddCatSuccessState();
}

class AddCatLoadingState extends AdminStates{

  AddCatLoadingState();

}
class AddCatErrorState extends AdminStates{
  String error;

  AddCatErrorState({required this.error});

}






class  AddBakaSuccessState extends AdminStates{
  AddBakaSuccessState();
}

class AddBakaLoadingState extends AdminStates{
  AddBakaLoadingState();
}


class AddBakaErrorState extends AdminStates{
  String error;
  AddBakaErrorState({required this.error});
}








class  AddCountrySuccessState extends AdminStates{


  AddCountrySuccessState();
}

class AddCountryLoadingState extends AdminStates{

  AddCountryLoadingState();

}
class AddCountryErrorState extends AdminStates{
  String error;

  AddCountryErrorState({required this.error});

}


class  AddToBestSuccessState extends AdminStates{


  AddToBestSuccessState();
}

class AddBestLoadingState extends AdminStates{

  AddBestLoadingState();
}

class AddBestErrorState extends AdminStates{

  String error;
  AddBestErrorState({required this.error});
}














class GetCountrySuccessState extends AdminStates{

  GetCountrySuccessState();
}

class GetCountryLoadingState extends AdminStates{

  GetCountryLoadingState();
}
class GetCountryErrorState extends AdminStates{
  String error;
  GetCountryErrorState(this.error);
}


class sendImageToServerErrorState extends AdminStates{
  String error;

  sendImageToServerErrorState({required this.error});

}
class setImageSuccessState extends AdminStates{

}
class sendImageToServerSuccessState extends AdminStates{


}
class sendImageToServerLoadingState extends AdminStates{


}

class DeleteCatErrorState extends AdminStates{
  final String error;
  DeleteCatErrorState(this.error);
}

class getCatSuccessState extends AdminStates{


  getCatSuccessState();
}
class getCatLoadingState extends AdminStates{


  getCatLoadingState();
}

class getCatErrorState extends AdminStates{
  String error;

  getCatErrorState({required this.error});
}























