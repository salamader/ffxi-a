using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.IO;

namespace DownloadProgressBar1
{
	public partial class Form1 : Form
	{
		public Form1()
		{
            
			InitializeComponent();
            textBoxSourceFile.Text = "http://www.ffxi-a.com/download/FFXI.part01.rar";
            
		}

		private void backgroundWorker1_DoWork(object sender, DoWorkEventArgs e)
		{
            
			// the URL to download the file from
			string sUrlToReadFileFrom = textBoxSourceFile.Text;
			// the path to write the file to
			int iLastIndex = sUrlToReadFileFrom.LastIndexOf('/');
			string sDownloadFileName = sUrlToReadFileFrom.Substring(iLastIndex + 1, (sUrlToReadFileFrom.Length - iLastIndex - 1));
			string sFilePathToWriteFileTo = textBoxDestinationFolder.Text + "\\" + sDownloadFileName;

			// first, we need to get the exact size (in bytes) of the file we are downloading
			Uri url = new Uri(sUrlToReadFileFrom);
			System.Net.HttpWebRequest request = (System.Net.HttpWebRequest)System.Net.WebRequest.Create(url);
			System.Net.HttpWebResponse response = (System.Net.HttpWebResponse)request.GetResponse();
			response.Close();
			// gets the size of the file in bytes
			Int64 iSize = response.ContentLength;

			// keeps track of the total bytes downloaded so we can update the progress bar
			Int64 iRunningByteTotal = 0;

			// use the webclient object to download the file
			using (System.Net.WebClient client = new System.Net.WebClient())
			{
				// open the file at the remote URL for reading
				using (System.IO.Stream streamRemote = client.OpenRead(new Uri(sUrlToReadFileFrom)))
				{
					// using the FileStream object, we can write the downloaded bytes to the file system
					using (Stream streamLocal = new FileStream(sFilePathToWriteFileTo, FileMode.Create, FileAccess.Write, FileShare.None))
					{
						// loop the stream and get the file into the byte buffer
						int iByteSize = 0;
						byte[] byteBuffer = new byte[iSize];
						while ((iByteSize = streamRemote.Read(byteBuffer, 0, byteBuffer.Length)) > 0)
						{
							// write the bytes to the file system at the file path specified
							streamLocal.Write(byteBuffer, 0, iByteSize);
							iRunningByteTotal += iByteSize;

							// calculate the progress out of a base "100"
							double dIndex = (double)(iRunningByteTotal);
							double dTotal = (double)byteBuffer.Length;
							double dProgressPercentage = (dIndex / dTotal);
							int iProgressPercentage = (int)(dProgressPercentage * 100);

							// update the progress bar
							backgroundWorker1.ReportProgress(iProgressPercentage);
						}

						// clean up the file stream
						streamLocal.Close();
					}

					// close the connection to the remote server
					streamRemote.Close();
				}
			}
		}

		private void backgroundWorker1_ProgressChanged(object sender, ProgressChangedEventArgs e)
		{
			progressBar1.Value = e.ProgressPercentage;
		}

