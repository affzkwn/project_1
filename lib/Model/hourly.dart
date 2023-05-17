class Hourly {
  final double dt;
  final double temp;
  final double feelsLike;
  final double dewPoint;
  final double uvi;
  final String description;
  final double pressure;
  final double visibility;
  final double wind;
  final String icon;

  Hourly({
    required this.dt,
    required this.temp,
    required this.feelsLike,
    required this.dewPoint,
    required this.uvi,
    required this.description,
    required this.pressure,
    required this.visibility,
    required this.wind,
    required this.icon,
  });

  factory Hourly.fromJson(Map<String, dynamic> json) {
    return Hourly(
      dt: json['dt'].toDouble(),
      temp: json['main']['temp'].toDouble(),
      feelsLike: json['main']['feels_like'].toDouble(),
      dewPoint: json['dewPoint'].toDouble(),
      uvi: json['uvi'].toDouble(),
      description: json['weather'][0]['description'],
      pressure: json['main']['pressure'].toDouble(),
      visibility: json['visibility'].toDouble(),
      wind: json['wind'].toDouble(),
      icon: json['weather'][0]['icon'],
    );
  }
}
