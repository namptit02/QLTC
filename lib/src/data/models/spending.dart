import 'package:cloud_firestore/cloud_firestore.dart';

class Spending {
  String? id;
  int money;
  int type;
  String? note;
  DateTime dateTime;
  String? image;
  String? typeName;


  Spending({
    this.id,
    required this.money,
    required this.type,
    required this.dateTime,
    this.note,
    this.image,
    this.typeName,
   
  });

  Map<String, dynamic> toMap() => {
        "money": money,
        "type": type,
        "note": note,
        "date": dateTime,
        "image": image,
        "typeName": typeName,
     
      };

  factory Spending.fromFirebase(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return Spending(
        id: snapshot.id,
        money: data["money"],
        type: data["type"],
        dateTime: (data["date"] as Timestamp).toDate(),
        note: data["note"],
        image: data["image"],
        typeName: data["typeName"],
        );
  }

  Spending copyWith({
    int? money,
    int? type,
    DateTime? dateTime,
    String? note,
    String? image,
    String? typeName,
    String? location,
    List<String>? friends,
  }) {
    return Spending(
      id: id,
      money: money ?? this.money,
      type: type ?? this.type,
      dateTime: dateTime ?? this.dateTime,
      note: note ?? this.note,
      image: image ?? this.image,
      typeName: typeName ?? this.typeName,
   
    );
  }
}
