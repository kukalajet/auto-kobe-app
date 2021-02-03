part of 'preview_bloc.dart';

enum PreviewStatus { initial, success, failure }

class PreviewState extends Equatable {
  const PreviewState({
    this.status = PreviewStatus.initial,
    this.previews = const <Listing>[],
    this.hasReachedMax = false,
  });

  final PreviewStatus status;
  final List<Listing> previews;
  final bool hasReachedMax;

  PreviewState copyWith({
    PreviewStatus status,
    List<Listing> previews,
    bool hasReachedMax,
  }) {
    return PreviewState(
      status: status ?? this.status,
      previews: previews ?? this.previews,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [status, previews, hasReachedMax];
}
