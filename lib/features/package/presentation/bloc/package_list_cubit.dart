import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/models/package_dto.dart';
import '../../data/package_repository.dart';

abstract class PackageListState extends Equatable {
  const PackageListState();

  @override
  List<Object?> get props => [];
}

class PackageListLoading extends PackageListState {}

class PackageListLoaded extends PackageListState {
  final List<PackageDto> packages;
  final String query;

  const PackageListLoaded(this.packages, this.query);

  @override
  List<Object?> get props => [packages, query];
}

class PackageListError extends PackageListState {
  final String message;

  const PackageListError(this.message);

  @override
  List<Object?> get props => [message];
}

class PackageListCubit extends Cubit<PackageListState> {
  final MockPackageRepository repository;
  String currentQuery = '';

  PackageListCubit(this.repository) : super(PackageListLoading());

  void fetchPackages([String query = '']) async {
    currentQuery = query;
    emit(PackageListLoading());
    try {
      final packages = await repository.getPackages(query);
      emit(PackageListLoaded(packages, query));
    } catch (e) {
      emit(PackageListError(e.toString()));
    }
  }

  void clearSearch() {
    fetchPackages('');
  }
}
