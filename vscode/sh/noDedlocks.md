http://www.dotnetperls.com/redirectstandardoutput
https://msdn.microsoft.com/en-us/library/system.diagnostics.processstartinfo.redirectstandardoutput(v=vs.110).aspx

 // To avoid deadlocks, use asynchronous read operations on at least one of the streams.
 // Do not perform a synchronous read to the end of both redirected streams.
 p.BeginOutputReadLine();
 string error = p.StandardError.ReadToEnd();
 p.WaitForExit();
 