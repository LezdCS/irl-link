// This abstract class is intentionally defined with a single member to allow for generic use cases.
// ignore: one_member_abstracts
abstract class UseCase<T, P> {
  Future<T> call({required P params});
}
