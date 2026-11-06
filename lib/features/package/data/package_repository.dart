import '../domain/models/package_dto.dart';

class MockPackageRepository {
  Future<List<PackageDto>> getPackages(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final trimmed = query.trim().toLowerCase();
    if (trimmed.isEmpty) return allPackages;
    
    return allPackages.where((pkg) {
      return pkg.id.toLowerCase().contains(trimmed) ||
          (pkg.description?.toLowerCase().contains(trimmed) ?? false);
    }).toList();
  }

  Future<PackageDto?> getPackageDetail(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      return allPackages.firstWhere((pkg) => pkg.id.toLowerCase() == id.toLowerCase());
    } catch (e) {
      return null;
    }
  }

  static final List<PackageDto> allPackages = [
    PackageDto(
      id: "Newtonsoft.Json",
      version: "13.0.4",
      description: "Json.NET is a popular high-performance JSON framework for .NET",
      iconUrl: "assets/images/ic_newtonsoft_json.png",
      versions: [PackageVersionDto(version: "3.5.8"), PackageVersionDto(version: "4.0.1"), PackageVersionDto(version: "4.0.2"), PackageVersionDto(version: "4.0.3"), PackageVersionDto(version: "4.0.4"), PackageVersionDto(version: "4.0.5")],
      dependencies: [],
    ),
    PackageDto(
      id: "Microsoft.Extensions.DependencyInjection",
      version: "10.0.14",
      description: "Default implementation of dependency injection for Microsoft.Extensions.DependencyInjection.",
      iconUrl: "assets/images/ic_microsoft_extensions_dependencyinjection.png",
      versions: [PackageVersionDto(version: "1.0.0"), PackageVersionDto(version: "1.0.1"), PackageVersionDto(version: "1.0.2"), PackageVersionDto(version: "1.1.0"), PackageVersionDto(version: "1.1.1"), PackageVersionDto(version: "2.0.0")],
      dependencies: [],
    ),
    PackageDto(
      id: "Microsoft.Extensions.Logging",
      version: "10.0.14",
      description: "Logging infrastructure default implementation for Microsoft.Extensions.Logging.",
      iconUrl: "assets/images/ic_microsoft_extensions_logging.png",
      versions: [PackageVersionDto(version: "1.0.0"), PackageVersionDto(version: "1.0.1"), PackageVersionDto(version: "1.0.2"), PackageVersionDto(version: "1.1.0"), PackageVersionDto(version: "1.1.1"), PackageVersionDto(version: "1.1.2")],
      dependencies: ["Microsoft.Extensions.DependencyInjection"],
    ),
    PackageDto(
      id: "System.Text.Json",
      version: "10.0.14",
      description: "Provides high-performance and low-allocating types that serialize objects to JavaScript Object Notation (JSON) text and deserialize JSON text to objects, with UTF-8 support built-in. Also provides types to read and write JSON text encoded as UTF-8, and to create an in-memory document object model (DOM), that is read-only, for random access of the JSON elements within a structured view of the data.  The System.Text.Json library is built-in as part of the shared framework in .NET Runtime. The package can be installed when you need to use it in other target frameworks.",
      iconUrl: "assets/images/ic_system_text_json.png",
      versions: [PackageVersionDto(version: "4.6.0"), PackageVersionDto(version: "4.7.0"), PackageVersionDto(version: "4.7.1"), PackageVersionDto(version: "4.7.2"), PackageVersionDto(version: "5.0.0"), PackageVersionDto(version: "5.0.1")],
      dependencies: ["Microsoft.Bcl.AsyncInterfaces"],
    ),
    PackageDto(
      id: "Microsoft.Bcl.AsyncInterfaces",
      version: "10.0.14",
      description: "Provides the IAsyncEnumerable<T> and IAsyncDisposable interfaces and helper types for .NET Standard 2.0. This package is not required starting with .NET Standard 2.1 and .NET Core 3.0.",
      iconUrl: "assets/images/ic_microsoft_bcl_asyncinterfaces.png",
      versions: [PackageVersionDto(version: "1.0.0"), PackageVersionDto(version: "1.1.0"), PackageVersionDto(version: "1.1.1"), PackageVersionDto(version: "5.0.0"), PackageVersionDto(version: "6.0.0"), PackageVersionDto(version: "7.0.0")],
      dependencies: [],
    ),
    PackageDto(
      id: "Azure.Core",
      version: "1.64.0",
      description: "This is the implementation of the Azure Client Pipeline",
      iconUrl: "assets/images/ic_azure_core.png",
      versions: [PackageVersionDto(version: "1.0.0"), PackageVersionDto(version: "1.0.1"), PackageVersionDto(version: "1.0.2"), PackageVersionDto(version: "1.1.0"), PackageVersionDto(version: "1.2.0"), PackageVersionDto(version: "1.2.1")],
      dependencies: ["System.Text.Json", "Microsoft.Bcl.AsyncInterfaces"],
    ),
    PackageDto(
      id: "Serilog",
      version: "4.4.0",
      description: "Simple .NET logging with fully-structured events",
      iconUrl: "assets/images/ic_serilog.png",
      versions: [PackageVersionDto(version: "0.1.6"), PackageVersionDto(version: "0.1.7"), PackageVersionDto(version: "0.1.8"), PackageVersionDto(version: "0.1.9"), PackageVersionDto(version: "0.1.10"), PackageVersionDto(version: "0.1.11")],
      dependencies: ["Microsoft.Extensions.Logging"],
    ),
    PackageDto(
      id: "Microsoft.IdentityModel.Abstractions",
      version: "8.23.0",
      description: "A package containing thin abstractions for Microsoft.IdentityModel.",
      iconUrl: null,
      versions: [PackageVersionDto(version: "6.18.0"), PackageVersionDto(version: "6.19.0"), PackageVersionDto(version: "6.20.0"), PackageVersionDto(version: "6.21.0"), PackageVersionDto(version: "6.22.0"), PackageVersionDto(version: "6.22.1")],
      dependencies: [],
    ),
    PackageDto(
      id: "Microsoft.Identity.Client",
      version: "4.92.0",
      description: "This package contains the binaries of the Microsoft Authentication Library for .NET (MSAL.NET).       MSAL.NET makes it easy to obtain tokens from the Microsoft identity platform for developers (formerly Azure AD v2.0) signing-in users with work & school accounts, Microsoft personal accounts, and social identities via Azure AD B2C. These tokens provide access to Microsoft Cloud API and any other API secured by the Microsoft identity platform. This version supports adding authentication functionality to your .NET based clients - .NET, .NET Framework, .NET MAUI",
      iconUrl: null,
      versions: [PackageVersionDto(version: "2.6.1"), PackageVersionDto(version: "2.6.2"), PackageVersionDto(version: "2.7.0"), PackageVersionDto(version: "2.7.1"), PackageVersionDto(version: "3.0.8"), PackageVersionDto(version: "3.0.9")],
      dependencies: [],
    ),
    PackageDto(
      id: "System.Diagnostics.EventLog",
      version: "10.0.14",
      description: "Provides the System.Diagnostics.EventLog class, which allows the applications to use the Windows event log service.  Commonly Used Types: System.Diagnostics.EventLog",
      iconUrl: "assets/images/ic_system_diagnostics_eventlog.png",
      versions: [PackageVersionDto(version: "4.5.0"), PackageVersionDto(version: "4.6.0"), PackageVersionDto(version: "4.7.0"), PackageVersionDto(version: "5.0.0"), PackageVersionDto(version: "5.0.1"), PackageVersionDto(version: "6.0.0")],
      dependencies: [],
    ),
    PackageDto(
      id: "System.Drawing.Common",
      version: "10.0.14",
      description: "Provides access to GDI+ graphics functionality.        Commonly Used Types:       System.Drawing.Bitmap       System.Drawing.BitmapData       System.Drawing.Brush       System.Drawing.Font       System.Drawing.Graphics       System.Drawing.Icon        Since .NET 7, non-Windows platforms are not supported, even with the runtime configuration switch. See https://aka.ms/systemdrawingnonwindows for more information.",
      iconUrl: "assets/images/ic_system_drawing_common.png",
      versions: [PackageVersionDto(version: "4.5.0"), PackageVersionDto(version: "4.5.1"), PackageVersionDto(version: "4.5.2"), PackageVersionDto(version: "4.6.0"), PackageVersionDto(version: "4.6.1"), PackageVersionDto(version: "4.6.2")],
      dependencies: [],
    ),
    PackageDto(
      id: "Microsoft.Extensions.Http",
      version: "10.0.14",
      description: "The HttpClient factory is a pattern for configuring and retrieving named HttpClients in a composable way. The HttpClient factory provides extensibility to plug in DelegatingHandlers that address cross-cutting concerns such as service location, load balancing, and reliability. The default HttpClient factory provides built-in diagnostics and logging and manages the lifetimes of connections in a performant way.  Commonly Used Types: System.Net.Http.IHttpClientFactory",
      iconUrl: "assets/images/ic_microsoft_extensions_http.png",
      versions: [PackageVersionDto(version: "2.1.0"), PackageVersionDto(version: "2.1.1"), PackageVersionDto(version: "2.2.0"), PackageVersionDto(version: "3.0.0"), PackageVersionDto(version: "3.0.1"), PackageVersionDto(version: "3.0.2")],
      dependencies: ["Microsoft.Extensions.DependencyInjection"],
    ),
    PackageDto(
      id: "Microsoft.Win32.SystemEvents",
      version: "10.0.14",
      description: "Provides access to Windows system event notifications.  Commonly Used Types: Microsoft.Win32.SystemEvents",
      iconUrl: "assets/images/ic_microsoft_win32_systemevents.png",
      versions: [PackageVersionDto(version: "4.5.0"), PackageVersionDto(version: "4.6.0"), PackageVersionDto(version: "4.7.0"), PackageVersionDto(version: "5.0.0"), PackageVersionDto(version: "6.0.0"), PackageVersionDto(version: "6.0.1")],
      dependencies: [],
    ),
    PackageDto(
      id: "Microsoft.EntityFrameworkCore",
      version: "10.0.14",
      description: "Entity Framework Core is a modern object-database mapper for .NET. It supports LINQ queries, change tracking, updates, and schema migrations. EF Core works with SQL Server, Azure SQL Database, SQLite, Azure Cosmos DB, MySQL, PostgreSQL, and other databases through a provider plugin API.  Commonly Used Types: Microsoft.EntityFrameworkCore.DbContext Microsoft.EntityFrameworkCore.DbSet",
      iconUrl: "assets/images/ic_microsoft_entityframeworkcore.png",
      versions: [PackageVersionDto(version: "1.0.0"), PackageVersionDto(version: "1.0.1"), PackageVersionDto(version: "1.0.2"), PackageVersionDto(version: "1.0.3"), PackageVersionDto(version: "1.0.4"), PackageVersionDto(version: "1.0.5")],
      dependencies: ["Microsoft.Extensions.Logging", "Microsoft.Extensions.DependencyInjection"],
    ),
    PackageDto(
      id: "System.Security.Cryptography.Pkcs",
      version: "10.0.14",
      description: "Provides support for PKCS and CMS algorithms.  Commonly Used Types: System.Security.Cryptography.Pkcs.EnvelopedCms",
      iconUrl: "assets/images/ic_system_security_cryptography_pkcs.png",
      versions: [PackageVersionDto(version: "4.0.0"), PackageVersionDto(version: "4.3.0"), PackageVersionDto(version: "4.4.0"), PackageVersionDto(version: "4.5.0"), PackageVersionDto(version: "4.5.1"), PackageVersionDto(version: "4.5.2")],
      dependencies: [],
    ),
    PackageDto(
      id: "System.Windows.Extensions",
      version: "10.0.14",
      description: "Provides miscellaneous Windows-specific types  Commonly Used Types: System.Security.Cryptography.X509Certificates.X509Certificate2UI System.Security.Cryptography.X509Certificates.X509SelectionFlag",
      iconUrl: "assets/images/ic_system_windows_extensions.png",
      versions: [PackageVersionDto(version: "4.6.0"), PackageVersionDto(version: "4.7.0"), PackageVersionDto(version: "5.0.0"), PackageVersionDto(version: "6.0.0"), PackageVersionDto(version: "7.0.0"), PackageVersionDto(version: "8.0.0")],
      dependencies: [],
    ),
    PackageDto(
      id: "System.Memory.Data",
      version: "10.0.14",
      description: "A lightweight abstraction for a payload of bytes. Provides methods for converting between strings, streams, JSON, and bytes.  Commonly Used Types: System.BinaryData",
      iconUrl: "assets/images/ic_system_memory_data.png",
      versions: [PackageVersionDto(version: "1.0.0"), PackageVersionDto(version: "1.0.1"), PackageVersionDto(version: "1.0.2"), PackageVersionDto(version: "6.0.0"), PackageVersionDto(version: "6.0.1"), PackageVersionDto(version: "7.0.0")],
      dependencies: [],
    ),
    PackageDto(
      id: "Microsoft.Extensions.Diagnostics.Abstractions",
      version: "10.0.14",
      description: "Diagnostic abstractions for Microsoft.Extensions.Diagnostics.  Commonly Used Types: Microsoft.Extensions.Diagnostics.Metrics.IMetricsBuilder Microsoft.Extensions.Diagnostics.Metrics.IMetricsListener Microsoft.Extensions.Diagnostics.Metrics.InstrumentRule Microsoft.Extensions.Diagnostics.Metrics.MeterScope Microsoft.Extensions.Diagnostics.Metrics.MetricsBuilderExtensions Microsoft.Extensions.Diagnostics.Metrics.MetricsOptions",
      iconUrl: "assets/images/ic_microsoft_extensions_diagnostics_abstractions.png",
      versions: [PackageVersionDto(version: "8.0.0"), PackageVersionDto(version: "8.0.1"), PackageVersionDto(version: "9.0.0"), PackageVersionDto(version: "9.0.1"), PackageVersionDto(version: "9.0.2"), PackageVersionDto(version: "9.0.3")],
      dependencies: ["Microsoft.Extensions.DependencyInjection"],
    ),
    PackageDto(
      id: "Azure.Identity",
      version: "1.21.0",
      description: "Provides APIs for authenticating to Microsoft Entra ID",
      iconUrl: "assets/images/ic_azure_identity.png",
      versions: [PackageVersionDto(version: "1.0.0"), PackageVersionDto(version: "1.1.0"), PackageVersionDto(version: "1.1.1"), PackageVersionDto(version: "1.2.1"), PackageVersionDto(version: "1.2.2"), PackageVersionDto(version: "1.2.3")],
      dependencies: ["Azure.Core", "System.Text.Json"],
    ),
    PackageDto(
      id: "AWSSDK.Core",
      version: "4.0.102.18",
      description: "The Amazon Web Services SDK for .NET - Core Runtime",
      iconUrl: "assets/images/ic_awssdk_core.png",
      versions: [PackageVersionDto(version: "3.1.0"), PackageVersionDto(version: "3.1.0.1"), PackageVersionDto(version: "3.1.0.2"), PackageVersionDto(version: "3.1.1"), PackageVersionDto(version: "3.1.1.1"), PackageVersionDto(version: "3.1.2")],
      dependencies: [],
    ),
  ];
}
