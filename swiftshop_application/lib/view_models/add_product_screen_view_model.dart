import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('products');
final CollectionReference _imageCollection = _firestore.collection('product');

class Database {
  static String? productUid;
}

class AddProduct {
  static Future<void> uploadImage({
    required String path,
    required int productid,
  }) async {
    final file = await ImagePicker().pickImage(source: ImageSource.camera);
  }

  static Future<void> addItem({
    // required int id,
    required String path,
    required String name,
    required String description,
    required int price,
    required int promotionPrice,
    required int quantity,
    required int quantitySold,
    required int rate,
    required String type,
  }) async {
    DocumentReference documentReference =
        _mainCollection.doc(Database.productUid);
    Map<String, dynamic> data = <String, dynamic>{
      // "id": id,
      "path": path,
      "name": name,
      "description": description,
      "price": price,
      "promotionPrice": promotionPrice,
      "quantity": quantity,
      "quantitySold": quantitySold,
      "rate": rate,
      "type": type,
    };
    await documentReference
        .set(data)
        .whenComplete(() => print("Products item added to the datatbase"))
        .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot> readItems() {
    CollectionReference productsItemCollection =
        _mainCollection.doc(Database.productUid).collection('products');
    return productsItemCollection.snapshots();
  }

  static Future<void> updateItem({
    required int id,
    required String name,
    required String description,
    required int price,
    required int promotionPrice,
    required int quantity,
    required int quantitySold,
    required int rate,
    required String type,
  }) async {
    DocumentReference documentReference =
        _mainCollection.doc(Database.productUid).collection(' ').doc();
    Map<String, dynamic> data = <String, dynamic>{
      "id": id,
      "name": name,
      "description": description,
      "price": price,
      "promotionPrice": promotionPrice,
      "quantity": quantity,
      "quantitySold": quantitySold,
      "rate": rate,
      "type": type,
    };
    await documentReference
        .set(data)
        .whenComplete(() => print("Products item updated to the datatbase"))
        .catchError((e) => print(e));
  }
}
