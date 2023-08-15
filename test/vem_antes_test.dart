import 'package:test/test.dart';

class TimeOfDay {
  final int hour;
  final int minute;

  TimeOfDay({
    required this.hour,
    required this.minute,
  });
}

void main() {
  bool vemAntes(TimeOfDay h1, TimeOfDay h2) {
    if (h1.hour == h2.hour) {
      if (h1.minute < h2.minute) {
        return true;
      } else {
        return false;
      }
    }

    if (h1.hour < h2.hour) {
      return true;
    }

    return false;
  }

  group('VemAntes', () {
    test('testando funcao vemAntes', () {
      TimeOfDay time1 = TimeOfDay(hour: 8, minute: 16);
      TimeOfDay time2 = TimeOfDay(hour: 8, minute: 17);

      final res = vemAntes(time1, time2);

      expect(res, true);
    });
  });
}
