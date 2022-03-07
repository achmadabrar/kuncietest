import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuncietestapp/search_page/models/result.dart';
import 'package:kuncietestapp/search_page/search_bloc.dart';
import 'package:kuncietestapp/search_page/widget/music_play_widget.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPage createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  SearchBloc _bloc = SearchBloc();
  int _currentLenght = 0;
  List<Result> _data = [];

  void _loadMoreData() {
    print('panjang :' + _currentLenght.toString());
    _bloc.add(
        GetMoreInfiniteLoad(start: _currentLenght, limit: _currentLenght + 10));
  }

  @override
  void initState() {
    _bloc = BlocProvider.of<SearchBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchLoaded || state is SearchMoreLoading) {
            if (state is SearchLoaded) {
              _data = state.data;
              _currentLenght = state.count;
            }
            return _buildListMedia(state);
          } else if (state is SearchLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SearchError) {
            return Text(state.error);
          } else {
            return Text('error unknown');
          }
        },
      ),
    );
  }

  Widget _buildListMedia(SearchState state) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: CupertinoSearchTextField(),
          ),
          Expanded(
              child: LazyLoadScrollView(
            child: ListView(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: _data.length,
                    padding: EdgeInsets.only(left: 20, right: 20),
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (_, i) {
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20)),
                                ),
                                builder: (context) {
                                  return FractionallySizedBox(
                                    heightFactor: 0.2,
                                    child: MusicPlayWidget(
                                      trackViewUrl: _data[i].trackViewUrl,
                                    ),
                                  );
                                });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(_data[i].trackName),
                                  SizedBox(height: 8.0),
                                  Text(_data[i].collectionCensoredName),
                                  SizedBox(height: 8.0),
                                  Text(_data[i].artistName),
                                ]),
                          ),
                        ),
                      );
                    }),
                // Loading indicator more load data
                (state is SearchMoreLoading)
                    ? Center(child: CircularProgressIndicator())
                    : SizedBox(),
              ],
            ),
            onEndOfPage: _loadMoreData,
          )),
        ],
      ),
    );
  }
}