		private void backgroundWorker1_RunWorkerCompleted(object sender, RunWorkerCompletedEventArgs e)
		{
            string part1 = @"C:/FFXI_INSTALL/FFXI.part01.rar";
            Console.WriteLine(File.Exists(part1) ? true : false);
            if (File.Exists(part1) == false)
            {
                error.Text = "C:/FFXI_INSTALL/FFXI.part01.rar";
                textBoxSourceFile.Text = "http://www.ffxi-a.com/download/FFXI.part01.rar";
                backgroundWorker1.RunWorkerAsync();
                return;
            }
            string part2 = @"C:/FFXI_INSTALL/FFXI.part02.rar";
            Console.WriteLine(File.Exists(part2) ? true : false);
            if (File.Exists(part2) == false)
            {
                error.Text = "C:/FFXI_INSTALL/FFXI.part02.rar";
                textBoxSourceFile.Text = "http://www.ffxi-a.com/download/FFXI.part02.rar";
                backgroundWorker1.RunWorkerAsync();
                return;
            }
            string part3 = @"C:/FFXI_INSTALL/FFXI.part03.rar";
            Console.WriteLine(File.Exists(part3) ? true : false);
            if (File.Exists(part3) == false)
            {
                error.Text = "C:/FFXI_INSTALL/FFXI.part03.rar";
                textBoxSourceFile.Text = "http://www.ffxi-a.com/download/FFXI.part03.rar";
                backgroundWorker1.RunWorkerAsync();
                return;
            }
            string part4 = @"C:/FFXI_INSTALL/FFXI.part04.rar";
            Console.WriteLine(File.Exists(part4) ? true : false);
            if (File.Exists(part4) == false)
            {
                error.Text = "C:/FFXI_INSTALL/FFXI.part04.rar";
                textBoxSourceFile.Text = "http://www.ffxi-a.com/download/FFXI.part04.rar";
                backgroundWorker1.RunWorkerAsync();
                return;
            }
            string part5 = @"C:/FFXI_INSTALL/FFXI.part05.rar";
            Console.WriteLine(File.Exists(part5) ? true : false);
            if (File.Exists(part5) == false)
            {
                error.Text = "C:/FFXI_INSTALL/FFXI.part05.rar";
                textBoxSourceFile.Text = "http://www.ffxi-a.com/download/FFXI.part05.rar";
                backgroundWorker1.RunWorkerAsync();
                return;
            }
            string part6 = @"C:/FFXI_INSTALL/FFXI.part06.rar";
            Console.WriteLine(File.Exists(part6) ? true : false);
            if (File.Exists(part6) == false)
            {
                error.Text = "C:/FFXI_INSTALL/FFXI.part06.rar";
                textBoxSourceFile.Text = "http://www.ffxi-a.com/download/FFXI.part06.rar";
                backgroundWorker1.RunWorkerAsync();
                return;
            }
            string part7 = @"C:/FFXI_INSTALL/FFXI.part07.rar";
            Console.WriteLine(File.Exists(part7) ? true : false);
            if (File.Exists(part7) == false)
            {
                error.Text = "C:/FFXI_INSTALL/FFXI.part07.rar";
                textBoxSourceFile.Text = "http://www.ffxi-a.com/download/FFXI.part07.rar";
                backgroundWorker1.RunWorkerAsync();
                return;
            }
            string part8 = @"C:/FFXI_INSTALL/FFXI.part08.rar";
            Console.WriteLine(File.Exists(part8) ? true : false);
            if (File.Exists(part8) == false)
            {
                error.Text = "C:/FFXI_INSTALL/FFXI.part08.rar";
                textBoxSourceFile.Text = "http://www.ffxi-a.com/download/FFXI.part08.rar";
                backgroundWorker1.RunWorkerAsync();
                return;
            }
            string part9 = @"C:/FFXI_INSTALL/FFXI.part09.rar";
            Console.WriteLine(File.Exists(part9) ? true : false);
            if (File.Exists(part9) == false)
            {
                error.Text = "C:/FFXI_INSTALL/FFXI.part09.rar";
                textBoxSourceFile.Text = "http://www.ffxi-a.com/download/FFXI.part09.rar";
                backgroundWorker1.RunWorkerAsync();
                return;
            }
            
            
			MessageBox.Show("File download complete");
		}

		private void btnTestDownload_Click(object sender, EventArgs e)
		{
			if (textBoxSourceFile.Text.Length == 0)
			{
				MessageBox.Show("Please enter a source file");
				return;
			}

			if (textBoxDestinationFolder.Text.Length == 0)
			{
				MessageBox.Show("Please enter a destination file");
			}

			backgroundWorker1.RunWorkerAsync();
		}
	}
}
