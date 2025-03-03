import 'package:firebase_database/firebase_database.dart';
import 'package:untitled/models/my_user.dart';
import 'package:untitled/models/Model.dart';
import 'package:untitled/utils/common.dart';

class BaseRepository<T> {
  final DatabaseReference databaseReference;

  BaseRepository(String tableName)
      : databaseReference = FirebaseDatabase.instance.ref().child(tableName);

  DatabaseReference getRef(){
    return databaseReference;
  }
  Future<List<Map<String, dynamic>>> findAll({String? lastKey, int limit = 10}) async {
    try {
      Query query = databaseReference.orderByKey().limitToFirst(limit);

      if (lastKey != null) {
        query = query.startAfter(lastKey);
      }

      final snapshot = await query.get();
      if (!snapshot.exists) return [];

      List<Map<String, dynamic>> results = [];
      String? newLastKey;

      if (snapshot.value is Map<dynamic, dynamic>) {
        Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;

        data.entries.forEach((entry) {
          results.add({'id': entry.key, ...entry.value});
          newLastKey = entry.key;
        });
      }

      return results;
    } catch (e) {
      print('Error fetching data: $e');
      return [];
    }
  }

  Future<void> findAllRealtime<T extends Model>(
      Function(List<T> ) onDataChanged,
      T Function(Map<String, dynamic>) fromJson) async {
    try {
      databaseReference.onValue.listen((event) {
        DataSnapshot snapshot = event.snapshot;

        if (snapshot.exists) {

          Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
          List<T> result = values.entries.map((entry) {
            return fromJson(castToMap(entry.value) );
          }).toList();

          onDataChanged(result);
        } else {
          print("No data found.");
          onDataChanged([]);
        }
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }
  Future<T?> findById<T>(String id, T Function(Map<String, dynamic>) fromJson) async {
    try {
      final snapshot = await databaseReference.child(id).get();

      if (!snapshot.exists) {
        print("No data found for ID: $id");
        return fromJson({});
      }

      // Check if snapshot.value is a Map before casting
      if (snapshot.value is Map) {
        return fromJson(Map<String, dynamic>.from({
          ...snapshot.value as Map<dynamic, dynamic>, // Safely cast the value to Map<dynamic, dynamic>
          "id": id
        }));
      } else {
        print("Snapshot value is not a map.");
        return fromJson({});
      }
    } catch (e) {
      print('Error fetching data by ID: $e');
      return fromJson({});
    }
  }



  Future<String?> create(T data) async {
    try {
      final newUserRef = databaseReference.push();

      await newUserRef.set(data);

      return newUserRef.key;
    } catch (e) {
      print('Error creating data: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> update(String recordKey, Map<String, dynamic> updatedData) async {
    try {
      await databaseReference.child(recordKey).update(updatedData);

      DatabaseEvent event = await databaseReference.child(recordKey).once();

      DataSnapshot snapshot = event.snapshot;

      if (snapshot.value != null && snapshot.value is Map) {
        Map<String, dynamic> data = Map<String, dynamic>.from(snapshot.value as Map);
        data['id'] = recordKey;
        return data;
      } else {
        return null;
      }
    } catch (e) {
      print('Error updating data: $e');
      return null; // Trả về null nếu có lỗi
    }
  }



  Future<bool> delete(String id) async {
    try {
      DatabaseReference ref = databaseReference.child(id);
      await ref.remove();
      return true;
    } catch (e) {
      print('Error deleting data: $e');
      return false;
    }
  }
  Future<List<Map<String, dynamic>>> search(String fieldName, Object value) async {
    try {
      if (value is! String && value is! int) {
        throw ArgumentError('Value must be a String or an int.');
      }
      Query query = databaseReference.orderByChild(fieldName).equalTo(value);
      DataSnapshot snapshot = (await query.once()).snapshot;
      if (!snapshot.exists) {
        return []; // Return empty list if no data found
      }

      List<Map<String, dynamic>> results = [];
      if (snapshot.value is Map<dynamic, dynamic>) {
        Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
        results.addAll(data.entries.map((entry) {
          return {'id': entry.key, ...entry.value};
        }));
      } else if (snapshot.value is List<dynamic>) {
        List<dynamic> dataList = snapshot.value as List<dynamic>;
        for (var item in dataList) {
          if (item is Map<dynamic, dynamic>) {
            results.add(item.cast<String, dynamic>());
          } else {
            print("Unexpected data format in list: ${item}");
          }
        }
      } else {
        print("Unexpected data format: ${snapshot.value}");
      }
      return results;
    } catch (e) {
      print('Error searching data: $e');
      return [];
    }
  }

  Future<void> searchRealtime<T extends Model>(
      String fieldName,
      String value,
      Function(List<T>) onDataChanged,
      T Function(Map<dynamic, dynamic>) fromJson,
      ) async {
    try {
      Query query = databaseReference.orderByChild(fieldName).equalTo(value);

      query.onValue.listen((event) {
        DataSnapshot snapshot = event.snapshot;

        if (snapshot.exists) {
          Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;

          List<T> result = values.entries.map((entry) {
            return fromJson(entry.value as Map<dynamic, dynamic>);
          }).toList();

          onDataChanged(result);
        } else {
          print("No matching data found.");
          onDataChanged([]);
        }
      });
    } catch (e) {
      print('Error searching data in realtime: $e');
    }
  }

}

