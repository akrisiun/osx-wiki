## Dotnet netcoreapp.1.2 web

## URLs for production

```
            string[] urls = new[] { "http://0.0.0.0:5000" }; // default

            if (args != null && args.Length > 0)
            {
                // --urls "http://*:58088"
                var list = args.GetEnumerator();
                while (list.MoveNext())
                {
                    var item = list.Current as string ?? "";
                    if (item.Equals("--urls") && list.MoveNext())
                    {
                        item = list.Current  as string;
                        urls[0] = item ?? urls[0];

                        Console.WriteLine($"--urls {item}");
                        break;
                     }
                }

            }

            var host = new WebHostBuilder()
                // .UseConfiguration(config)
                .UseUrls(urls)
                .UseSetting("detailedErrors", "true")
                .UseKestrel()
                .UseContentRoot(Directory.GetCurrentDirectory())
                .UseIISIntegration()
                .UseStartup<Startup>()
                // .UseApplicationInsights()
                .Build();

            host.Run();
```

### Dockerfile
```
FROM microsoft/dotnet:1.1-runtime-deps

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    && apt-get install -y curl mc nano

# Install .NET Core
ENV DOTNET_VERSION 1.1.2
# https://dotnetcli.blob.core.windows.net/dotnet/release/1.1.0/Binaries/1.1.2/dotnet-debian-x64.1.1.2.tar.gz
ENV DOTNET_DOWNLOAD_URL https://dotnetcli.blob.core.windows.net/dotnet/release/1.1.0/Binaries/$DOTNET_VERSION/dotnet-debian-x64.$DOTNET_VERSION.tar.gz

RUN curl -SL $DOTNET_DOWNLOAD_URL --output dotnet.tar.gz \
    && mkdir -p /usr/share/dotnet \
    && tar -zxf dotnet.tar.gz -C /usr/share/dotnet \
    && rm dotnet.tar.gz \
    && ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet

ADD web /web/
WORKDIR /web
EXPOSE 5000

# RUN dotnet restore
ENV ASPNETCORE_ENVIRONMENT=Development
ENV FOLDER=/web/index
CMD dotnet Microsoft.SourceBrowser.SourceIndexServer.dll 
```