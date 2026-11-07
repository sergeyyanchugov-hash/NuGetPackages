import 'package:equatable/equatable.dart';
import '../../../domain/package_model.dart';

sealed class PackageDetailState extends Equatable {
  const PackageDetailState();

  @override
  List<Object?> get props => [];
}

final class PackageDetailLoading extends PackageDetailState {}

final class PackageDetailLoaded extends PackageDetailState {
  final PackageModel package;

  const PackageDetailLoaded(this.package);

  @override
  List<Object?> get props => [package];
}

final class PackageDetailError extends PackageDetailState {
  final String message;

  const PackageDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
