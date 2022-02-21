using System.Diagnostics;
using System.Text.RegularExpressions;
var p = Process.Start(
    new ProcessStartInfo("fbwfmgr", "/getconfig")
    {
        CreateNoWindow = true,
        UseShellExecute = false,
        RedirectStandardError = true,
        RedirectStandardOutput = true,
        WorkingDirectory = Environment.CurrentDirectory
    }
);
if (p == null)
{
    return;
}

p.WaitForExit();
string result = p.StandardOutput.ReadToEnd().TrimEnd();
string errorInfoIfAny = p.StandardError.ReadToEnd().TrimEnd();

if (errorInfoIfAny.Length != 0)
{
    Console.WriteLine($"error: {errorInfoIfAny}");
}
else
{
    // string message = "Simple MessageBox";
    // MessageBox.Show(branchName);
        Regex regex = new Regex(@"filter state: \W");
        
        // Step 2: call Match on Regex instance.
        Match match = regex.Match(result);
}
