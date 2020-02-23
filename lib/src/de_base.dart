import 'dart:math';

import 'package:de/src/Solution.dart';
import 'package:pso/pso.dart';

class DE {
  List<Solution> _solutions;
  double _cr;
  double _F;
  FitnessFunctionType _fitnessFunctionType;
  Random _random;

  DE(FitnessFunctionType fitnessFunctionType, List<double> mins,
      List<double> maxs,
      {int popsize = 100, double cr = 0.80, double F = 1}) {
    _random = Random();
    _solutions = List<Solution>(popsize);
    _cr = cr;
    _F = F;
    _fitnessFunctionType = fitnessFunctionType;
    for (int i = 0; i < popsize; i++) {
      _solutions[i] = Solution(fitnessFunctionType, mins.length, mins, maxs);
    }
  }

  List<int> getRandom3IndexExceptOne(int Min, int Max, int except) {
    List<int> indices = List<int>();
    while (indices.length < 3) {
      int luckyIndex = Min + _random.nextInt(Max - Min);
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
    Solution best = _solutions[0];
    for (int i = 1; i < _solutions.length; i++) {
      if (_solutions[i].getFitness() > best.getFitness()) {
        best = _solutions[i];
      }
    }
    return best;
  }

  void iterateN(int n) {
    for (int i = 0; i < n; i++) {
      iterate();
    }
  }

  void iterate() {
    calculateFitnessForAll();
    List<Solution> newpop = List<Solution>();
    for (int i = 0; i < _solutions.length; i++) {
      Solution currentSolution = _solutions[i];
      if (_random.nextDouble() > _cr) {
        newpop.add(currentSolution);
      } else {
        List<int> indices =
            getRandom3IndexExceptOne(0, _solutions.length - 1, i);
        List<double> A = _solutions[indices[0]].getValues();
        List<double> B = _solutions[indices[1]].getValues();
        List<double> C = _solutions[indices[2]].getValues();
        List<double> Y =
            Vector.Sum(A, Vector.ProdWithScaler(Vector.Sum(B, C), _F));
        double candidateFitness = _fitnessFunctionType(Y);
        if (candidateFitness > currentSolution.getFitness()) {
          Solution news = currentSolution.deepCopy();
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
