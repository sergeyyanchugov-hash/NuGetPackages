import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nuget_packages/l10n/app_localizations.dart';
import '../bloc/package_list_cubit.dart';
import '../bloc/theme_cubit.dart';

class PackageListPage extends StatefulWidget {
  const PackageListPage({Key? key}) : super(key: key);

  @override
  State<PackageListPage> createState() => _PackageListPageState();
}

class _PackageListPageState extends State<PackageListPage> {
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
                final hasQuery = state is PackageListLoaded && state.query.isNotEmpty;
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
                if (state is PackageListLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is PackageListError) {
                  return Center(child: Text(loc.error(state.message)));
                } else if (state is PackageListLoaded) {
                  final packages = state.packages;
                  if (packages.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.info, size: 64, color: Colors.grey),
                          const SizedBox(height: 16),
                          Text(loc.nothingFound, style: const TextStyle(fontSize: 20)),
                          const SizedBox(height: 8),
                          Text(loc.nothingFoundFor(state.query)),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: _onClearSearch,
                            child: Text(loc.resetSearch),
                          ),
                        ],
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: packages.length,
                    itemBuilder: (context, index) {
                      final pkg = packages[index];
                      return ListTile(
                        title: Text(pkg.id),
                        subtitle: pkg.description != null ? Text(pkg.description!, maxLines: 2, overflow: TextOverflow.ellipsis) : null,
                        onTap: () {
                          context.go('/package/${pkg.id}');
                        },
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
