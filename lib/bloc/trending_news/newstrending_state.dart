part of 'newstrending_bloc.dart';

abstract class NewstrendingState extends Equatable {
  const NewstrendingState();
}

class NewstrendingInitial extends NewstrendingState {
  @override
  List<Object> get props => [];
}

class NewstrendingLoading extends NewstrendingState {
  @override
  List<Object> get props => [];
}

class NewstrendingLoaded extends NewstrendingState {
  final TrendingNewsModel trendingNewsModel;
  NewstrendingLoaded(this.trendingNewsModel);
  @override
  List<Object> get props => [trendingNewsModel];
}

class NewstrendingError extends NewstrendingState {
  final String msgError;
  NewstrendingError(this.msgError);
  @override
  List<Object> get props => [msgError];
}
