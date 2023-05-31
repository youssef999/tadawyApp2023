

abstract class BookingStates{
}


class AppIntialState extends BookingStates{


}

class AddBookingSuccessState extends BookingStates{

  AddBookingSuccessState();
}

class AddBookingLoadingState extends BookingStates{
  AddBookingLoadingState();
}
class AddBookingErrorState extends BookingStates{
  String error;
  AddBookingErrorState(this.error);
}


class getBookingSuccessState extends BookingStates{

  getBookingSuccessState();
}

class getBookingLoadingState extends BookingStates{
  getBookingLoadingState();
}
class getBookingErrorState extends BookingStates{
  String error;
  getBookingErrorState(this.error);
}



