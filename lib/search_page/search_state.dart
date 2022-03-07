part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();
  @override
  List<Object> get props => [];
}

class SearchLoading extends SearchState {}

class SearchMoreLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<Result> data;
  final int count;

  SearchLoaded({required this.data, required this.count});
  @override
  List<Object> get props => [data, count];
}

class SearchError extends SearchState {
  final String error;

  const SearchError({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => ' InfiniteLoadError { error: $error }';
}