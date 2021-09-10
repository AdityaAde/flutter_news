part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();
}

class GetNewsList implements NewsEvent {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}
