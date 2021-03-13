import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:safeoutsios/model/food.dart';
import 'package:safeoutsios/notifier/food_notifier.dart';


getFoods(FoodNotifier foodNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection('Foods')
      .orderBy("createdAt", descending: true)
      .getDocuments();

  List<Food> _foodList = [];

  foodNotifier.foodList = _foodList;
}

uploadFoodAndImage(Food food, bool isUpdating, File localFile, Function foodUploaded) async {
  if (localFile != null) {
    print("uploading image");

    var fileExtension = path.extension(localFile.path);
    print(fileExtension);

  } else {
    print('...skipping image upload');
    _uploadFood(food, isUpdating, foodUploaded);
  }
}

_uploadFood(Food food, bool isUpdating, Function foodUploaded, {String imageUrl}) async {
  CollectionReference foodRef = Firestore.instance.collection('Foods');

  if (imageUrl != null) {
    food.image = imageUrl;
  }

  if (isUpdating) {
    food.updatedAt = Timestamp.now();

    await foodRef.document(food.id).updateData(food.toMap());

    foodUploaded(food);
    print('updated food with id: ${food.id}');
  } else {
    food.createdAt = Timestamp.now();

    DocumentReference documentRef = await foodRef.add(food.toMap());

    food.id = documentRef.documentID;

    print('uploaded food successfully: ${food.toString()}');

    foodUploaded(food);
  }
}

deleteFood(Food food, Function foodDeleted) async {
  if (food.image != null) {
    print('image deleted');
  }

  await Firestore.instance.collection('Foods').document(food.id).delete();
  foodDeleted(food);
}
