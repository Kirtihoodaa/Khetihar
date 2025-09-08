import 'package:dio/dio.dart';
import 'package:get/get.dart';

class AppError {
  final String message;
  final int? statusCode;

  const AppError({required this.message, this.statusCode});
}

AppError mapToAppError(Object error) {
  if (error is DioException) {
    final response = error.response;
    final status = response?.statusCode;

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return AppError(message: 'Request timed out. Please try again.', statusCode: status);
      case DioExceptionType.badCertificate:
        return AppError(message: 'Bad SSL certificate.', statusCode: status);
      case DioExceptionType.cancel:
        return AppError(message: 'Request was cancelled.', statusCode: status);
      case DioExceptionType.badResponse:
        final data = response?.data;
        final serverMsg = _extractServerMessage(data);
        return AppError(message: serverMsg ?? 'Server error (${status ?? 'unknown'}).', statusCode: status);
      case DioExceptionType.connectionError:
        return const AppError(message: 'No internet connection.');
      case DioExceptionType.unknown:
        return const AppError(message: 'Unexpected error occurred.');
    }
  }

  return const AppError(message: 'Something went wrong.');
}

String? _extractServerMessage(dynamic data) {
  if (data == null) return null;
  if (data is String) return data;
  if (data is Map<String, dynamic>) {
    // common API error shapes
    for (final key in ['message', 'error', 'detail']) {
      final val = data[key];
      if (val is String && val.trim().isNotEmpty) return val;
    }
    // nested validation errors like { errors: { email: ["..." ] } }
    final errors = data['errors'];
    if (errors is Map<String, dynamic>) {
      for (final entry in errors.entries) {
        final val = entry.value;
        if (val is List && val.isNotEmpty && val.first is String) {
          return val.first as String;
        }
        if (val is String) return val;
      }
    }
  }
  return null;
}

void showError(Object error) {
  final appError = mapToAppError(error);
  Get.snackbar('Error', appError.message);
}


