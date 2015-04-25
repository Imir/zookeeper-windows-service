using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ServiceKiller
{
    class Program
    {
        static void Main(string[] args)
        {
            if (args.Length == 1)
            {
                string value = args[0];
                int pid;
                if (Int32.TryParse(value, out pid)) { KillService(pid); }
                else
                {
                    FileInfo fileInfo = new FileInfo(value);

                    if (fileInfo.Exists)
                    {
                        string strPID = "";
                        string copyFilePath = String.Format("{0}/{1}.txt", fileInfo.Directory, "service_pid");
                        fileInfo.CopyTo(copyFilePath, true);

                        using (FileStream stream = File.Open(copyFilePath, FileMode.Open, FileAccess.Read))
                        {
                            using (StreamReader streamReader = new StreamReader(stream))
                            {
                                strPID = streamReader.ReadToEnd();
                            }
                        }

                        if (Int32.TryParse(strPID, out pid)) { KillService(pid); }
                    }
                }
            }
        }

        private static void KillService(int pid)
        {
            try
            {
                Process proc = Process.GetProcessById(pid);
                if (proc != null) { proc.Kill(); }
            }
            catch { }
        }
    }
}
