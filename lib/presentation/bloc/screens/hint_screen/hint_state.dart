abstract class HintState {}

class CountState extends HintState {
  final int count;

  CountState({required this.count});
}