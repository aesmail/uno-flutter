class UnoAction {
  final String value; // could be: number, color name, etc.
  final List<String> options; // could be: color.
  final String title; // could be: Draw 4, Skip Player, etc.
  final String type; // could be: normal, skip, draw, color, switch, etc.

  UnoAction({this.value, this.title, this.type, this.options});
}
