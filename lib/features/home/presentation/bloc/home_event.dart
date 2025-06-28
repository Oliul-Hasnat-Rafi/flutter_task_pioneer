part of 'home_bloc.dart';

enum SortType { none, dateTime, stars }

sealed class HomeEvent extends Equatable {
  const HomeEvent();
  
  @override
  List<Object> get props => [];
}

class HomeSearchRepositoriesEvent extends HomeEvent {
  final String query;

  const HomeSearchRepositoriesEvent({required this.query});

  @override
  List<Object> get props => [query];
}

class HomeLoadMoreRepositoriesEvent extends HomeEvent {
  const HomeLoadMoreRepositoriesEvent();
}

class HomeSortRepositoriesEvent extends HomeEvent {
  final SortType sortType;

  const HomeSortRepositoriesEvent({required this.sortType});

  @override
  List<Object> get props => [sortType];
}

class HomeClearSearchEvent extends HomeEvent {
  const HomeClearSearchEvent();
}