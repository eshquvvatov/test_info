

abstract class Either<L, R> {
  bool get isLeft;

  bool get isRight;

 Future< void> fold(Function(L l) ifLeft, Function(R r) ifRight);
}

class FoldRight<L, R> extends Either<L, R> {
  final R _r;

  FoldRight(this._r);

  @override
  bool get isLeft => false;

  @override
  bool get isRight => true;

  @override
  Future< void> fold(Function(L l) ifLeft, Function(R r) ifRight) async {return  ifRight(_r);}
}

class FoldLeft<L, R> extends Either<L, R> {
  final L _l;

  FoldLeft(this._l);

  @override
  bool get isLeft => true;

  @override
  bool get isRight => false;

  @override
  Future<void> fold(Function(L l) ifLeft, Function(R r) ifRight)  async{ return ifLeft(_l);}
}
