
### macpack (Mac OS X only)

macpack is a tool that must be used to bundle Cocoa# applications into Double-Clickable, Finder friendly, bundles on Mac OS X. It bundles static libraries and resources, as well as generates a basic info.plist into the .app bundle.

For example the following commands are used to build the CurrencyConverter.exe into an application bundle:

```
mcs -g -debug+ CurrencyConverter.cs -out:CurrencyConverter.exe -pkg:cocoa-sharp
rm -rf CurrencyConverter.app
macpack -m:2 -o:.  -r:/Library/Frameworks/Mono.framework/Versions/Current/lib/ libCocoaSharpGlue.dylib
        -r:CurrencyConverter.nib -n:CurrencyConverter -a:CurrencyConverter.exe
```