
part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();
  
  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoadingMore extends HomeState {
  final List<Item> repositories;
  final SortType sortType;
  final String query;

  const HomeLoadingMore({
    required this.repositories,
    required this.sortType,
    required this.query,
  });

  @override
  List<Object> get props => [repositories, sortType, query];
}

class HomeLoaded extends HomeState {
  final List<Item> repositories;
  final bool hasReachedMax;
  final int currentPage;
  final SortType sortType;
  final String query;

  const HomeLoaded({
    required this.repositories,
    required this.hasReachedMax,
    required this.currentPage,
    required this.sortType,
    required this.query,
  });

  @override
  List<Object> get props => [
    repositories,
    hasReachedMax,
    currentPage,
    sortType,
    query,
  ];
}

class HomeError extends HomeState {
  final String errorMessage;

  const HomeError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class HomeEmpty extends HomeState {
  final String message;

  const HomeEmpty({required this.message});

  @override
  List<Object> get props => [message];
}