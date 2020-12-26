import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_world/models/preference_models.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  final CollectionReference preferenceCollection =
      FirebaseFirestore.instance.collection("preferencias");

  addPreference(String user, String language) async {
    return await preferenceCollection
        .doc(uid)
        .collection("my_preferences")
        .add({"user": user, "language": language});
  }

  removePreference(String preferenceId) async {
    return await preferenceCollection
        .doc(uid)
        .collection("my_preferences")
        .doc(preferenceId)
        .delete();
  }

  updatePreference(String preferenceId, String user, String language) async {
    return await preferenceCollection
        .doc(uid)
        .collection("my_preferences")
        .doc(preferenceId)
        .update({"user": user, "language": language});
  }

  Stream<List<Preference>> get preferences {
    return preferenceCollection
        .doc(uid)
        .collection("my_preferences")
        .snapshots()
        .map(_preferenceListFromSnapshot);
  }

  List<Preference> _preferenceListFromSnapshot(QuerySnapshot snapshot) {
    List<Preference> notes = List();
    for (var doc in snapshot.docs) {
      notes.add(Preference.fromMap(doc.id, doc.data()));
    }
    return notes;
  }
}