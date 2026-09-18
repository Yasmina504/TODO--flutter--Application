import 'package:dio/dio.dart';
import '../models/task_data.dart';
import '../services/api_service.dart';

class TaskRepo {

  Future<Map<String, dynamic>> newTask({
    required String title,
    required String description,
  }) async {
    try {
      final response = await ApiService.dio.post(
        'new_task',
        data: FormData.fromMap({
          'title': title,
          'description': description,
        }),
      );
      final data = response.data as Map<String, dynamic>;

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (data['status'] == true) {
          return {
            'success': true,
            'message': data['message'] ?? 'Task created successfully',
          };
        }
      }
      return {
        'success': false,
        'message': data['message'] ?? 'Failed to create task',
      };
    } on DioError catch (e) {
      return {
        'success': false,
        'message': _handleError(e),
      };
    }
  }


  Future<Map<String, dynamic>> updateTask({
    required int id,
    required String title,
    required String description,
  }) async {
    try {
      final response = await ApiService.dio.put(
        'tasks/$id',
        data: FormData.fromMap({
          'title': title,
          'description': description,
        }),
      );
      final data = response.data as Map<String, dynamic>;

      if (response.statusCode == 200 && data['status'] == true) {
        return {
          'success': true,
          'message': data['message'] ?? 'Task updated successfully',
        };
      }
      return {
        'success': false,
        'message': data['message'] ?? 'Failed to update task',
      };
    } on DioError catch (e) {
      return {
        'success': false,
        'message': _handleError(e),
      };
    }
  }

  Future<Map<String, dynamic>> getMyTasks() async {
    try {
      final response = await ApiService.dio.get('my_tasks');
      final data = response.data as Map<String, dynamic>;

      if (response.statusCode == 200 && data['status'] == true) {
        final List<dynamic> tasksJson = data['data'] ?? [];
        final tasks = tasksJson
            .map((json) => TaskData.fromJson(json))
            .toList();

        return {
          'success': true,
          'tasks': tasks,
        };
      }
      return {
        'success': false,
        'message': 'Failed to load tasks',
      };
    } on DioError catch (e) {
      return {
        'success': false,
        'message': _handleError(e),
      };
    }
  }


  Future<Map<String, dynamic>> deleteTask({
    required int id,
  }) async {
    try {
      final response = await ApiService.dio.delete('tasks/$id');
      final data = response.data as Map<String, dynamic>;

      if (response.statusCode == 200 && data['status'] == true) {
        return {
          'success': true,
          'message': data['message'] ?? 'Task deleted successfully',
        };
      }
      return {
        'success': false,
        'message': data['message'] ?? 'Failed to delete task',
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