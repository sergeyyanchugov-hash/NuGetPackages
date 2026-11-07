import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nuget_packages/common/theme/app_colors.dart';
import 'package:nuget_packages/common/theme/image_sources.dart';
import 'package:nuget_packages/l10n/app_localizations.dart';
import '../bloc/list/package_list_cubit.dart';
import '../bloc/list/package_list_state.dart';
import '../bloc/theme/theme_cubit.dart';
import '../bloc/locale/locale_cubit.dart';

class PackageListScreen extends StatefulWidget {
  const PackageListScreen({Key? key}) : super(key: key);

  @override
  State<PackageListScreen> createState() => _PackageListScreenState();
}

class _PackageListScreenState extends State<PackageListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<PackageListCubit>().fetchPackages("");
  }

  void _onClearSearch() {
    _searchController.clear();
    context.read<PackageListCubit>().clearSearch();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              context.read<LocaleCubit>().toggleLocale();
            },
          ),
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              context.read<ThemeCubit>().toggleTheme();
            },
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<PackageListCubit, PackageListState>(
              builder: (context, state) {
                final hasQuery = (state is PackageListLoaded && state.query.isNotEmpty) ||
                    (state is PackageListEmpty && state.query.isNotEmpty);
                return TextField(
                  controller: _searchController,
                  onChanged: (val) => context.read<PackageListCubit>().fetchPackages(val),
                  decoration: InputDecoration(
                    hintText: loc.searchHint,
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: hasQuery
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: _onClearSearch,
                          )
                        : null,
                    border: const OutlineInputBorder(),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<PackageListCubit, PackageListState>(
              builder: (context, state) {
                return switch (state) {
                  PackageListLoading() => const Center(child: CircularProgressIndicator()),
                  PackageListError(:final message) => Center(child: Text(loc.error(message))),
                  PackageListEmpty(:final query) => Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.info, size: 64, color: AppColors.iconVariant),
                          const SizedBox(height: 16),
                          Text(loc.nothingFound, style: const TextStyle(fontSize: 20)),
                          const SizedBox(height: 8),
                          Text(loc.nothingFoundFor(query)),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: _onClearSearch,
                            child: Text(loc.resetSearch),
                          ),
                        ],
                      ),
                    ),
                  PackageListLoaded(:final packages) => ListView.builder(
                      itemCount: packages.length,
                      itemBuilder: (context, index) {
                        final pkg = packages[index];
                        final iconPath = ImageSources.getPackageIcon(pkg.iconUrl);
                        return ListTile(
                          leading: iconPath.isNotEmpty
                              ? Image.asset(
                                  iconPath,
                                  width: 48,
                                  height: 48,
                                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.extension, size: 48),
                                )
                              : const Icon(Icons.extension, size: 48),
                          title: Text(pkg.id),
                          subtitle: pkg.description != null ? Text(pkg.description!, maxLines: 2, overflow: TextOverflow.ellipsis) : null,
                          onTap: () {
                            context.push('/package/${pkg.id}');
                          },
                        );
                      },
                    ),
                };
              },
            ),
          ),
        ],
      ),
    );
  }
}
