### F# tutorial

https://docs.microsoft.com/en-us/dotnet/fsharp/get-started/get-started-command-line

dotnet new lib -lang F# -o src/Library 
```
module Library

open Newtonsoft.Json

let getJsonNetJson value = 
    sprintf "I used to be %s but now I'm %s thanks to JSON.NET!" value  (JsonConvert.SerializeObject(value))
// dotnet add src/Library/Library.fsproj package Newtonsoft.Json
```
## V2 console 
<ProjectReference Include="..\Library\Library.fsproj" />

dotnet add src\EfLib.csproj package NETStandard.Library
dotnet add src\EfLib.csproj package Microsoft.EntityFrameworkCore.Tools.DotNet


### Ubuntu/Mint

http://fsharp.org/use/linux/

Add the mono repository to your package manager, as detailed here.
Install the fsharp package, which will pull in an updated version of Mono, if required.
```
 sudo apt-get update
 sudo apt-get install fsharp
``` 
This installs the F# compiler fsharpc and and the F# intereactive fsharpi.

# from source:

```
# Ionide-fsharp
choco install visualfsharptools -y
choco install microsoft-build-tools --version 14.0.25420.1 -y
choco install windows-sdk-8.0 -y

 export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/user/mono/lib/
 export PKG_CONFIG_PATH=/home/user/mono/lib/pkgconfig/
 ```

# Control flow

https://fsharpforfunandprofit.com/posts/control-flow-expressions/
```


```