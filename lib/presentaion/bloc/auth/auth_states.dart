

abstract class AuthStates{
}


class AppIntialState extends AuthStates{
}

class LoginSuccessState extends AuthStates{



  LoginSuccessState();
}

class LoginLoadingState extends AuthStates{

}

class LoginErrorState extends AuthStates{

  final String error;

  LoginErrorState(this.error);
}


class UserLoginSuccessState extends AuthStates{

  UserLoginSuccessState();
}

class UserLoginSuccessState2 extends AuthStates{
  UserLoginSuccessState2();
}


class SalesLoginLoadingState extends AuthStates{
}


class SalesLoginErrorState extends AuthStates{
  final String error;
  SalesLoginErrorState(this.error);
}


class SalesLoginSuccessState extends AuthStates{



  SalesLoginSuccessState();
}

class SalesSystemLoadingState extends AuthStates{

}

class SalesSystemErrorState extends AuthStates{

  final String error;

  SalesSystemErrorState(this.error);
}


class SalesSystemSuccessState extends AuthStates{



  SalesSystemSuccessState();
}

class SalesDataLoadingState extends AuthStates{

}

class SalesDataErrorState extends AuthStates{

  final String error;

  SalesDataErrorState(this.error);
}


class SalesDataSuccessState extends AuthStates{



  SalesDataSuccessState();
}



class GetCoinsLoadingState extends AuthStates{

}

class GetCoinsErrorState extends AuthStates{

  final String error;

  GetCoinsErrorState(this.error);
}


class GetCoinsSuccessState extends AuthStates{

  GetCoinsSuccessState();
}


class AddNewFilterLoadingState extends AuthStates{

}

class AddNewFilterErrorState extends AuthStates{

  final String error;

  AddNewFilterErrorState(this.error);
}


class AddNewFilterSuccessState extends AuthStates{
  AddNewFilterSuccessState();
}

class AddNewPlacesLoadingState extends AuthStates{
}

class AddNewPlacesErrorState extends AuthStates{

  final String error;

  AddNewPlacesErrorState(this.error);
}


class AddNewPlacesSuccessState extends AuthStates{
  AddNewPlacesSuccessState();
}


class AddNewPlacesLoadingState2 extends AuthStates{

}

class AddNewPlacesErrorState2 extends AuthStates{

  final String error;

  AddNewPlacesErrorState2(this.error);
}


class AddNewPlacesSuccessState2 extends AuthStates{
  AddNewPlacesSuccessState2();
}












class UserLoginLoadingState extends AuthStates{

}

class UserLoginErrorState extends AuthStates{

  final String error;

  UserLoginErrorState(this.error);
}








class OtpFireSuccessState extends AuthStates{

}

class OtpFirebaseLoadingState extends AuthStates{

}

class OtpFirebaseErrorState extends AuthStates{

  final String error;

  OtpFirebaseErrorState(this.error);
}
















class RegisterSuccessState extends AuthStates{

}

class RegisterLoadingState extends AuthStates{

}

class RegisterErrorState extends AuthStates{

  final String error;

  RegisterErrorState(this.error);
}





class SalesCoinsSuccessState extends AuthStates{

}

class SalesCoinsLoadingState extends AuthStates{

}

class SalesCoinsErrorState extends AuthStates{

  final String error;

  SalesCoinsErrorState(this.error);
}










class UserRegisterSuccessState extends AuthStates{

}

class UserRegisterLoadingState extends AuthStates{

}

class UserRegisterErrorState extends AuthStates{

  final String error;

  UserRegisterErrorState(this.error);
}


class GoogleRegisterSuccessState extends AuthStates{

}

class ChangeCheckBoxState extends AuthStates{

}

class ChangeCheckBoxState2 extends AuthStates{

}

class FaceLoginLoadingState extends AuthStates{

}




class FaceLoginErrorState extends AuthStates{

  final String error;

  FaceLoginErrorState(this.error);
}

class FaceLoginSuccessState extends AuthStates{

}


class GoogleRegisterLoadingState extends AuthStates{

}

class GoogleRegisterErrorState extends AuthStates{

  final String error;

  GoogleRegisterErrorState(this.error);
}

class GoogleLoginSuccessState extends AuthStates{

}

class GoogleLoginLoadingState extends AuthStates{

}

class GoogleLoginErrorState extends AuthStates{

  final String error;

  GoogleLoginErrorState(this.error);
}












class setImageSuccessState extends AuthStates{

}





class SendDeviceIdSuccessState extends AuthStates{

}

class SendDeviceIdLoadingState extends AuthStates{

}

class SendDeviceIdErrorState extends AuthStates{

  final String error;

  SendDeviceIdErrorState(this.error);
}

class sendImageToServerSuccessState extends AuthStates{


}
class sendImageToServerLoadingState extends AuthStates{


}


class addNewSuccess extends AuthStates{


}


class ChangeButtonLocationSuccessState extends AuthStates{


}

class ChangeToogleIndexSuccessState extends AuthStates{


}






class GetLocationLoadingState extends AuthStates{


}



class GetLocationErrorState extends AuthStates{


}


class GetLocationSuccessState extends AuthStates{


}

class removeNewSuccess extends AuthStates{


}

class removeNewSuccess2 extends AuthStates{


}

class addNewSuccess2 extends AuthStates{


}

class sendImageToServerErrorState extends AuthStates{
String error;

sendImageToServerErrorState({required this.error});

}
