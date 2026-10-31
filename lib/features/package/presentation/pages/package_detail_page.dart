import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../bloc/package_detail_cubit.dart';

class PackageDetailPage extends StatefulWidget {
  final String packageId;

  const PackageDetailPage({Key? key, required this.packageId}) : super(key: key);

  @override
  State<PackageDetailPage> createState() => _PackageDetailPageState();
}

class _PackageDetailPageState extends State<PackageDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<PackageDetailCubit>().fetchPackageDetail(widget.packageId);
  }
  
  @override
  void didUpdateWidget(covariant PackageDetailPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.packageId != widget.packageId) {
      context.read<PackageDetailCubit>().fetchPackageDetail(widget.packageId);
    }
  }

  void _onHomeClick() {
    context.go('/');
  }

  void _onDependencyClick(String depId) {
    context.push('/package/$depId');
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.packageDetails),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: _onHomeClick,
          ),
        ],
      ),
      body: BlocBuilder<PackageDetailCubit, PackageDetailState>(
        builder: (context, state) {
          if (state is PackageDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PackageDetailError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(loc.error(state.message)),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _onHomeClick,
                    child: Text(loc.backToHome),
                  ),
                ],
              ),
            );
          } else if (state is PackageDetailLoaded) {
            final pkg = state.package;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(pkg.id, style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 4),
                  Text(pkg.version, style: Theme.of(context).textTheme.titleMedium),
                  if (pkg.description != null && pkg.description!.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(pkg.description!, style: Theme.of(context).textTheme.bodyLarge),
                  ],
                  const Divider(height: 32),
                  Text(loc.availableVersions, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  ...pkg.versions.map((v) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(v.version),
                      )),
                  const Divider(height: 32),
                  Text(loc.dependencies, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  ...pkg.dependencies.map((depId) => TextButton(
                        onPressed: () => _onDependencyClick(depId),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(depId),
                        ),
                      )),
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
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
