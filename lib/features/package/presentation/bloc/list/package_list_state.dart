import 'package:equatable/equatable.dart';
import '../../../domain/package_model.dart';

sealed class PackageListState extends Equatable {
  const PackageListState();

  @override
  List<Object?> get props => [];
}

final class PackageListLoading extends PackageListState {}

final class PackageListLoaded extends PackageListState {
  final List<PackageModel> packages;
  final String query;

  const PackageListLoaded(this.packages, this.query);

  @override
  List<Object?> get props => [packages, query];
}

final class PackageListEmpty extends PackageListState {
  final String query;

  const PackageListEmpty(this.query);

  @override
  List<Object?> get props => [query];
}

final class PackageListError extends PackageListState {
  final String message;

  const PackageListError(this.message);

  @override
  List<Object?> get props => [message];
}
