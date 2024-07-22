class WidgetConfig {
  final String type;
  final String? text;
  final String? color;

  WidgetConfig({required this.type, this.text, this.color});

  factory WidgetConfig.fromJson(Map<String, dynamic> json) {
    return WidgetConfig(
      type: json['type'],
      text: json['text'],
      color: json['color'],
    );
  }
}
