import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:bowling/bowling/functions.dart';

void main() {
  final Functions f =Functions();
  group('Check if shot is a Strike', () {

    final params = {
      10 : true,
       2 : false,
       4: false,
       5 : false,
       8 : false
    };

    params.forEach((element, expected) {
      test('$element => $expected', () {
        expect(f.isStrike(element), expected);
      });
    });
  });

  group('check if sum of ints is greater than 10', () {

    final params = {
      '10/10/10': true,
      '3/3/3': false,
      '1/-5/3': false,
      '0/0/0': false,
      '10/0/0': false
    };

    params.forEach((key, value) {
      test('$key => $value', () {
        final numsAsStrings = key.split('/');
        List<int> nums = [];
        numsAsStrings.forEach((element) {
          nums.add(int.parse(element));
        });

        expect(f.isSumGreaterThan10(nums[0], nums[1], nums[2]), value);
      });
    });
  });

  group('is index greater then 1', () {

    final params = {
      0: false,
      2: true,
      9: true,
      10: true,
      -1: false,
    };

    params.forEach((element, expected) {
      test('$element => $expected', () {
        expect(f.isNumberGreaterThan1(element), expected);
      });
    });
  });
}