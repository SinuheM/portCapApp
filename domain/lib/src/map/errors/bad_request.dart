class BadRequest implements Exception {
  String title = '';
  String message = '';
  BadRequest() {
    title = 'Ocurrio un problema';
    message =
        "Ocurrió un problema, asegurese que todos los campos fueron completados correctamente";
  }
}
