class EventsModel {
  String? eventId;
  String? name;
  String? location;
  String? details;
  String? image;
  String? date;
  String? time;

  EventsModel({
    this.eventId,
    this.name,
    this.location,
    this.details,
    this.image,
    this.date,
    this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'eventId': eventId,
      'name': name,
      'location': location,
      'details': details,
      'image': image,
      'date': date,
      'time': time,
    };
  }

  factory EventsModel.fromMap(Map<String, dynamic> map) {
    return EventsModel(
      eventId: map['eventId'],
      name: map['name'],
      location: map['location'],
      details: map['details'],
      image: map['image'],
      date: map['date'],
      time: map['time'], 
    );
  }
}
