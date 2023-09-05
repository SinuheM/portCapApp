class Unexpected implements Exception {
  String title = '';
  String message = '';
  Unexpected() {
    title = "Error inesperado";
    message = "Ocurrió un error desconocido, por favor vuelve a intentarlo";
  }
}
