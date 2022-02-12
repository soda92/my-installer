using System.Diagnostics;
using System.Windows;
var p = Process.Start(
    new ProcessStartInfo("git", "branch --show-current")
    {
        CreateNoWindow = true,
        UseShellExecute = false,
        RedirectStandardError = true,
        RedirectStandardOutput = true,
        WorkingDirectory = Environment.CurrentDirectory
    }
);

p.WaitForExit();
string branchName = p.StandardOutput.ReadToEnd().TrimEnd();
string errorInfoIfAny = p.StandardError.ReadToEnd().TrimEnd();

if (errorInfoIfAny.Length != 0)
{
    Console.WriteLine($"error: {errorInfoIfAny}");
}
else
{
    // string message = "Simple MessageBox";
    MessageBox.Show(branchName);
}
