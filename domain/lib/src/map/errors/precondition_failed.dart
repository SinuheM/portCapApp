class PreconditionFailed implements Exception {
  String title = '';
  String message = '';
  PreconditionFailed({this.title = 'Ocurrio un problema', this.message = 'Ocurrió un problema, no se pudo completar la operación'}) {
    title = title;
    message = message;
  }
}
