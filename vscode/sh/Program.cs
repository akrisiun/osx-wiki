using System;
using System.Diagnostics;
using System.IO;
using System.Linq;

namespace Sh
{
    static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            string[] args = Environment.GetCommandLineArgs();

            string arg =  args.Length <= 1 ? string.Empty : args[0];
            foreach (string str in Enumerable.Skip(args, 2))
                arg += " " + str;
            if (string.IsNullOrWhiteSpace(arg))
                arg = "call code .";

            Console.Write("cmd.exe /c " + arg);

            // http://www.dotnetperls.com/redirectstandardoutput
            var info = new ProcessStartInfo("cmd.exe")
            {
                Arguments = "", // arg,
                WorkingDirectory = Environment.CurrentDirectory,
                CreateNoWindow = true,
                UseShellExecute = false,
                RedirectStandardOutput = true,
                RedirectStandardInput = true,
                RedirectStandardError = true
            };
            var proc = Process.Start(info);

            proc.OutputDataReceived += (s, e) =>
                Console.WriteLine(e.Data ?? e.Data.ToString());
            proc.ErrorDataReceived += (s, e) =>
                Console.WriteLine(e.Data ?? e.Data.ToString());

            proc.StandardInput.WriteLine(arg);

            proc.BeginOutputReadLine();
            proc.StandardError.ReadToEndAsync();
            // proc.StandardOutput.ReadToEnd();
            // Console.Write(result);

            proc.WaitForExit();
            proc.Dispose();

            //Application.EnableVisualStyles();
            //Application.SetCompatibleTextRenderingDefault(false);
            //Application.Run(new Form1());
        }
    }
}
