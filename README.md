![Dart CI](https://github.com/jbytecode/de/workflows/Dart%20CI/badge.svg)

A Library for Differential Evolution Optimization


## Usage

A simple usage example:

```dart
import 'package:de/de.dart';

double f(List<double> x) {
  return -(pow(x[0] - 3.14159265, 2.0) + pow(x[1] - exp(1.0), 2.0));
}

void main(){
  DE de = DE(f, [-500, -500], [500, 500], cr: 0.99, F: 1.20, popsize: 300);
  de.iterateN(5000);
  Solution best = de.getBest();
  print(best);
}
```

## Details
* The objective function is always in the form of

```dart
double f(List<double> x){

}
```

* The optimization is always a maximation. If the objective
function of the problem is a minimization, the returned value of the
objective function can be multiplied by -1.0.

* The default parameters of the classical Differential Evolution Optimization
are set to cr = 0.8 and F = 1.0. These optimization parameters can be customized
in the constructor of DE class.
