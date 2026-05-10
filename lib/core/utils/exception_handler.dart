import 'package:firebase_auth/firebase_auth.dart';
import 'package:verta/core/errors/exceptions.dart';

class ExceptionHandler {
  static AppException handleAuthException(Object e) {
    if (e is FirebaseAuthException) {
      return _handleFirebaseAuth(e);
    }
    return unexpected();
  }

  static AppException _handleFirebaseAuth(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return RemoteException('Invalid email address');
      case 'user-disabled':
        return RemoteException('This user has been disabled');
      case 'user-not-found':
        return RemoteException('No user found with this email');
      case 'wrong-password':
        return RemoteException('Wrong password');
      case 'email-already-in-use':
        return RemoteException('Email is already in use');
      case 'weak-password':
        return RemoteException('Password is too weak');
      case 'operation-not-allowed':
        return RemoteException('Operation not allowed');
      case 'too-many-requests':
        return RemoteException('Too many attempts, try again later');
      default:
        return RemoteException('Something went wrong, please try again');
    }
  }

  static AppException unexpected() {
    return RemoteException('Unexpected error occurred');
  }
}
