### csproj for .NET core (sdk libraries)
https://docs.microsoft.com/en-us/dotnet/core/tools/project-json-to-csproj
.csproj NET.SDK syntax sample : https://gist.github.com/akrisiun/4225c424d10f900b263bc293ee443c01

```
Some tags: win7-x64;osx.10-11-x64;ubuntu.16.04-x64

net46;
<NetStandardImplicitPackageVersion Condition=" '$(TargetFramework)' == 'netstandard1.3' "
$(NetStandardPackageVersion) 

<FileUpgradeFlags />
<OldToolsVersion>2.0</OldToolsVersion>
<AutoGenerateBindingRedirects>true</AutoGenerateBindingRedirects>
<GenerateSerializationAssemblies>Off</GenerateSerializationAssemblies>

<RuntimeIdentifiers>win7-x64;osx.10-11-x64;ubuntu.16.04-x64</RuntimeIdentifiers>
 <SchemaVersion>2.0</SchemaVersion>
    <OutputPath>..\..\lib\</OutputPath>
    <FileUpgradeFlags />
    <OldToolsVersion>2.0</OldToolsVersion>
    <Version>1.6.0</Version>
  </PropertyGroup>
  <PropertyGroup Condition="'$(Configuration)|$(TargetFramework)|$(Platform)'=='Debug|net452|AnyCPU'">
    <DefineConstants>TRACE;DEBUG;NET452;NETCORE</DefineConstants>
  </PropertyGroup>
```

### .Sdk library:
```
<Project Sdk="Microsoft.NET.Sdk">

  <PropertyGroup>
    <!--<TargetFrameworks>netcoreapp1.1;net452;</TargetFrameworks>-->
    <TargetFrameworks>net46;</TargetFrameworks>
    <TargetFrameworkVersion>v4.6</TargetFrameworkVersion>
    <!--<TargetFrameworkVersion>v4.5.2</TargetFrameworkVersion>-->
    <OutputPath>..\..\lib\</OutputPath>
  </PropertyGroup>
  <ItemGroup>
    <Content Include="default.cshtml" />
  </ItemGroup>

  <ItemGroup>
    <PackageReference Include="Microsoft.AspNetCore.Diagnostics" Version="1.1.1" />
    <PackageReference Include="Microsoft.AspNetCore.Http.Abstractions" Version="1.1.1" />
    <PackageReference Include="Microsoft.AspNetCore.Routing" Version="1.1.1" />
    <PackageReference Include="Microsoft.AspNetCore.Server.Kestrel" Version="1.1.1" />
    <PackageReference Include="Microsoft.AspNetCore.StaticFiles" Version="1.1.1" />
    <PackageReference Include="Microsoft.Extensions.Logging.Console" Version="1.1.1" />
    <PackageReference Include="Newtonsoft.Json" Version="10.0.2" />
  </ItemGroup>
  <ItemGroup>
    <Reference Include="System.Net.Http.WebRequest" />
    <Reference Include="System.Web" />
    <Reference Include="System.Web.Routing" />
  </ItemGroup>
</Project>
```
### Sdk WEB