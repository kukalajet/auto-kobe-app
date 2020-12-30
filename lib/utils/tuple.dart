class Tuple<T1, T2> {
  Tuple({
    this.firstItem,
    this.secondItem,
  });

  final T1 firstItem;
  final T2 secondItem;

  factory Tuple.fromJson(Map<String, dynamic> json) {
    return Tuple(
      firstItem: json['firstItem'],
      secondItem: json['secondItem'],
    );
  }
}
