import 'dart:typed_data';

class ValueFormatters {
  static Uint8List parseImageData(String source) {
    final parsedData =
        source.split(", ").map((item) => int.parse(item)).toList();

    return Uint8List.fromList(parsedData);
  }
}
