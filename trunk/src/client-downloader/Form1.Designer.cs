namespace DownloadProgressBar1
{
	partial class Form1
	{
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.IContainer components = null;

		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		/// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
		protected override void Dispose(bool disposing)
		{
			if (disposing && (components != null))
			{
				components.Dispose();
			}
			base.Dispose(disposing);
		}

		#region Windows Form Designer generated code

		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
            this.progressBar1 = new System.Windows.Forms.ProgressBar();
            this.backgroundWorker1 = new System.ComponentModel.BackgroundWorker();
            this.btnTestDownload = new System.Windows.Forms.Button();
            this.textBoxSourceFile = new System.Windows.Forms.TextBox();
            this.textBoxDestinationFolder = new System.Windows.Forms.TextBox();
            this.lblSourceFile = new System.Windows.Forms.Label();
            this.lblDestinationFolder = new System.Windows.Forms.Label();
            this.error = new System.Windows.Forms.TextBox();
            this.SuspendLayout();
            // 
            // progressBar1
            // 
            this.progressBar1.Location = new System.Drawing.Point(12, 152);
            this.progressBar1.Name = "progressBar1";
            this.progressBar1.Size = new System.Drawing.Size(379, 23);
            this.progressBar1.TabIndex = 0;
            // 
            // backgroundWorker1
            // 
            this.backgroundWorker1.WorkerReportsProgress = true;
            this.backgroundWorker1.DoWork += new System.ComponentModel.DoWorkEventHandler(this.backgroundWorker1_DoWork);
            this.backgroundWorker1.ProgressChanged += new System.ComponentModel.ProgressChangedEventHandler(this.backgroundWorker1_ProgressChanged);
            this.backgroundWorker1.RunWorkerCompleted += new System.ComponentModel.RunWorkerCompletedEventHandler(this.backgroundWorker1_RunWorkerCompleted);
            // 
            // btnTestDownload
            // 
            this.btnTestDownload.Location = new System.Drawing.Point(134, 104);
            this.btnTestDownload.Name = "btnTestDownload";
            this.btnTestDownload.Size = new System.Drawing.Size(132, 23);
            this.btnTestDownload.TabIndex = 1;
            this.btnTestDownload.Text = "Test Download";
            this.btnTestDownload.UseVisualStyleBackColor = true;
            this.btnTestDownload.Click += new System.EventHandler(this.btnTestDownload_Click);
            // 
            // textBoxSourceFile
            // 
            this.textBoxSourceFile.Location = new System.Drawing.Point(86, 13);
            this.textBoxSourceFile.Name = "textBoxSourceFile";
            this.textBoxSourceFile.Size = new System.Drawing.Size(305, 20);
            this.textBoxSourceFile.TabIndex = 2;
            // 
            // textBoxDestinationFolder
            // 
            this.textBoxDestinationFolder.Location = new System.Drawing.Point(125, 47);
            this.textBoxDestinationFolder.Name = "textBoxDestinationFolder";
            this.textBoxDestinationFolder.Size = new System.Drawing.Size(266, 20);
            this.textBoxDestinationFolder.TabIndex = 3;
            this.textBoxDestinationFolder.Text = "C:\\FFXI_INSTALL";
            // 
            // lblSourceFile
            // 
            this.lblSourceFile.AutoSize = true;
            this.lblSourceFile.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblSourceFile.Location = new System.Drawing.Point(9, 16);
            this.lblSourceFile.Name = "lblSourceFile";
            this.lblSourceFile.Size = new System.Drawing.Size(71, 13);
            this.lblSourceFile.TabIndex = 4;
            this.lblSourceFile.Text = "Source File";
            // 
            // lblDestinationFolder
            // 
            this.lblDestinationFolder.AutoSize = true;
            this.lblDestinationFolder.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblDestinationFolder.Location = new System.Drawing.Point(9, 50);
            this.lblDestinationFolder.Name = "lblDestinationFolder";
            this.lblDestinationFolder.Size = new System.Drawing.Size(110, 13);
            this.lblDestinationFolder.TabIndex = 5;
            this.lblDestinationFolder.Text = "Destination Folder";
            // 
            // error
            // 
            this.error.Location = new System.Drawing.Point(48, 204);
            this.error.Name = "error";
            this.error.Size = new System.Drawing.Size(305, 20);
            this.error.TabIndex = 6;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(403, 274);
            this.Controls.Add(this.error);
            this.Controls.Add(this.lblDestinationFolder);
            this.Controls.Add(this.lblSourceFile);
            this.Controls.Add(this.textBoxDestinationFolder);
            this.Controls.Add(this.textBoxSourceFile);
            this.Controls.Add(this.btnTestDownload);
            this.Controls.Add(this.progressBar1);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Name = "Form1";
            this.Text = "FFXI-A Client Downloader ";
            this.ResumeLayout(false);
            this.PerformLayout();

		}

		#endregion

		private System.Windows.Forms.ProgressBar progressBar1;
		private System.ComponentModel.BackgroundWorker backgroundWorker1;
		private System.Windows.Forms.Button btnTestDownload;
		private System.Windows.Forms.TextBox textBoxSourceFile;
		private System.Windows.Forms.TextBox textBoxDestinationFolder;
		private System.Windows.Forms.Label lblSourceFile;
		private System.Windows.Forms.Label lblDestinationFolder;
        private System.Windows.Forms.TextBox error;
	}
}

