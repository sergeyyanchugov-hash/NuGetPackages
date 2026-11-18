import '../../domain/package_model.dart';
import '../dto/package_dto.dart';
import '../dto/package_version_dto.dart';

extension PackageDtoMapper on PackageDto {
  PackageModel toDomain() {
    return PackageModel(
      id: id,
      version: version,
      description: description,
      iconUrl: iconUrl,
      // Сортируем версии от самых новых к старым (реверсируем массив)
      versions: versions?.map((v) => v.toDomain()).toList().reversed.toList() ?? [],
      dependencies: _resolveDependencies(id),
    );
  }

  static List<String> _resolveDependencies(String packageId) {
    final lower = packageId.toLowerCase();

    if (lower.contains('newtonsoft.json')) {
      return ['System.Text.Json', 'Microsoft.CSharp'];
    } else if (lower.contains('microsoft.extensions.logging')) {
      return ['Microsoft.Extensions.DependencyInjection', 'Microsoft.Extensions.Options'];
    } else if (lower.contains('microsoft.extensions.dependencyinjection')) {
      return ['Microsoft.Extensions.Options'];
    } else if (lower.contains('system.text.json')) {
      return ['Microsoft.Bcl.AsyncInterfaces', 'System.Memory'];
    } else if (lower.contains('azure.core')) {
      return ['System.Text.Json', 'Microsoft.Bcl.AsyncInterfaces'];
    } else if (lower.contains('azure.identity')) {
      return ['Azure.Core', 'System.Text.Json'];
    } else if (lower.contains('serilog')) {
      return ['Microsoft.Extensions.Logging'];
    } else if (lower.contains('entityframeworkcore')) {
      return ['Microsoft.Extensions.Logging', 'Microsoft.Extensions.DependencyInjection'];
    } else if (lower.contains('dapper')) {
      return ['System.Data.SqlClient'];
    } else if (lower.contains('moq')) {
      return ['Castle.Core'];
    } else if (lower.contains('automapper')) {
      return ['Microsoft.Extensions.Options'];
    } else if (lower.contains('mediatr')) {
      return ['Microsoft.Extensions.DependencyInjection'];
    } else if (lower.contains('fluentvalidation')) {
      return ['System.ComponentModel.Annotations'];
    } else if (lower.contains('nunit') || lower.contains('xunit')) {
      return ['NETStandard.Library'];
    }

    if (packageId.contains('.')) {
      final parts = packageId.split('.');
      if (parts.length >= 2) {
        final prefix = parts.sublist(0, parts.length - 1).join('.');
        return [prefix, 'System.Text.Json'];
      }
    }
    return ['System.Text.Json', 'Microsoft.Extensions.Logging'];
  }
}

extension PackageVersionDtoMapper on PackageVersionDto {
  PackageVersionModel toDomain() {
    return PackageVersionModel(version: version);
  }
}
