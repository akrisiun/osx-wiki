@IF EXIST "%~dp0\node.exe" (
  "%~dp0\node.exe"  "%~dp0\node_modules\yo\lib\cli.js" %*
) ELSE (
  node  "%~dp0\node_modules\yo\lib\cli.js" %*
)