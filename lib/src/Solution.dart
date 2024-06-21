import 'dart:math';
import 'package:pso/pso.dart';

class Solution {
  late FitnessFunctionType _fitnessFunctionType;
  late List<double> _mins, _maxs, _values;
  late double _fitness;

  Solution deepCopy() {
    var news = Solution(_fitnessFunctionType, _mins.length, _mins, _maxs);
    news.setValues(List.of(_values));
    news.setFitness(_fitness);
    return news;
  }

  Solution(FitnessFunctionType fitnessFunctionType, int p, List<double> mins,
      List<double> maxs) {
    var random = Random();
    _fitnessFunctionType = fitnessFunctionType;
    _mins = mins;
    _maxs = maxs;
    _values = List<double>.filled(p, 0.0);
    for (var i = 0; i < p; i++) {
      _values[i] = _mins[i] + ((_maxs[i] - _mins[i]) * random.nextDouble());
    }
    _fitness = double.negativeInfinity;
  }

  double getFitness() {
    return _fitness;
  }

  void setFitness(double fitness) {
    _fitness = fitness;
  }

  List<double> getValues() {
    return _values;
  }

  void setValues(List<double> values) {
    _values = values;
  }

  @override
  String toString() {
    return 'Solution{$_values, fitness: $_fitness}';
  }
}
