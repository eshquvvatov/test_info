abstract class Either<L, R> {
  bool get isLeft;
  bool get isRight;
  
  // Qiymatlarni olish uchun yangi metodlar
  L get leftOrThrow;
  R get rightOrThrow;
  
  Future<void> fold(Function(L l) ifLeft, Function(R r) ifRight);
}

class FoldRight<L, R> extends Either<L, R> {
  final R _r;

  FoldRight(this._r);

  @override
  bool get isLeft => false;

  @override
  bool get isRight => true;

  @override
  R get rightOrThrow => _r;
  
  @override
  L get leftOrThrow => throw Exception("Right value doesn't have left");

  @override
  Future<void> fold(Function(L l) ifLeft, Function(R r) ifRight) async {
    await ifRight(_r);
  }
}

class FoldLeft<L, R> extends Either<L, R> {
  final L _l;

  FoldLeft(this._l);

  @override
  bool get isLeft => true;

  @override
  bool get isRight => false;

  @override
  L get leftOrThrow => _l;
  
  @override
  R get rightOrThrow => throw Exception("Left value doesn't have right");

  @override
  Future<void> fold(Function(L l) ifLeft, Function(R r) ifRight) async {
    await ifLeft(_l);
  }
}