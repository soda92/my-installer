import subprocess

subprocess.run(
    [
        "C:/Install/postgresql-14.1-1-windows-x64.exe",
        "--mode",
        "unattended",
        "--unattendedmodeui",
        "minimalWithDialogs",
        "--prefix",
        "C:\PostgreSQL_14",
        "--datadir",
        "C:\PostgreSQL_14\data",
        "--create_shortcuts",
        "0",
        "--superpassword",
        "1234",
        "--locale",
        "en",
    ]
)
