class NoNetwork implements Exception {
  String title = '';
  String message = '';
  NoNetwork() {
    title = "Error inesperado";
    message = "Oh no, tuvimos problemas al actualizar la información de las capas";
  }
}
