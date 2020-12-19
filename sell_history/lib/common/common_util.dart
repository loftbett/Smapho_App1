import '../components/importer.dart';

// SQLite変換処理
class DbUtility {
  ///  日付型をローカルタイムに変換し、文字列で返却
  ///
  ///  [frDate] 変換元日付
  ///  返還後日付 (変換元がnull もしくは日付でない場合はnullを返却)
  static String convDTtSt(DateTime frDate) {
    if (frDate != null) {
      return frDate.toUtc().toIso8601String();
    } else {
      return null;
    }
  }
}
