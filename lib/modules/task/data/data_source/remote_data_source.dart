import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tasks_admin/core/utils/api_handler.dart';
import 'package:tasks_admin/modules/task/data/model/task.dart';
import 'package:path/path.dart' as path;

abstract class TaskDataSource {
  Stream<List<TaskModel>> getTasks();

  Future<Result<TaskModel>> getTask(String taskId);

  Future<Result<bool>> deleteFile(String url);

  Future<Result<String>> createTask(TaskModel task);

  Future<Result<bool>> updateTask(TaskModel task);

  Future<Result<bool>> deleteTask(String taskId);

  Future<Result<String>> uploadFile({
    required File file,
    required String storagePath,
  });

  Future<Result<bool>> assignTask(String taskId, List<String> workerIds);
}

class TaskDataSourceImpl implements TaskDataSource {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final String _collectionName = 'tasks';

  @override
  Stream<List<TaskModel>> getTasks() {

    return _fireStore.collection(_collectionName).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => TaskModel.fromDocument(doc)).toList();
    }).handleError((error) {
      debugPrint('Error getting tasks: $error');
    });
  }

  @override
  Future<Result<TaskModel>> getTask(String taskId) async {
    try {
      final snapshot =
          await _fireStore.collection(_collectionName).doc(taskId).get();
      TaskModel task = TaskModel.fromDocument(snapshot);
      return Result.success(task);
    } on FirebaseException catch (e) {
      debugPrint('Firebase error getting task status: $e');
      return Result.error('Firebase error: ${e.message}');
    }
  }

  @override
  Future<Result<String>> createTask(TaskModel task) async {
    try {
      final collection = _fireStore.collection(_collectionName);
      final id = collection.doc().id;
      await collection.doc(id).set(task.toMap(id));
      return Result.success("TaskModel added successfully");
    } on FirebaseException catch (e) {
      debugPrint('Firebase error creating task status: $e');
      return Result.error('Firebase error: ${e.message}');
    } catch (e) {
      debugPrint('Error creating task status: $e');
      return Result.error('An unexpected error occurred.');
    }
  }

  @override
  Future<Result<bool>> deleteTask(String taskId) async {
    try {
      final collection = _fireStore.collection(_collectionName);
      await collection.doc(taskId).delete();
      return Result.success(true);
    } on FirebaseException catch (e) {
      debugPrint('Firebase error deleting task status: $e');
      return Result.error('Firebase error: ${e.message}');
    } catch (e) {
      debugPrint('Error deleting task status: $e');
      return Result.error('An unexpected error occurred.');
    }
  }

  @override
  Future<Result<bool>> updateTask(TaskModel task) async {
    try {
      final collection = _fireStore.collection(_collectionName);
      await collection.doc(task.id).update(task.toMap(task.id));
      return Result.success(true);
    } on FirebaseException catch (e) {
      debugPrint('Firebase error updating task status: $e');
      return Result.error('Firebase error: ${e.message}');
    } catch (e) {
      debugPrint('Error updating task status: $e');
      return Result.error('An unexpected error occurred.');
    }
  }

  @override
  Future<Result<bool>> assignTask(String taskId, List<String> workerIds) async {
    try {
      final collection = _fireStore.collection(_collectionName);
      await collection.doc(taskId).update({'workerAssignedId': workerIds});
      return Result.success(true);
    } on FirebaseException catch (e) {
      debugPrint('Firebase error updating task status: $e');
      return Result.error('Firebase error: ${e.message}');
    } catch (e) {
      debugPrint('Error updating task status: $e');
      return Result.error('An unexpected error occurred.');
    }
  }

  @override
  Future<Result<String>> uploadFile({
    required File file,
    required String storagePath,
  }) async {
    try {
      final String uploadFileName = path.basename(file.path);
      final Reference storageReference =
          _storage.ref().child('$storagePath/$uploadFileName');
      final UploadTask uploadTask = storageReference.putFile(file);
      final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      if (taskSnapshot.state == TaskState.success) {
        final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
        print(downloadUrl);
        return Result.success(downloadUrl);
      } else {
        return Result.error('File upload failed.');
      }
    } on FirebaseException catch (e) {
      debugPrint('Firebase Storage error: $e');
      return Result.error('Firebase Storage error: ${e.message}');
    } catch (e) {
      debugPrint('Error uploading file: $e');
      return Result.error('An unexpected error occurred during file upload.');
    }
  }

  @override
  Future<Result<bool>> deleteFile(String url) async {
    try {
      final Reference storageReference = _storage.refFromURL(url);
      await storageReference.delete();
      return Result.success(true);
    } on FirebaseException catch (e) {
      debugPrint('Firebase Storage error: $e');
      return Result.error('Firebase Storage error: ${e.message}');
    } catch (e) {
      debugPrint('Error deleting file: $e');
      return Result.error('An unexpected error occurred during file deletion.');
    }
  }
}

// // Example usage in a ViewModel (using ChangeNotifier)
// class TaskModelViewModel extends ChangeNotifier {
//   final TaskModelDataSource _taskDataSource;
//   List<TaskModel> _tasks = [];
//
//   List<TaskModel> get tasks => _tasks;
//   String? _errorMessage;
//
//   String? get errorMessage => _errorMessage;
//
//   TaskModelViewModel(this._taskDataSource) {
//     _loadTaskModels();
//   }
//
//   void _loadTaskModels() {
//     _taskDataSource.getTaskModels().listen((tasks) {
//       _tasks = tasks;
//       _errorMessage = null;
//       notifyListeners();
//     }, onError: (error) {
//       _errorMessage = 'Failed to load tasks: $error';
//       notifyListeners();
//     });
//   }
//
//   Future<void> acceptTaskModel(String taskId) async {
//     final result = await _taskDataSource.acceptTaskModel(taskId);
//     _handleResult(result, 'accept');
//   }
//
//   Future<void> cancelTaskModel(String taskId) async {
//     final result = await _taskDataSource.cancelTaskModel(taskId);
//     _handleResult(result, 'cancel');
//   }
//
//   Future<void> markTaskModelAsDone(String taskId) async {
//     final result = await _taskDataSource.markTaskModelAsDone(taskId);
//     _handleResult(result, 'mark as done');
//   }
//
//   void _handleResult(Result<bool> result, String action) {
//     if (result.data == true) {
//       debugPrint('TaskModel $action successful');
//       _errorMessage = null;
//       // Optionally, you might want to refresh the task list here
//       // _loadTaskModels(); // Or just rely on the stream to update the UI
//     } else {
//       _errorMessage = 'Failed to $action task: ${result.errorMessage}';
//       debugPrint(_errorMessage);
//     }
//     notifyListeners();
//   }
// }
