class Location {
  final String city;
  final String country;
  final String lat;
  final String lon;

  Location({
    required this.city,
    required this.country,
    required this.lat,
    required this.lon,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      city: json[0]['name'],
      country: json['sys'][0]['country'],
      lat: json['coord'][0]['lat'],
      lon: json['coord'][0]['lon'],
    );
  }
}
