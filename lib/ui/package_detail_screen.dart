import 'package:flutter/material.dart';
import '../models/package_dto.dart';
import '../repository/package_repository.dart';
import 'ui_state.dart';

class PackageDetailScreen extends StatefulWidget {
  final String packageId;

  const PackageDetailScreen({Key? key, required this.packageId}) : super(key: key);

  @override
  State<PackageDetailScreen> createState() => _PackageDetailScreenState();
}

class _PackageDetailScreenState extends State<PackageDetailScreen> {
  final MockPackageRepository _repository = MockPackageRepository();
  UiState<PackageDto> _uiState = UiStateLoading();

  @override
  void initState() {
    super.initState();
    _fetchPackageDetail();
  }

  void _fetchPackageDetail() async {
    setState(() {
      _uiState = UiStateLoading();
    });
    try {
      final pkg = await _repository.getPackageDetail(widget.packageId);
      if (pkg != null) {
        setState(() {
          _uiState = UiStateSuccess(pkg);
        });
      } else {
        setState(() {
          _uiState = UiStateError("Package not found");
        });
      }
    } catch (e) {
      setState(() {
        _uiState = UiStateError(e.toString());
      });
    }
  }

  void _onHomeClick() {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  void _onDependencyClick(String depId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PackageDetailScreen(packageId: depId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Детали пакета'),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: _onHomeClick,
          ),
        ],
      ),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    if (_uiState is UiStateLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (_uiState is UiStateError) {
      final error = (_uiState as UiStateError).message;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Ошибка: $error"),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _onHomeClick,
              child: const Text("На главную"),
            ),
          ],
        ),
      );
    } else if (_uiState is UiStateSuccess) {
      final pkg = (_uiState as UiStateSuccess<PackageDto>).data;
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
            Text("Доступные версии", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            ...pkg.versions.map((v) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(v.version),
                )),
            const Divider(height: 32),
            Text("Зависимости", style: Theme.of(context).textTheme.titleLarge),
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
                child: const Text("Вернуться на главный экран"),
              ),
            ),
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
