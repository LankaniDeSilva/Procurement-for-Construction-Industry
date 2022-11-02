import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';


const uid = 'abc';
Future<void> main() async {
  group("dump", () {
    var expectedDumpAfterset = {
      'users': {
        'abc': {'name': 'name', 'email': 'email', 'uid': 'abc'}
      }
    };

    test("Sets data for user collection", () async {
      final instance = FakeFirebaseFirestore();
      await instance.collection('users').doc(uid).set(
        {'name': "name", 'email': 'email', 'uid': uid},
      );

      expect(instance.dump(), equals(expectedDumpAfterset));
    });
  });
}
