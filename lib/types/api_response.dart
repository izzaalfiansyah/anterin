class ApiResponse {
  final String message;
  bool isError;

  ApiResponse({
    required this.message,
    this.isError = false,
  });
}
