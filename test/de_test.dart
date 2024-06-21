import 'dart:math';

import 'package:de/de.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    setUp(() {});

    test('Random 3 index test', () {
      double f(List<double> x) {
        return 0;
      }

      var de = DE(f, [0, 0, 0], [1, 1, 1]);
      var result = de.getRandom3IndexExceptOne(10, 20, 15);
      expect(result.length, 3);
      expect(result.contains(15), false);

      result = de.getRandom3IndexExceptOne(10, 15, 10);
      expect(result.length, 3);
      expect(result.contains(10), false);

      result = de.getRandom3IndexExceptOne(10, 13, 13);
      expect(result.length, 3);
      expect(result.contains(13), false);
    });

    test('Min f(x,y) = (x-pi)^2 + (y-e)^2', () {
      double f(List<double> x) {
        return -(pow(x[0] - 3.14159265, 2.0) + pow(x[1] - exp(1.0), 2.0))
            as double;
      }

      var de = DE(f, [-500, -500], [500, 500], cr: 0.99, F: 1.20, popsize: 300);
      de.iterateN(5000);
      var best = de.getBest();
      print(best);
      expect(best.getFitness() > -0.05, true);
    });

    test('median', () {
      double f(List<double> x) {
        var vals = <double>[
          1.0,
          2.0,
          3.0,
          4.0,
          5.0,
          6.0,
          700.0,
          800.0,
          900.0,
          100.0
        ];
        var s = 0.0;
        for (var i = 0; i < vals.length; i++) {
          s += (vals[i] - x[0]).abs().toDouble();
        }
        return -s;
      }

      var de = DE(f, [-100.0], [100.0], cr: 0.99, F: 1.50, popsize: 300);
      de.iterateN(10000);
      de.calculateFitnessForAll();
      var best = de.getBest();
      expect(best.getValues()[0].toString().startsWith('5.'), true);
    });
  });
}
