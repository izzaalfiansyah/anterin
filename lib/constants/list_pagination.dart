class ListPagination<T> {
  int currentPage;
  List<T> data;
  int perPage;
  int to;
  int total;

  ListPagination({
    this.currentPage = 1,
    required this.data,
    this.perPage = 1,
    this.to = 1,
    this.total = 1,
  });
}
