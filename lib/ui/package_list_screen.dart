import 'package:flutter/material.dart';
import '../models/package_dto.dart';
import '../repository/package_repository.dart';
import 'ui_state.dart';
import 'package_detail_screen.dart';

class PackageListScreen extends StatefulWidget {
  const PackageListScreen({Key? key}) : super(key: key);

  @override
  State<PackageListScreen> createState() => _PackageListScreenState();
}

class _PackageListScreenState extends State<PackageListScreen> {
  final MockPackageRepository _repository = MockPackageRepository();
  final TextEditingController _searchController = TextEditingController();
  
  UiState<List<PackageDto>> _uiState = UiStateLoading();

  @override
  void initState() {
    super.initState();
    _fetchPackages("");
  }

  void _fetchPackages(String query) async {
    setState(() {
      _uiState = UiStateLoading();
    });
    try {
      final packages = await _repository.getPackages(query);
      setState(() {
        _uiState = UiStateSuccess(packages);
      });
    } catch (e) {
      setState(() {
        _uiState = UiStateError(e.toString());
      });
    }
  }

  void _onClearSearch() {
    _searchController.clear();
    _fetchPackages("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('.NET Packages'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: _fetchPackages,
              decoration: InputDecoration(
                hintText: 'Search packages...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: _onClearSearch,
                      )
                    : null,
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (_uiState is UiStateLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (_uiState is UiStateError) {
      final error = (_uiState as UiStateError).message;
      return Center(child: Text("Error: $error"));
    } else if (_uiState is UiStateSuccess) {
      final packages = (_uiState as UiStateSuccess<List<PackageDto>>).data;
      if (packages.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.info, size: 64, color: Colors.grey),
              const SizedBox(height: 16),
              const Text("Ничего не найдено", style: TextStyle(fontSize: 20)),
              const SizedBox(height: 8),
              Text("По запросу «${_searchController.text}» ничего не найдено"),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _onClearSearch,
                child: const Text("Сбросить поиск"),
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PackageDetailScreen(packageId: pkg.id),
                ),
              );
            },
          );
        },
      );
    }
    return const SizedBox.shrink();
  }
}
