class VetoViewConfig {
  VetoViewConfig({
    required this.title,
    required this.header,
    required this.description,
    required this.counterLeftStartingValue,
    required this.counterRightStartingValue,
  });

  final String title;
  final String header;
  final String description;
  final int counterLeftStartingValue;
  final int counterRightStartingValue;

  @override
  String toString() {
    return 'VetoViewConfig{title: $title, header: $header, description: $description, counterLeftStartingValue: $counterLeftStartingValue, counterRightStartingValue: $counterRightStartingValue}';
  }
}
