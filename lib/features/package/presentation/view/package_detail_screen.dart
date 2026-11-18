import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nuget_packages/common/theme/image_sources.dart';
import 'package:nuget_packages/l10n/app_localizations.dart';
import '../../domain/i_package_repository.dart';
import '../bloc/detail/package_detail_cubit.dart';
import '../bloc/detail/package_detail_state.dart';

class PackageDetailScreen extends StatelessWidget {
  final String packageId;

  const PackageDetailScreen({Key? key, required this.packageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PackageDetailCubit>(
      create: (context) => PackageDetailCubit(
        context.read<IPackageRepository>(),
      )..fetchPackageDetail(packageId),
      child: PackageDetailView(packageId: packageId),
    );
  }
}

class PackageDetailView extends StatefulWidget {
  final String packageId;

  const PackageDetailView({Key? key, required this.packageId}) : super(key: key);

  @override
  State<PackageDetailView> createState() => _PackageDetailViewState();
}

class _PackageDetailViewState extends State<PackageDetailView> {
  bool _showAllVersions = false;

  void _onHomeClick() {
    context.go('/');
  }

  void _onDependencyClick(String depId) {
    context.push('/package/$depId');
  }

  void _onRetry() {
    context.read<PackageDetailCubit>().fetchPackageDetail(widget.packageId);
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.packageDetails),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/');
            }
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: _onHomeClick,
          ),
        ],
      ),
      body: BlocBuilder<PackageDetailCubit, PackageDetailState>(
        builder: (context, state) {
          return switch (state) {
            PackageDetailLoading() => const Center(child: CircularProgressIndicator()),
            PackageDetailNotFound() => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(loc.nothingFound),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _onHomeClick,
                      child: Text(loc.backToHome),
                    ),
                  ],
                ),
              ),
            PackageDetailError(:final message) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(loc.error(message)),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: _onRetry,
                          child: const Text('Повторить'),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: _onHomeClick,
                          child: Text(loc.backToHome),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            PackageDetailLoaded(:final package) => () {
                final displayedVersions = _showAllVersions
                    ? package.versions
                    : package.versions.take(8).toList();
                final hasMoreVersions = package.versions.length > 8;

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: ImageSources.buildPackageIcon(package.iconUrl, size: 64),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(package.id, style: Theme.of(context).textTheme.headlineMedium),
                                const SizedBox(height: 4),
                                Text(package.version, style: Theme.of(context).textTheme.titleMedium),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      if (package.description != null && package.description!.isNotEmpty) ...[
                        Text(package.description!, style: Theme.of(context).textTheme.bodyLarge),
                        const SizedBox(height: 8),
                      ],
                      const Divider(height: 32),
                      Text(loc.availableVersions, style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: displayedVersions
                            .map((v) => Chip(
                                  label: Text(v.version),
                                  visualDensity: VisualDensity.compact,
                                ))
                            .toList(),
                      ),
                      if (hasMoreVersions) ...[
                        const SizedBox(height: 8),
                        TextButton.icon(
                          onPressed: () {
                            setState(() {
                              _showAllVersions = !_showAllVersions;
                            });
                          },
                          icon: Icon(_showAllVersions ? Icons.expand_less : Icons.expand_more),
                          label: Text(
                            _showAllVersions
                                ? loc.showLessVersions
                                : loc.showAllVersions(package.versions.length),
                          ),
                        ),
                      ],
                      if (package.dependencies.isNotEmpty) ...[
                        const Divider(height: 32),
                        Text(loc.dependencies, style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(height: 8),
                        ...package.dependencies.map((depId) => TextButton(
                              onPressed: () => _onDependencyClick(depId),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(depId),
                              ),
                            )),
                      ],
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _onHomeClick,
                          child: Text(loc.backToHome),
                        ),
                      ),
                    ],
                  ),
                );
              }(),
          };
        },
      ),
    );
  }
}
