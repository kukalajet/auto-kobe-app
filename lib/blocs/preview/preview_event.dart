part of 'preview_bloc.dart';

abstract class PreviewEvent extends Equatable {
  const PreviewEvent();

  @override
  List<Object> get props => [];
}

class PreviewListingsFetched extends PreviewEvent {}
