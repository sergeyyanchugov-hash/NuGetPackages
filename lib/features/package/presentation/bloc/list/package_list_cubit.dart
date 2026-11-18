import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/i_package_repository.dart';
import 'package_list_state.dart';

class PackageListCubit extends Cubit<PackageListState> {
  final IPackageRepository _repository;
  String currentQuery = '';
  static const int _pageSize = 20;

  PackageListCubit(this._repository) : super(PackageListLoading());

  void fetchPackages([String query = '']) async {
    currentQuery = query;
    if (isClosed) return;
    emit(PackageListLoading());
    try {
      final packages = await _repository.getPackages(query, skip: 0, take: _pageSize);
      if (isClosed || currentQuery != query) return;
      if (packages.isEmpty) {
        emit(PackageListEmpty(query));
      } else {
        emit(PackageListLoaded(
          packages,
          query,
          hasMore: packages.length >= _pageSize,
        ));
      }
    } catch (e) {
      if (!isClosed && currentQuery == query) {
        emit(PackageListError(e.toString()));
      }
    }
  }

  void loadMorePackages() async {
    final currentState = state;
    if (currentState is! PackageListLoaded || currentState.isLoadingMore || !currentState.hasMore) {
      return;
    }

    emit(currentState.copyWith(isLoadingMore: true));

    try {
      final nextPackages = await _repository.getPackages(
        currentQuery,
        skip: currentState.packages.length,
        take: _pageSize,
      );

      if (isClosed) return;

      if (nextPackages.isEmpty) {
        emit(currentState.copyWith(hasMore: false, isLoadingMore: false));
      } else {
        final existingIds = currentState.packages.map((p) => p.id).toSet();
        final filteredNext = nextPackages.where((p) => !existingIds.contains(p.id)).toList();

        emit(PackageListLoaded(
          [...currentState.packages, ...filteredNext],
          currentQuery,
          hasMore: nextPackages.length >= _pageSize,
          isLoadingMore: false,
        ));
      }
    } catch (e) {
      if (!isClosed) {
        emit(currentState.copyWith(isLoadingMore: false));
      }
    }
  }

  void clearSearch() {
    fetchPackages('');
  }
}
