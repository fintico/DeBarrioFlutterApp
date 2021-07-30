/* import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debarrioapp/ModelClass/OrderModel.dart';
import 'package:debarrioapp/ModelClass/OrderedDish.dart';
import 'package:debarrioapp/ModelClass/PostedDishModel.dart';
import 'package:debarrioapp/ModelClass/UserModel.dart';

class DatabaseService {
  DatabaseService();

  /// collection reference
  final CollectionReference usersCollection =
      Firestore.instance.collection('Users');

  ///Set the user data according to user id
  Future<void> setUserData(User user) async {
    return await usersCollection.document(user.id).setData(user.toMap());
  }

  User _userDataFromSnapshot(DocumentSnapshot snapshot) {
    User newUser = User();
    if (!snapshot.exists) return null;
    newUser.fromMap(snapshot);
    return newUser;
  }

  Stream<User> getCurrentUserData(User user) {
    return usersCollection
        .document(user.id)
        .snapshots()
        .map(_userDataFromSnapshot);
  }

  Stream<List<User>> getAllUserData() {
    return usersCollection.snapshots().map(_userDataListFromSnapshot);
  }

  Stream<User> getOtherUserData(String id) {
    return usersCollection.document(id).snapshots().map(_userDataFromSnapshot);
  }

  Stream<List<User>> getOtherUserDataFromPhone(String phoneNumber) {
    return usersCollection
        .where('phoneNumber', isEqualTo: phoneNumber)
        .snapshots()
        .map(_userDataListFromSnapshot);
  }

  List<User> _userDataListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return _userDataFromSnapshot(doc);
    }).toList();
  }

  //Fuel Station Queries
  final CollectionReference postedDishCollection =
      Firestore.instance.collection('postedDishes');

  Stream<List<PostedDish>> getAllPostedDishes() {
    return postedDishCollection.snapshots().map(_postedDishListFromSnapshot);
  }

  Stream<List<PostedDish>> getAllPostedDishesForUser(String id) {
    return postedDishCollection
        .where('makerId', isEqualTo: id)
        .snapshots()
        .map(_postedDishListFromSnapshot);
  }

  Stream<PostedDish> getSelectedPostedDish(String id) {
    return postedDishCollection
        .document(id)
        .snapshots()
        .map(_postedDishDataFromSnapshot);
  }

  List<PostedDish> _postedDishListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return _postedDishDataFromSnapshot(doc);
    }).toList();
  }

  PostedDish _postedDishDataFromSnapshot(DocumentSnapshot doc) {
    if (doc.exists) {
      PostedDish current = PostedDish();
      current.fromMap(doc);
      return current;
    }
    return null;
  }

  Future<void> setPostedDishData(PostedDish order) async {
    return await postedDishCollection.document(order.id).setData(order.toMap());
  }

  //Orders Queries
  final CollectionReference ordersCollection =
      Firestore.instance.collection('Orders');

  Stream<List<Order>> getSelectedUserOrders(String id) {
    return ordersCollection
        .where('buyerId', isEqualTo: id)
        .snapshots()
        .map(_orderedDataListFromSnapshot);
  }

  List<Order> _orderedDataListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return _ordersDataFromSnapshot(doc);
    }).toList();
  }

  Order _ordersDataFromSnapshot(DocumentSnapshot doc) {
    Order current = Order();
    current.fromMap(doc);
    return current;
  }

  Future<void> setOrderedData(Order order) async {
    return await ordersCollection.document(order.id).setData(order.toMap());
  }

  //Ordered Dishes Queries
  final CollectionReference ordersDishesCollection =
      Firestore.instance.collection('OrderDishes');

  Stream<List<OrderedDish>> getSelectedUserOrderDishes(String id) {
    return ordersDishesCollection
        .where('buyerId', isEqualTo: id)
        .snapshots()
        .map(_orderedDishDataListFromSnapshot);
  }

  List<OrderedDish> _orderedDishDataListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return _ordersDishDataFromSnapshot(doc);
    }).toList();
  }

  OrderedDish _ordersDishDataFromSnapshot(DocumentSnapshot doc) {
    OrderedDish current = OrderedDish();
    current.fromMap(doc);
    return current;
  }

  Future<void> setOrderedDishData(OrderedDish order) async {
    return await ordersDishesCollection
        .document(order.id)
        .setData(order.toMap());
  }

  Future<String> getRandomId() async {
    return Firestore.instance.collection('').document().documentID;
  }
}
 */
