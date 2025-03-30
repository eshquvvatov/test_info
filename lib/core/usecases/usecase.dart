  abstract class UseCase <Type,Params> {
    const UseCase();
    Future<Type> call ({required Params params});
  }