import '../models/package_dto.dart';

class MockPackageRepository {
  Future<List<PackageDto>> getPackages(String query) async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network
    final trimmed = query.trim().toLowerCase();
    if (trimmed.isEmpty) return allPackages;
    
    return allPackages.where((pkg) {
      return pkg.id.toLowerCase().contains(trimmed) ||
          (pkg.description?.toLowerCase().contains(trimmed) ?? false);
    }).toList();
  }

  Future<PackageDto?> getPackageDetail(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      return allPackages.firstWhere((pkg) => pkg.id.toLowerCase() == id.toLowerCase());
    } catch (e) {
      return null;
    }
  }

  static final List<PackageDto> allPackages = [
    PackageDto(
      id: "Newtonsoft.Json",
      version: "13.0.3",
      description: "Popular high-performance JSON framework for .NET",
      versions: [PackageVersionDto(version: "13.0.3"), PackageVersionDto(version: "13.0.2"), PackageVersionDto(version: "13.0.1")],
      dependencies: ["System.Text.Json", "Microsoft.CSharp"],
    ),
    PackageDto(
      id: "Serilog",
      version: "4.0.1",
      description: "Simple .NET logging with fully-structured events",
      versions: [PackageVersionDto(version: "4.0.1"), PackageVersionDto(version: "4.0.0"), PackageVersionDto(version: "3.1.1")],
      dependencies: ["Microsoft.Extensions.Logging"],
    ),
    PackageDto(
      id: "AutoMapper",
      version: "13.0.1",
      description: "A convention-based object-object mapper in .NET",
      versions: [PackageVersionDto(version: "13.0.1"), PackageVersionDto(version: "12.0.1")],
      dependencies: ["Microsoft.Extensions.Options"],
    ),
    PackageDto(
      id: "Dapper",
      version: "2.1.35",
      description: "High performance Micro-ORM for ADO.NET",
      versions: [PackageVersionDto(version: "2.1.35"), PackageVersionDto(version: "2.0.123")],
      dependencies: ["System.Data.SqlClient"],
    ),
    PackageDto(
      id: "Moq",
      version: "4.20.72",
      description: "Popular and friendly mocking framework for .NET",
      versions: [PackageVersionDto(version: "4.20.72"), PackageVersionDto(version: "4.18.4")],
      dependencies: ["Castle.Core"],
    ),
    PackageDto(
      id: "NUnit",
      version: "4.2.2",
      description: "Unit testing framework for all .NET languages",
      versions: [PackageVersionDto(version: "4.2.2"), PackageVersionDto(version: "4.1.0")],
      dependencies: ["NETStandard.Library"],
    ),
    PackageDto(
      id: "xunit",
      version: "2.9.0",
      description: "Free, open source, community-focused unit testing tool for .NET",
      versions: [PackageVersionDto(version: "2.9.0"), PackageVersionDto(version: "2.8.1")],
      dependencies: ["xunit.core", "xunit.assert"],
    ),
    PackageDto(
      id: "FluentValidation",
      version: "11.10.0",
      description: "A popular .NET validation library for building strongly-typed validation rules",
      versions: [PackageVersionDto(version: "11.10.0"), PackageVersionDto(version: "11.9.2")],
      dependencies: ["System.ComponentModel.Annotations"],
    ),
    PackageDto(
      id: "MediatR",
      version: "12.4.1",
      description: "Simple, unambitious mediator implementation in .NET",
      versions: [PackageVersionDto(version: "12.4.1"), PackageVersionDto(version: "12.3.0")],
      dependencies: ["Microsoft.Extensions.DependencyInjection.Abstractions"],
    ),
    PackageDto(
      id: "Polly",
      version: "8.4.2",
      description: "Polly is a .NET resilience and transient-fault-handling library",
      versions: [PackageVersionDto(version: "8.4.2"), PackageVersionDto(version: "8.3.1")],
      dependencies: ["Polly.Core"],
    ),
    PackageDto(
      id: "Refit",
      version: "7.2.1",
      description: "The automatic type-safe REST library for .NET",
      versions: [PackageVersionDto(version: "7.2.1"), PackageVersionDto(version: "7.0.0")],
      dependencies: ["System.Text.Json"],
    ),
    PackageDto(
      id: "RestSharp",
      version: "112.1.0",
      description: "Simple REST and HTTP API Client for .NET",
      versions: [PackageVersionDto(version: "112.1.0"), PackageVersionDto(version: "111.4.1")],
      dependencies: ["System.Text.Json"],
    ),
    PackageDto(
      id: "BenchmarkDotNet",
      version: "0.14.0",
      description: "Powerful .NET library for benchmarking",
      versions: [PackageVersionDto(version: "0.14.0"), PackageVersionDto(version: "0.13.12")],
      dependencies: ["System.Management"],
    ),
    PackageDto(
      id: "Microsoft.EntityFrameworkCore",
      version: "8.0.8",
      description: "Entity Framework Core is a modern object-database mapper for .NET",
      versions: [PackageVersionDto(version: "8.0.8"), PackageVersionDto(version: "8.0.7")],
      dependencies: ["Microsoft.EntityFrameworkCore.Abstractions"],
    ),
    PackageDto(
      id: "Microsoft.Extensions.Logging",
      version: "8.0.0",
      description: "Logging infrastructure default interfaces for .NET",
      versions: [PackageVersionDto(version: "8.0.0"), PackageVersionDto(version: "7.0.0")],
      dependencies: ["Microsoft.Extensions.DependencyInjection.Abstractions"],
    ),
    PackageDto(
      id: "Microsoft.Extensions.DependencyInjection",
      version: "8.0.0",
      description: "Default dependency injection container implementation for .NET",
      versions: [PackageVersionDto(version: "8.0.0"), PackageVersionDto(version: "7.0.0")],
      dependencies: ["Microsoft.Extensions.DependencyInjection.Abstractions"],
    ),
    PackageDto(
      id: "System.Text.Json",
      version: "8.0.4",
      description: "Provides high-performance and low-allocating JSON features for .NET",
      versions: [PackageVersionDto(version: "8.0.4"), PackageVersionDto(version: "8.0.0")],
      dependencies: ["System.Runtime.CompilerServices.Unsafe"],
    ),
    PackageDto(
      id: "Grpc.Net.Client",
      version: "2.66.0",
      description: "gRPC client library for .NET",
      versions: [PackageVersionDto(version: "2.66.0"), PackageVersionDto(version: "2.65.0")],
      dependencies: ["Grpc.Core.Api"],
    ),
    PackageDto(
      id: "Swashbuckle.AspNetCore",
      version: "6.8.1",
      description: "Swagger tools for documenting APIs built on ASP.NET Core",
      versions: [PackageVersionDto(version: "6.8.1"), PackageVersionDto(version: "6.7.0")],
      dependencies: ["Microsoft.AspNetCore.Mvc.ApiExplorer"],
    ),
    PackageDto(
      id: "Humanizer",
      version: "2.14.1",
      description: "Humanizer meets all your .NET needs for manipulating and formatting strings, enums, dates, times, timespans, numbers and quantities",
      versions: [PackageVersionDto(version: "2.14.1"), PackageVersionDto(version: "2.13.0")],
      dependencies: ["Humanizer.Core"],
    ),
    PackageDto(
      id: "MassTransit",
      version: "8.2.5",
      description: "Distributed Application Framework for .NET",
      versions: [PackageVersionDto(version: "8.2.5"), PackageVersionDto(version: "8.1.3")],
      dependencies: ["MassTransit.Abstractions"],
    ),
    PackageDto(
      id: "Quartz",
      version: "3.13.0",
      description: "Quartz.NET is a full-featured, open source job scheduling system for .NET",
      versions: [PackageVersionDto(version: "3.13.0"), PackageVersionDto(version: "3.12.0")],
      dependencies: ["Microsoft.Extensions.Logging.Abstractions"],
    )
  ];
}
