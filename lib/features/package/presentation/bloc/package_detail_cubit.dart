import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/models/package_dto.dart';
import '../../data/package_repository.dart';

abstract class PackageDetailState extends Equatable {
  const PackageDetailState();

  @override
  List<Object?> get props => [];
}

class PackageDetailLoading extends PackageDetailState {}

class PackageDetailLoaded extends PackageDetailState {
  final PackageDto package;

  const PackageDetailLoaded(this.package);

  @override
  List<Object?> get props => [package];
}

class PackageDetailError extends PackageDetailState {
  final String message;

  const PackageDetailError(this.message);

  @override
  List<Object?> get props => [message];
}

class PackageDetailCubit extends Cubit<PackageDetailState> {
  final MockPackageRepository repository;

  PackageDetailCubit(this.repository) : super(PackageDetailLoading());

  void fetchPackageDetail(String id) async {
    emit(PackageDetailLoading());
    try {
      final pkg = await repository.getPackageDetail(id);
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
