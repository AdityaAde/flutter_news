part of 'newstrending_bloc.dart';

abstract class NewstrendingEvent extends Equatable {
  const NewstrendingEvent();
}

class GetDataTrendingNews implements NewstrendingEvent {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}
