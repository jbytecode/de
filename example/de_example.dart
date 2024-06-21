import 'package:de/de.dart';

void main() {
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
  double f(List<double> x) {
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

  print(best);
}
