// lib/controllers/register_controller.dart
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:khetihar/API/API.dart';
import 'package:khetihar/API/ErrorHandler.dart';
import '../../API/Storage.dart';
import '../Models/RegisterModel.dart';

class RegisterController extends GetxController {
  var isLoading = false.obs;

  Future<RegisterModel?> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;

      final response = await ApiClient.post(
        "/register",
        data: {
          "name": name,
          "email": email,
          "password": password,
        },
      );
      await SecureStore.saveTokens(response.data["token"]);

      return RegisterModel.fromJson(response.data);
    } catch (e) {
      showError(e);
      return null;
    } finally {
      isLoading.value = false;
    }
  }
}
