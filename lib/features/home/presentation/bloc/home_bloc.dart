import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/model/pogo_model/Item_model.dart';
import '../../domain/use_cases/home_use_case.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeUseCase homeUseCase;
  
  String _currentQuery = '';
  SortType _currentSortType = SortType.none;
  int _currentPage = 1;
  List<Item> _allRepositories = [];
  bool _hasReachedMax = false;

  HomeBloc({required this.homeUseCase}) : super(const HomeInitial()) {
    on<HomeSearchRepositoriesEvent>(_onSearchRepositories);
    on<HomeLoadMoreRepositoriesEvent>(_onLoadMoreRepositories);
    on<HomeSortRepositoriesEvent>(_onSortRepositories);
    on<HomeClearSearchEvent>(_onClearSearch);
  }

  Map<String, String?> _getSortParameters(SortType sortType) {
    switch (sortType) {
      case SortType.dateTime:
        return {'sort': 'updated', 'order': 'desc'};
      case SortType.stars:
        return {'sort': 'stars', 'order': 'desc'};
      case SortType.none:
        return {'sort': null, 'order': null};
    }
  }

  void _resetPaginationState() {
    _currentPage = 1;
    _allRepositories = [];
    _hasReachedMax = false;
  }

  Future<void> _onSearchRepositories(
    HomeSearchRepositoriesEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (event.query.trim().isEmpty) {
      emit(const HomeEmpty(message: 'Enter a search term to find repositories'));
      return;
    }

    if (event.query != _currentQuery) {
      emit(const HomeLoading());
      _currentQuery = event.query.trim();
      _resetPaginationState();
    }

    await _fetchRepositories(emit, isInitialLoad: true);
  }

  Future<void> _onLoadMoreRepositories(
    HomeLoadMoreRepositoriesEvent event,
    Emitter<HomeState> emit,
  ) async {
    final currentState = state;
    
    if (currentState is! HomeLoaded || 
        currentState.hasReachedMax || 
        _currentQuery.isEmpty) {
      return;
    }

    emit(HomeLoadingMore(
      repositories: currentState.repositories,
      sortType: currentState.sortType,
      query: currentState.query,
    ));

    _currentPage++;
    await _fetchRepositories(emit, isLoadMore: true);
  }

  Future<void> _onSortRepositories(
    HomeSortRepositoriesEvent event,
    Emitter<HomeState> emit,
  ) async {
    final currentState = state;
    
    if (currentState is! HomeLoaded || _currentQuery.isEmpty) return;

    if (_currentSortType == event.sortType) return;

    _currentSortType = event.sortType;
    emit(const HomeLoading());
    
    _resetPaginationState();
    await _fetchRepositories(emit, isInitialLoad: true);
  }

  Future<void> _onClearSearch(
    HomeClearSearchEvent event,
    Emitter<HomeState> emit,
  ) async {
    _currentQuery = '';
    _currentSortType = SortType.none;
    _resetPaginationState();
    emit(const HomeInitial());
  }

  Future<void> _fetchRepositories(
    Emitter<HomeState> emit, {
    bool isInitialLoad = false,
    bool isLoadMore = false,
  }) async {
    try {
      final sortParams = _getSortParameters(_currentSortType);
      
      final result = await homeUseCase.retrieveRepositories(
        query: _currentQuery,
        pageSize: 30, 
        pageNumber: _currentPage,
        sortBy: sortParams['sort'],
        order: sortParams['order'],
      );

      result.fold(
        (error) => emit(HomeError(errorMessage: error)),
        (repositoriesListEntity) {
          final newRepositories = repositoriesListEntity.repositories;
          
          if (isInitialLoad) {
            _allRepositories = newRepositories;
          } else if (isLoadMore) {
            _allRepositories.addAll(newRepositories);
          }

          _hasReachedMax = newRepositories.length < 30;

          if (_allRepositories.isEmpty) {
            emit(HomeEmpty(
              message: 'No repositories found for "$_currentQuery"',
            ));
          } else {
            emit(HomeLoaded(
              repositories: List.unmodifiable(_allRepositories),
              hasReachedMax: _hasReachedMax,
              currentPage: _currentPage,
              sortType: _currentSortType,
              query: _currentQuery,
            ));
          }
        },
      );
    } catch (e) {
      emit(HomeError(errorMessage: 'An unexpected error occurred: ${e.toString()}'));
    }
  }
}



