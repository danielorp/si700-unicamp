import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_world/models/preference_models.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  final CollectionReference preferenceCollection =
      FirebaseFirestore.instance.collection("app-2");

  addPreference(int repo) async {
    DocumentReference add = await preferenceCollection
        .doc("preferencias")
        .collection(uid)
        .add({"repo": repo});
    print(add);
  }

  removePreference(String preferenceId) async {
    return await preferenceCollection
        .doc("preferencias")
        .collection(uid)
        .doc(preferenceId)
        .delete();
  }

  updatePreference(String preferenceId, int repo) async {
    return await preferenceCollection
        .doc("preferencias")
        .collection(uid)
        .doc(preferenceId)
        .update({"repo": repo});
  }

  Stream<List<Preference>> get preferences {
    return preferenceCollection
        .doc("preferencias")
        .collection(uid)
        .snapshots()
        .map(_preferenceListFromSnapshot);
  }

  List<Preference> _preferenceListFromSnapshot(QuerySnapshot snapshot) {
    List<Preference> preferences = List();
    for (var doc in snapshot.docs) {
      preferences.add(Preference.fromMap(doc.id, doc.data()));
    }
    return preferences;
  }
}
