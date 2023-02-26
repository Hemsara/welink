enum ResponseStatus { success, failed }

class Response {
  final ResponseStatus status;
  final Map<String, dynamic>? data;
  final List? errors;
  Response({
    required this.status,
    this.data,
    this.errors,
  });
}
