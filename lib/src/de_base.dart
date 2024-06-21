import 'dart:math';

import 'package:de/src/Solution.dart';
import 'package:pso/pso.dart';

class DE {
  late List<Solution> _solutions;
  late double _cr;
  late double _F;
  late FitnessFunctionType _fitnessFunctionType;
  late Random _random;

  DE(FitnessFunctionType fitnessFunctionType, List<double> mins,
      List<double> maxs,
      {int popsize = 100, double cr = 0.80, double F = 1}) {
    _random = Random();
    //_solutions = List<Solution>(popsize);
    _solutions = List<Solution>.generate(popsize, (index) {
      return Solution(fitnessFunctionType, mins.length, mins, maxs);
    });
    _cr = cr;
    _F = F;
    _fitnessFunctionType = fitnessFunctionType;
    for (var i = 0; i < popsize; i++) {
      _solutions[i] = Solution(fitnessFunctionType, mins.length, mins, maxs);
    }
  }

  List<int> getRandom3IndexExceptOne(int Min, int Max, int except) {
    var indices = List<int>.empty(growable: true);
    while (indices.length < 3) {
      var luckyIndex = Min + _random.nextInt(Max - Min);
      if (luckyIndex != except) {
        if (!indices.contains(luckyIndex)) {
          indices.add(luckyIndex);
        }
      }
    }
    return indices;
  }

  void calculateFitnessForAll() {
    _solutions.forEach((Solution element) {
      element.setFitness(_fitnessFunctionType(element.getValues()));
    });
  }

  Solution getBest() {
    var best = _solutions[0];
    for (var i = 1; i < _solutions.length; i++) {
      if (_solutions[i].getFitness() > best.getFitness()) {
        best = _solutions[i];
      }
    }
    return best;
  }

  void iterateN(int n) {
    for (var i = 0; i < n; i++) {
      iterate();
    }
  }

  void iterate() {
    calculateFitnessForAll();
    var newpop = List<Solution>.empty(growable: true);
    for (var i = 0; i < _solutions.length; i++) {
      var currentSolution = _solutions[i];
      if (_random.nextDouble() > _cr) {
        newpop.add(currentSolution);
      } else {
        var indices =
            getRandom3IndexExceptOne(0, _solutions.length - 1, i);
        var A = _solutions[indices[0]].getValues();
        var B = _solutions[indices[1]].getValues();
        var C = _solutions[indices[2]].getValues();
        var Y =
            Vector.Sum(A, Vector.ProdWithScaler(Vector.Sum(B, C), _F));
        var candidateFitness = _fitnessFunctionType(Y);
        if (candidateFitness > currentSolution.getFitness()) {
          var news = currentSolution.deepCopy();
          news.setValues(Y);
          news.setFitness(candidateFitness);
          newpop.add(news);
        } else {
          newpop.add(currentSolution.deepCopy());
        }
      }
    }
    _solutions = newpop;
  }
}
