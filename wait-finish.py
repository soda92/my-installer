import subprocess
import os

if not os.path.exists("C:/PostgreSQL_14/bin/psql.exe"):
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

import ctypes


def is_admin():
    try:
        return ctypes.windll.shell32.IsUserAnAdmin()
    except:
        raise False


print(is_admin())
