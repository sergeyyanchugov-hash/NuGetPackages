import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/i_package_repository.dart';
import 'package_list_state.dart';

class PackageListCubit extends Cubit<PackageListState> {
  final IPackageRepository _repository;
  String currentQuery = '';

  PackageListCubit(this._repository) : super(PackageListLoading());

  void fetchPackages([String query = '']) async {
    currentQuery = query;
    if (isClosed) return;
    emit(PackageListLoading());
    try {
      final packages = await _repository.getPackages(query);
      if (isClosed || currentQuery != query) return;
      if (packages.isEmpty) {
        emit(PackageListEmpty(query));
      } else {
        emit(PackageListLoaded(packages, query));
      }
    } catch (e) {
      if (!isClosed && currentQuery == query) {
        emit(PackageListError(e.toString()));
      }
    }
  }

  void clearSearch() {
    fetchPackages('');
  }
}
