part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState();
}

class NewsInitial extends NewsState {
  @override
  List<Object> get props => [];
}

class NewsLoading extends NewsState {
  @override
  List<Object> get props => [];
}

class NewsLoaded extends NewsState {
  final NewsModel newsModel;
  NewsLoaded(this.newsModel);
  @override
  List<Object> get props => [newsModel];
}

class NewsError extends NewsState {
  final String msgError;
  NewsError(this.msgError);
  @override
  List<Object> get props => [msgError];
}
