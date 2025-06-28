import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/base/widgets/app_subtitle_text.dart';
import 'package:flutter_task/core/base/widgets/app_title_text.dart';
import 'package:flutter_task/core/base/widgets/card.dart';
import 'package:go_router/go_router.dart';
import 'package:on_process_button_widget/on_process_button_widget.dart';
import '../../../../core/base/widgets/base_setting_row.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/values/app_values.dart';
import '../../data/model/pogo_model/Item_model.dart';
import '../bloc/home_bloc.dart';
import '../../../../core/base/widgets/custom_animated_size.dart';
import '../../../../core/base/widgets/custom_text_field_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TextEditingController _searchController;
  late final ScrollController _scrollController;

  Timer? _debounceTimer;
  static const Duration _debounceDuration = Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<HomeBloc>().add(const HomeLoadMoreRepositoriesEvent());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void _onSearchChanged(String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(_debounceDuration, () {
      if (query.trim().isEmpty) {
        context.read<HomeBloc>().add(const HomeClearSearchEvent());
      } else {
        context.read<HomeBloc>().add(
          HomeSearchRepositoriesEvent(query: query.trim()),
        );
      }
    });
  }

  void _showErrorSnackBar(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Retry',
          onPressed: () {
            final query = _searchController.text.trim();
            if (query.isNotEmpty) {
              context.read<HomeBloc>().add(
                HomeSearchRepositoriesEvent(query: query),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GitHub Repositories"),
        elevation: 0,
        actions: [
          const ChangeSetting(),
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return IconButton(
                onPressed:
                    state is HomeLoaded
                        ? () => _showSortBottomSheet(context, state.sortType)
                        : null,
                icon: const Icon(Icons.sort),
                tooltip: 'Sort repositories',
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildSearchInformation(),
          Expanded(child: _buildRepositoryList()),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomTextFormField(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppValues.padding,
          vertical: AppValues.padding / 2,
        ),
        labelText: "Search GitHub repositories...",
        textEditingController: _searchController,
        prefixIcon: const Icon(Icons.search),
        suffixIcon:
            _searchController.text.isNotEmpty
                ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    context.read<HomeBloc>().add(const HomeClearSearchEvent());
                  },
                )
                : null,
        onChanged: _onSearchChanged,
      ),
    );
  }

  Widget _buildSearchInformation() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is! HomeLoaded) {
          return const SizedBox.shrink();
        }

        return CustomAnimatedSize(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppValues.padding,
              vertical: AppValues.padding / 2,
            ),
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.surfaceVariant.withOpacity(0.3),
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).dividerColor,
                  width: 0.5,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 16,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Showing ${state.repositories.length} of ${state.repositories.length} repositories for "${state.query}"',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (state.sortType != SortType.none) ...[
                  const SizedBox(width: 8),
                  Chip(
                    label: Text(
                      _getSortLabel(state.sortType),
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    padding: EdgeInsets.zero,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRepositoryList() {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeError) {
          _showErrorSnackBar(state.errorMessage);
        }
      },
      builder: (context, state) {
        return switch (state) {
          HomeInitial() => _buildWelcomeScreen(),
          HomeLoading() => const Center(child: CircularProgressIndicator()),
          HomeEmpty() => _buildEmptyState(state.message),
          HomeLoaded() => _buildRepositoryListView(state),
          HomeLoadingMore() => _buildRepositoryListView(
            HomeLoaded(
              repositories: state.repositories,
              hasReachedMax: false,
              currentPage: 0,
              sortType: state.sortType,
              query: state.query,
            ),
            showLoadingMore: true,
          ),
          HomeError() => _buildErrorState(state.errorMessage),
        };
      },
    );
  }

  Widget _buildWelcomeScreen() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppValues.padding * 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search,
              size: 64,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'Search GitHub Repositories',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Enter a search term above to find repositories',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppValues.padding * 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              'No Results Found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(String errorMessage) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppValues.padding * 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Something went wrong',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              errorMessage,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                final query = _searchController.text.trim();
                if (query.isNotEmpty) {
                  context.read<HomeBloc>().add(
                    HomeSearchRepositoriesEvent(query: query),
                  );
                }
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRepositoryListView(
    HomeLoaded state, {
    bool showLoadingMore = false,
  }) {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(AppValues.padding / 2),
      itemCount: state.repositories.length + (showLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= state.repositories.length) {
          return const Padding(
            padding: EdgeInsets.all(AppValues.padding),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final repository = state.repositories[index];
        return _buildRepositoryCard(repository);
      },
    );
  }

  Widget _buildRepositoryCard(Item repository) {
    return CustomCard(
      margin: const EdgeInsets.symmetric(
        horizontal: AppValues.padding / 2,
        vertical: AppValues.padding / 4,
      ),
      onTap: () {
        context.goNamed(Routes.repositoryDetail, extra: repository);
      },
      child: Padding(
        padding: const EdgeInsets.all(AppValues.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  repository.name ?? "Unknown Repository",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                if (repository.stargazersCount != null) ...[
                  const SizedBox(width: 8),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star, size: 16, color: Colors.amber[600]),
                      const SizedBox(width: 4),
                      Text(
                        _formatCount(repository.stargazersCount!),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ],
            ),

            if (repository.description != null) ...[
              const SizedBox(height: 8),
              Text(
                repository.description!,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            const SizedBox(height: 8),
            Row(
              children: [
                if (repository.language != null) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      repository.language!,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showSortBottomSheet(BuildContext context, SortType currentSort) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppValues.padding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TitleText("Sort By"),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildSortOptions(context, currentSort),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSortOptions(BuildContext context, SortType currentSort) {
    final sortOptions = [
      {"label": "Best Match", "type": SortType.none},
      {"label": "Most Stars", "type": SortType.stars},
      {"label": "Recently Updated", "type": SortType.dateTime},
    ];

    return Column(
      children:
          sortOptions.map((option) {
            final sortType = option["type"] as SortType;
            final isSelected = currentSort == sortType;

            return Padding(
              padding: const EdgeInsets.only(bottom: AppValues.padding / 2),
              child: OnProcessButtonWidget(
                backgroundColor:
                    isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.surfaceVariant,
                onTap: () async {
                  if (!isSelected) {
                    context.read<HomeBloc>().add(
                      HomeSortRepositoriesEvent(sortType: sortType),
                    );
                  }
                  Navigator.pop(context);
                  return true;
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SubtitleText(
                      option["label"] as String,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color:
                            isSelected
                                ? Theme.of(context).colorScheme.onPrimary
                                : Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    if (isSelected)
                      Icon(
                        Icons.check,
                        color: Theme.of(context).colorScheme.onPrimary,
                        size: 20,
                      ),
                  ],
                ),
              ),
            );
          }).toList(),
    );
  }

  String _getSortLabel(SortType sortType) {
    switch (sortType) {
      case SortType.none:
        return 'Best Match';
      case SortType.stars:
        return 'Most Stars';
      case SortType.dateTime:
        return 'Recently Updated';
    }
  }

  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return count.toString();
  }
}
