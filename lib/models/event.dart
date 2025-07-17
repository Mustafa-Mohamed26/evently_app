class Event {
  // data class or model

  // collection name
  static const String collectionName = 'Event';

  // Attributes
  String id;
  String eventImage;
  String eventName;
  String title;
  String description;
  DateTime eventDataTime;
  String eventTime;
  bool isFavorite;

  // constructor
  Event({
    this.id = "",
    required this.title,
    required this.description,
    required this.eventImage,
    required this.eventName,
    required this.eventDataTime,
    required this.eventTime,
    this.isFavorite = false,
  });

  // method to convert the object to json
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'event_image': eventImage,
      'event_name': eventName,
      'event_time': eventTime,
      'event_data_time': eventDataTime.millisecondsSinceEpoch, // int
      'is_favorite': isFavorite,
    };
  }

  // method to convert json ot object
  Event.fromFirestore(Map<String, dynamic> data)
    : this(
        id: data['id'] as String,
        title: data['title'] as String,
        description: data['description'] as String,
        eventImage: data['event_image'] as String,
        eventName: data['event_name'] as String,
        eventTime: data['event_time'] as String,
        eventDataTime: DateTime.fromMillisecondsSinceEpoch(
          data['event_data_time'],
        ),
        isFavorite: data['is_favorite'] as bool,
      );
}
