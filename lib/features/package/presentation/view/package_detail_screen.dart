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
      child: const _PackageDetailView(),
    );
  }
}

class _PackageDetailView extends StatelessWidget {
  const _PackageDetailView({Key? key}) : super(key: key);

  void _onHomeClick(BuildContext context) {
    context.go('/');
  }

  void _onDependencyClick(BuildContext context, String depId) {
    context.push('/package/$depId');
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
            onPressed: () => _onHomeClick(context),
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
                      onPressed: () => _onHomeClick(context),
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
                    ElevatedButton(
                      onPressed: () => _onHomeClick(context),
                      child: Text(loc.backToHome),
                    ),
                  ],
                ),
              ),
            PackageDetailLoaded(:final package) => () {
                final iconPath = ImageSources.getPackageIcon(package.iconUrl);
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (iconPath.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Image.asset(
                                iconPath,
                                width: 64,
                                height: 64,
                                errorBuilder: (context, error, stackTrace) => const Icon(Icons.extension, size: 64),
                              ),
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
                      ...package.versions.map((v) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(v.version),
                          )),
                      const Divider(height: 32),
                      Text(loc.dependencies, style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 8),
                      ...package.dependencies.map((depId) => TextButton(
                            onPressed: () => _onDependencyClick(context, depId),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(depId),
                            ),
                          )),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => _onHomeClick(context),
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
