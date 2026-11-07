import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/i_package_repository.dart';
import 'package_detail_state.dart';

class PackageDetailCubit extends Cubit<PackageDetailState> {
  final IPackageRepository _repository;

  PackageDetailCubit(this._repository) : super(PackageDetailLoading());

  void fetchPackageDetail(String id) async {
    emit(PackageDetailLoading());
    try {
      final pkg = await _repository.getPackageDetail(id);
      if (pkg != null) {
        emit(PackageDetailLoaded(pkg));
      } else {
        emit(const PackageDetailError("Package not found"));
      }
    } catch (e) {
      emit(PackageDetailError(e.toString()));
    }
  }
}
