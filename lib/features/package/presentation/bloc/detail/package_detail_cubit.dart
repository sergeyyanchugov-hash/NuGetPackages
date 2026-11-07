import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/i_package_repository.dart';
import 'package_detail_state.dart';

class PackageDetailCubit extends Cubit<PackageDetailState> {
  final IPackageRepository _repository;

  PackageDetailCubit(this._repository) : super(PackageDetailLoading());

  void fetchPackageDetail(String id) async {
    if (isClosed) return;
    emit(PackageDetailLoading());
    try {
      final pkg = await _repository.getPackageDetail(id);
      if (isClosed) return;
      if (pkg != null) {
        emit(PackageDetailLoaded(pkg));
      } else {
        emit(const PackageDetailNotFound());
      }
    } catch (e) {
      if (!isClosed) {
        emit(PackageDetailError(e.toString()));
      }
    }
  }
}
