

abstract class DoctorStates{
}


class AppIntialState extends DoctorStates{


}

class getDoctorDataSuccessState extends DoctorStates{

  getDoctorDataSuccessState();

}

class getDoctorDataLoadingState extends DoctorStates{

}

class getDoctorDataErrorState extends DoctorStates{

String error;
getDoctorDataErrorState({required this.error});


}




