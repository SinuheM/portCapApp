class Unauthorized implements Exception {
  String title = '';
  String message = '';
  Unauthorized() {
    title = "Unauthorized";
    message = "You are not authorized to access";
  }
}
