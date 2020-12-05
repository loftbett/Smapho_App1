import 'package:sell_history/components/importer.dart';

class StyleBase {
  // Todoのメインテキストのスタイル(チェック時)
  TextStyle todoMainText(bool complete, bool important) {
    return TextStyle(
        fontSize: 20.0,
        color: complete ? Colors.white : important ? Colors.red : Colors.black);
  }

// Todoのサブテキストのスタイル
  TextStyle todoSubText(bool complete, bool important) {
    return TextStyle(color: complete ? Colors.white : Colors.grey[600]);
  }
}
