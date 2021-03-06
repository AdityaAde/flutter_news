import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newsapp/models/trending_news.dart';
import 'package:newsapp/resources/api_provider.dart';

part 'newstrending_event.dart';
part 'newstrending_state.dart';

class NewstrendingBloc extends Bloc<NewstrendingEvent, NewstrendingState> {
  ApiProvider apiProvider = ApiProvider();
  NewstrendingBloc() : super(NewstrendingInitial());

  @override
  Stream<NewstrendingState> mapEventToState(NewstrendingEvent event) async* {
    if (event is GetDataTrendingNews) {
      try {
        yield NewstrendingLoading();
        final dataNews = await apiProvider.trendingNewsApi();
        print(dataNews.status);
        yield NewstrendingLoaded(dataNews);
      } catch (e) {
        print('error di newsbloc ' + e);
      }
    }
  }
}
