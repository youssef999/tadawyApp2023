

abstract class PatientStates{
}


class AppIntialState extends PatientStates{


}

class getAdsSuccessState extends PatientStates{
}

class getAdsLoadingState extends PatientStates{
}


class GetCountryPriceSuccessState extends PatientStates{
}

class GetCountryPriceLoadingState extends PatientStates{
}

class GetCountryPriceErrorState extends PatientStates{
  String error;

  GetCountryPriceErrorState({required this.error});
}


class GetCountrySuccessState extends PatientStates{

  GetCountrySuccessState();
}

class GetCountryLoadingState extends PatientStates{

  GetCountryLoadingState();
}
class GetCountryErrorState extends PatientStates{
  String error;
  GetCountryErrorState(this.error);
}

class getAdsErrorState extends PatientStates{

  String error;

  getAdsErrorState({required this.error});
}


class getFiltersSuccessState extends PatientStates{
}

class getFiltersLoadingState extends PatientStates{
}

class getFiltersErrorState extends PatientStates{

  String error;

  getFiltersErrorState({required this.error});
}


class getPlacesSuccessState extends PatientStates{
}

class getPlacesLoadingState extends PatientStates{
}

class getPlacesErrorState extends PatientStates{

  String error;

  getPlacesErrorState({required this.error});
}


class getPlacesSuccessState2 extends PatientStates{
}

class getPlacesLoadingState2 extends PatientStates{
}

class getPlacesErrorState2 extends PatientStates{

  String error;

  getPlacesErrorState2({required this.error});
}



class getBestOffersSuccessState extends PatientStates{
}

class getBestOffersLoadingState extends PatientStates{
}

class getBestOffersErrorState extends PatientStates{

  String error;

  getBestOffersErrorState({required this.error});
}










class setFavSuccessState extends PatientStates{
}

class addToFavSuccessState extends PatientStates{
}

class LoadingFavState extends PatientStates{
}

class FavErrorState extends PatientStates{
  String error;

  FavErrorState({required this.error});
}
class getDoctorsSuccessState extends PatientStates{


  getDoctorsSuccessState();
}
class getDoctorsLoadingState extends PatientStates{


  getDoctorsLoadingState();
}

class getDoctorsErrorState extends PatientStates{


  getDoctorsErrorState();
}



class TopDoctorsSuccessState extends PatientStates{


  TopDoctorsSuccessState();
}
class TopDoctorsLoadingState extends PatientStates{


  TopDoctorsLoadingState();
}

class TopDoctorsErrorState extends PatientStates{


  TopDoctorsErrorState();
}


class getCatSuccessState extends PatientStates{


  getCatSuccessState();
}
class getCatLoadingState extends PatientStates{


  getCatLoadingState();
}

class getCatErrorState extends PatientStates{
String error;

getCatErrorState({required this.error});
}



class SearchSuccessState extends PatientStates{


  SearchSuccessState();
}
class SearchLoadingState extends PatientStates{


  SearchLoadingState();
}

class SearchErrorState extends PatientStates{
  String error;

  SearchErrorState({required this.error});
}


class getUserDataSuccessState extends PatientStates{


  getUserDataSuccessState();
}
class getUserDataLoadingState extends PatientStates{


  getUserDataLoadingState();
}

class getUserDataErrorState extends PatientStates{
  String error;

  getUserDataErrorState({required this.error});
}


class UpdateDataSuccessState extends PatientStates{


  UpdateDataSuccessState();
}
class UpdateDataLoadingState extends PatientStates{


  UpdateDataLoadingState();
}

class UpdateDataErrorState extends PatientStates{
  String error;

  UpdateDataErrorState({required this.error});
}