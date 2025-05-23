import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WeatherSubscriptionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> subscribeToWeatherUpdates(String email) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: 'temporaryPassword123!',
      );

      await userCredential.user?.sendEmailVerification();

      await _firestore.collection('weather_subscriptions').add({
        'email': email,
        'timestamp': FieldValue.serverTimestamp(),
        'verified': false,
        'userId': userCredential.user?.uid,
      });

      await _auth.signOut();
    } catch (e) {
      throw Exception('Failed to subscribe: $e');
    }
  }

  Future<void> unsubscribeFromWeatherUpdates(String email) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('weather_subscriptions')
          .where('email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        String? userId = querySnapshot.docs.first.get('userId') as String?;

        await querySnapshot.docs.first.reference.delete();

        if (userId != null) {
          try {
            UserCredential userCredential =
                await _auth.signInWithEmailAndPassword(
              email: email,
              password: 'temporaryPassword123!',
            );

            await userCredential.user?.delete();

            await _auth.signOut();
          } catch (e) {
            print('Failed to delete auth account: $e');
          }
        }
      }
    } catch (e) {
      throw Exception('Failed to unsubscribe: $e');
    }
  }
}
