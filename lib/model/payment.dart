class Payment {

  final String type;
  final String place;
  final double value;
  final int parcel;
  bool selected = false;

  Payment(
      this.type,
      this.place,
      this.value,
      this.parcel);

  Payment.fromJson(Map<String, dynamic> json)
      : type = json['data']['type'],
        place = json['data']['place'],
        value = double.parse(json['data']['value']),
        parcel = int.parse(json['data']['parcel']);
}
