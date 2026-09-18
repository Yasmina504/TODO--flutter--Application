import 'package:dio/dio.dart';
import '../models/user_data.dart';
import '../services/api_service.dart';

class UserRepo {

  Future<Map<String, dynamic>> getUserData() async {
    try {
      final response = await ApiService.dio.get('get_user_data');
      final data = response.data as Map<String, dynamic>;

      if (response.statusCode == 200 && data['status'] == true) {
        final user = UserData.fromJson(data['user']);
        return {
          'success': true,
          'user': user,
        };
      }
      return {
        'success': false,
        'message': 'Failed to load user data',
      };
    } on DioError catch (e) {
      return {
        'success': false,
        'message': _handleError(e),
      };
    }
  }

 
  Future<Map<String, dynamic>> updateProfile({
    required String username,
  }) async {
    try {
      final response = await ApiService.dio.put(
        'update_profile',
        data: FormData.fromMap({
          'username': username,
        }),
      );
      final data = response.data as Map<String, dynamic>;

      if (response.statusCode == 200 && data['status'] == true) {
        return {
          'success': true,
          'message': data['message'] ?? 'User information updated successfully',
        };
      }
      return {
        'success': false,
        'message': data['message'] ?? 'Update failed',
      };
    } on DioError catch (e) {
      return {
        'success': false,
        'message': _handleError(e),
      };
    }
  }


  Future<Map<String, dynamic>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirm,
  }) async {
    try {
      final response = await ApiService.dio.post(
        'change_password',
        data: FormData.fromMap({
          'current_password': currentPassword,
          'new_password': newPassword,
          'new_password_confirm': newPasswordConfirm,
        }),
      );
      final data = response.data as Map<String, dynamic>;

      if (response.statusCode == 200 && data['status'] == true) {
        return {
          'success': true,
          'message': data['message'] ?? 'Password changed successfully',
        };
      }
      return {
        'success': false,
        'message': data['message'] ?? 'Change failed',
      };
    } on DioError catch (e) {
      return {
        'success': false,
        'message': _handleError(e),
      };
    }
  }


  String _handleError(DioError e) {
    if (e.response != null && e.response?.data != null) {
      final data = e.response?.data;
      if (data is Map && data['message'] != null) {
        return data['message'];
      }
      if (data is Map && data['error'] != null) {
        return data['error'];
      }
    }
    return e.message ?? 'Something went wrong';
  }
}