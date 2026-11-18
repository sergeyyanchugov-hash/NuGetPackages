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
  final bool hasMore;
  final bool isLoadingMore;

  const PackageListLoaded(
    this.packages,
    this.query, {
    this.hasMore = true,
    this.isLoadingMore = false,
  });

  PackageListLoaded copyWith({
    List<PackageModel>? packages,
    String? query,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return PackageListLoaded(
      packages ?? this.packages,
      query ?? this.query,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [packages, query, hasMore, isLoadingMore];
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
