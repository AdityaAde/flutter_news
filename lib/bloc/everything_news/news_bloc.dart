import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newsapp/models/news_models.dart';
import 'package:newsapp/resources/api_provider.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final ApiProvider apiProvider = ApiProvider();
  NewsBloc() : super(NewsInitial());

  @override
  Stream<NewsState> mapEventToState(NewsEvent event) async* {
    if (event is GetNewsList) {
      try {
        yield NewsLoading();
        final dataNews = await apiProvider.everythingNewsApi();
        print(dataNews.status);
        yield NewsLoaded(dataNews);
      } catch (e) {
        print('error di newsbloc ' + e);
      }
    }
  }
}
