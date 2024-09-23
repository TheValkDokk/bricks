// ignore_for_file: one_member_abstracts

abstract interface class UseCase<SuccessType, Params> {
  Future<SuccessType> call(Params params);
}

abstract interface class UseCaseNoParams<SuccessType> {
  Future<SuccessType> call();
}

abstract interface class UseCaseWithFailureHandling<SuccessType, Params>
    extends UseCase<SuccessType, Params> {
  Future<void> onFailed(Error e) async {
    throw Exception(e);
  }
}

abstract interface class StreamUseCase<SuccessType, Params> {
  Stream<SuccessType> call(Params params);
}

class NoParams {}
