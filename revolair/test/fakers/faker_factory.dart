abstract class FakerFactory<T> {
  T create();
  Future<List<T>> createMany(int amount);
}