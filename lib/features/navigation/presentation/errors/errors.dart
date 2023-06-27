class PageNotFoundException implements Exception {
  PageNotFoundException(this.location);
  final String location;
}
