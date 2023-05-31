

abstract class CountryStates{
}


class AppIntialState extends CountryStates{


}

class GetCountrySuccessState extends CountryStates{

  GetCountrySuccessState();
}

class GetCountryLoadingState extends CountryStates{

  GetCountryLoadingState();
}
class GetCountryErrorState extends CountryStates{
  String error;
  GetCountryErrorState(this.error);
}






