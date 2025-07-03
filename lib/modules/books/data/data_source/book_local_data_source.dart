abstract class BookLocalDataSource {
  Future<List<String>> getBookIdFavorites();
  Future setBookIdFavorites(List<String> ids);
}
