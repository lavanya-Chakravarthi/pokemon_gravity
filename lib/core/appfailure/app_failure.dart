class AppFailure{
  final String message;

  AppFailure({this.message = "An Unexpected error occured."});

  @override
  String toString()=> 'AppFailure(message:$message)';
}