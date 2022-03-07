part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class GetInfiniteLoad extends SearchEvent {}

class GetMoreInfiniteLoad extends SearchEvent {
  final int start, limit;

  GetMoreInfiniteLoad({required this.start, required this.limit});

  @override
  List<Object> get props => [start, limit];
}