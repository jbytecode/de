import 'package:de/de.dart';
import 'package:de/src/Solution.dart';

void main() {
  List<double> vals = [
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
    double s = 0.0;
    for (int i = 0; i < vals.length; i++) {
      s += (vals[i] - x[0]).abs().toDouble();
    }
    return -s;
  }

  DE de = DE(f, [-100.0], [100.0], cr: 0.99, F: 1.50, popsize: 300);
  de.iterateN(10000);
  de.calculateFitnessForAll();
  Solution best = de.getBest();

  print(best);
}
