dotnet-wiki <https://github.com/akrisiun/dotnet-wiki>
Personal .NET clr, asp.net core web notes  
[Sources-MvcCore.md](Sources-MvcCore.md)

### csproj for .NET core (sdk libraries)
<https://docs.microsoft.com/en-us/dotnet/core/tools/project-json-to-csproj>

### project.json (obsolete)
<https://docs.microsoft.com/en-us/dotnet/articles/core/tools/project-json>

practical problems
```
{
    "buildOptions": {
    
       "compile": ["**/*.cs", "../sources/*.cs"]

    
       ,  "define": ["TEST"]
       ,  "nowarn": ["CS0168", "CS0219"]
       , "platform": "x86"
       , "debugType": "full"
       , "xmlDoc": false
       , "exclude": ["bin/**", "obj/**"]
    }
    , "packOptions": {
        "repository": {
            "url": "http://github.com/dotnet/corefx"
        }
    }

"libraries": {
    "Microsoft.AspNetCore.Mvc.Core/1.1.0-beta5": {
      "type": "project",
      "path": "../Microsoft.AspNetCore.Mvc.Core/project.json"
    },
    "Newtonsoft.Json/9.2.0-beta1": {
      "type": "project",
      "path": "../../vendor/Newtonsoft.Json/src/Newtonsoft.Json/project.json"
    },
},

"frameworks": {
    "netcoreapp1.0": {
        "buildOptions": {
            "define": ["FOO", "BIZ"]
        }
    }
}

"frameworks": {
    "net451": {
        "frameworkAssemblies": {
            "System.Runtime": {
                "type": "build",
                "version": "4.0.0"
            }
        }
    }
    
"frameworks": {
  "netcoreapp1.0": {
     "imports": "portable-net45+win8"
  }
}     

"buildOptions": {
  "allowUnsafe": true,
  "emitEntryPoint": true
}

"dependencies": {
     "System.Reflection.Metadata": "1.3.0"
    , "Microsoft.Extensions.JsonParser.Sources": {
      "type": "build",  "version": "1.0.0-rc2-20221"
    }
    , "Microsoft.Extensions.HashCodeCombiner.Sources": {
           "type": "build",      "version": "1.1.0-alpha1-21456"
    }
    , "Microsoft.Extensions.DependencyModel": "1.0.0-*"
}

```
