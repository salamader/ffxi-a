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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Form1));
            this.backgroundWorker1 = new System.ComponentModel.BackgroundWorker();
            this.textBoxSourceFile = new System.Windows.Forms.TextBox();
            this.textBoxDestinationFolder = new System.Windows.Forms.TextBox();
            this.error = new System.Windows.Forms.TextBox();
            this.progressBar1 = new System.Windows.Forms.ProgressBar();
            this.Download = new System.Windows.Forms.Button();
            this.ectract = new System.Windows.Forms.Button();
            this.nowdownloading = new System.Windows.Forms.PictureBox();
            this.nowextracting = new System.Windows.Forms.PictureBox();
            ((System.ComponentModel.ISupportInitialize)(this.nowdownloading)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.nowextracting)).BeginInit();
            this.SuspendLayout();
            // 
            // backgroundWorker1
            // 
            this.backgroundWorker1.WorkerReportsProgress = true;
            this.backgroundWorker1.DoWork += new System.ComponentModel.DoWorkEventHandler(this.backgroundWorker1_DoWork);
            this.backgroundWorker1.ProgressChanged += new System.ComponentModel.ProgressChangedEventHandler(this.backgroundWorker1_ProgressChanged);
            this.backgroundWorker1.RunWorkerCompleted += new System.ComponentModel.RunWorkerCompletedEventHandler(this.backgroundWorker1_RunWorkerCompleted);
            // 
            // textBoxSourceFile
            // 
            this.textBoxSourceFile.Location = new System.Drawing.Point(48, 216);
            this.textBoxSourceFile.Name = "textBoxSourceFile";
            this.textBoxSourceFile.Size = new System.Drawing.Size(305, 20);
            this.textBoxSourceFile.TabIndex = 2;
            this.textBoxSourceFile.Visible = false;
            // 
            // textBoxDestinationFolder
            // 
            this.textBoxDestinationFolder.Location = new System.Drawing.Point(48, 242);
            this.textBoxDestinationFolder.Name = "textBoxDestinationFolder";
            this.textBoxDestinationFolder.Size = new System.Drawing.Size(266, 20);
            this.textBoxDestinationFolder.TabIndex = 3;
            this.textBoxDestinationFolder.Text = "C:\\FFXI_INSTALL";
            this.textBoxDestinationFolder.Visible = false;
            // 
            // error
            // 
            this.error.Location = new System.Drawing.Point(48, 190);
            this.error.Name = "error";
            this.error.Size = new System.Drawing.Size(305, 20);
            this.error.TabIndex = 6;
            this.error.Visible = false;
            // 
            // progressBar1
            // 
            this.progressBar1.Location = new System.Drawing.Point(14, 313);
            this.progressBar1.Name = "progressBar1";
            this.progressBar1.Size = new System.Drawing.Size(186, 13);
            this.progressBar1.TabIndex = 8;
            // 
            // Download
            // 
            this.Download.BackColor = System.Drawing.Color.Transparent;
            this.Download.BackgroundImageLayout = System.Windows.Forms.ImageLayout.None;
            this.Download.Cursor = System.Windows.Forms.Cursors.Hand;
            this.Download.FlatAppearance.BorderSize = 0;
            this.Download.FlatAppearance.MouseDownBackColor = System.Drawing.Color.Transparent;
            this.Download.FlatAppearance.MouseOverBackColor = System.Drawing.Color.Transparent;
            this.Download.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.Download.ForeColor = System.Drawing.Color.Transparent;
            this.Download.Image = ((System.Drawing.Image)(resources.GetObject("Download.Image")));
            this.Download.Location = new System.Drawing.Point(14, 201);
            this.Download.Name = "Download";
            this.Download.Size = new System.Drawing.Size(186, 49);
            this.Download.TabIndex = 9;
            this.Download.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText;
            this.Download.UseVisualStyleBackColor = false;
            this.Download.Click += new System.EventHandler(this.Download_Click);
            // 
            // ectract
            // 
            this.ectract.BackColor = System.Drawing.Color.Transparent;
            this.ectract.BackgroundImageLayout = System.Windows.Forms.ImageLayout.None;
            this.ectract.Cursor = System.Windows.Forms.Cursors.Hand;
            this.ectract.FlatAppearance.BorderSize = 0;
            this.ectract.FlatAppearance.MouseDownBackColor = System.Drawing.Color.Transparent;
            this.ectract.FlatAppearance.MouseOverBackColor = System.Drawing.Color.Transparent;
            this.ectract.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.ectract.ForeColor = System.Drawing.Color.Transparent;
            this.ectract.Image = ((System.Drawing.Image)(resources.GetObject("ectract.Image")));
            this.ectract.Location = new System.Drawing.Point(14, 201);
            this.ectract.Name = "ectract";
            this.ectract.Size = new System.Drawing.Size(186, 52);
            this.ectract.TabIndex = 10;
            this.ectract.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText;
            this.ectract.UseVisualStyleBackColor = false;
            this.ectract.Visible = false;
            this.ectract.Click += new System.EventHandler(this.install_Click);
            // 
            // nowdownloading
            // 
            this.nowdownloading.BackColor = System.Drawing.Color.Transparent;
            this.nowdownloading.Image = ((System.Drawing.Image)(resources.GetObject("nowdownloading.Image")));
            this.nowdownloading.Location = new System.Drawing.Point(14, 115);
            this.nowdownloading.Name = "nowdownloading";
            this.nowdownloading.Size = new System.Drawing.Size(194, 69);
            this.nowdownloading.TabIndex = 11;
            this.nowdownloading.TabStop = false;
            this.nowdownloading.Visible = false;
            // 
            // nowextracting
            // 
            this.nowextracting.BackColor = System.Drawing.Color.Transparent;
            this.nowextracting.Image = ((System.Drawing.Image)(resources.GetObject("nowextracting.Image")));
            this.nowextracting.Location = new System.Drawing.Point(13, 115);
            this.nowextracting.Name = "nowextracting";
            this.nowextracting.Size = new System.Drawing.Size(194, 69);
            this.nowextracting.TabIndex = 12;
            this.nowextracting.TabStop = false;
            this.nowextracting.Visible = false;
            // 
            // Form1
            // 
            this.AccessibleRole = System.Windows.Forms.AccessibleRole.None;
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.Black;
            this.BackgroundImage = ((System.Drawing.Image)(resources.GetObject("$this.BackgroundImage")));
            this.ClientSize = new System.Drawing.Size(218, 328);
            this.Controls.Add(this.nowextracting);
            this.Controls.Add(this.nowdownloading);
            this.Controls.Add(this.ectract);
            this.Controls.Add(this.Download);
            this.Controls.Add(this.progressBar1);
            this.Controls.Add(this.error);
            this.Controls.Add(this.textBoxDestinationFolder);
            this.Controls.Add(this.textBoxSourceFile);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Name = "Form1";
            this.Text = "FFXI-A Client Downloader ";
            ((System.ComponentModel.ISupportInitialize)(this.nowdownloading)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.nowextracting)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

		}

		#endregion

        private System.ComponentModel.BackgroundWorker backgroundWorker1;
		private System.Windows.Forms.TextBox textBoxSourceFile;
        private System.Windows.Forms.TextBox textBoxDestinationFolder;
        private System.Windows.Forms.TextBox error;
        private System.Windows.Forms.ProgressBar progressBar1;
        private System.Windows.Forms.Button Download;
        private System.Windows.Forms.Button ectract;
        private System.Windows.Forms.PictureBox nowdownloading;
        private System.Windows.Forms.PictureBox nowextracting;
	}
}

