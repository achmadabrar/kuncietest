import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuncietestapp/search_page/models/result.dart';
import 'package:kuncietestapp/search_page/search_repoistory.dart';
import 'package:rxdart/rxdart.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchRepository repository = SearchRepository();
  List<Result>? results = [];
  int currentLenght = 0;
  bool isLastPage = false;

  SearchBloc(
      {this.results})
      : super(SearchLoading());

  @override
  SearchState get initialState => SearchLoading();

  @override
  Stream<Transition<SearchEvent, SearchState>> transformEvents(
      Stream<SearchEvent> events, transitionFn) {
    return super.transformEvents(
        events.debounceTime(Duration(milliseconds: 500)), transitionFn);
  }

  @override
  Stream<SearchState> mapEventToState(SearchEvent event,) async* {
    if (event is GetInfiniteLoad) {
      yield* _mapEventToStateInfiniteLoad(0, 10);
    } else if (event is GetMoreInfiniteLoad) {
      yield* _mapEventToStateInfiniteLoad(event.start, event.limit);
    }
  }

  Stream<SearchState> _mapEventToStateInfiniteLoad(int start,
      int limit) async* {
    try {
      if (state is SearchLoaded) {
        results = (state as SearchLoaded).data;
        currentLenght = (state as SearchLoaded).count;
      }

      if (currentLenght != 0) {
        yield SearchMoreLoading();
      } else {
        yield SearchLoading();
      }

      if (currentLenght == 0 || isLastPage == false) {
        final reqData = await repository.fetchMusic(start, limit);

        if (reqData.results.isNotEmpty) {
          results?.addAll(reqData.results);
          if (currentLenght != null) {
            currentLenght += reqData.results.length;
            yield SearchLoaded(data: reqData.results , count: currentLenght);
          } else {
            currentLenght = reqData.results.length;
            yield SearchLoaded(data: results!, count: currentLenght);
          }
        } else {
          isLastPage = true;
          yield SearchLoaded(data: reqData.results, count: currentLenght);
        }
      }

    } catch (e) {
      yield SearchError(error: e.toString());
    }
  }
}
