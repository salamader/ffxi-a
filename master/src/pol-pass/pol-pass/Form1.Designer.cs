namespace pol_pass
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
            this.loadwindow = new System.Windows.Forms.RichTextBox();
            this.ffxiboot = new System.Windows.Forms.TextBox();
            this.username = new System.Windows.Forms.TextBox();
            this.password = new System.Windows.Forms.TextBox();
            this.error = new System.Windows.Forms.Label();
            this.chatBrowser = new System.Windows.Forms.WebBrowser();
            this.tracer = new System.Windows.Forms.TextBox();
            this.SessionID = new System.Windows.Forms.Label();
            this.soe = new System.Windows.Forms.PictureBox();
            this.reboot = new System.Windows.Forms.Button();
            this.chatclose = new System.Windows.Forms.Button();
            this.home = new System.Windows.Forms.Button();
            this.error1 = new System.Windows.Forms.PictureBox();
            this.logout = new System.Windows.Forms.Button();
            this.chat = new System.Windows.Forms.Button();
            this.pass = new System.Windows.Forms.PictureBox();
            this.user = new System.Windows.Forms.PictureBox();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.pictureBox3 = new System.Windows.Forms.PictureBox();
            this.login = new System.Windows.Forms.Button();
            this.pictureBox2 = new System.Windows.Forms.PictureBox();
            this.success = new System.Windows.Forms.PictureBox();
            this.bv = new System.Windows.Forms.PictureBox();
            ((System.ComponentModel.ISupportInitialize)(this.soe)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.error1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pass)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.user)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox3)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox2)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.success)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.bv)).BeginInit();
            this.SuspendLayout();
            // 
            // loadwindow
            // 
            this.loadwindow.Location = new System.Drawing.Point(3, 3);
            this.loadwindow.Name = "loadwindow";
            this.loadwindow.Size = new System.Drawing.Size(10, 20);
            this.loadwindow.TabIndex = 1;
            this.loadwindow.Text = "";
            this.loadwindow.Visible = false;
            // 
            // ffxiboot
            // 
            this.ffxiboot.Location = new System.Drawing.Point(19, 3);
            this.ffxiboot.Name = "ffxiboot";
            this.ffxiboot.Size = new System.Drawing.Size(10, 20);
            this.ffxiboot.TabIndex = 2;
            this.ffxiboot.Visible = false;
            // 
            // username
            // 
            this.username.Location = new System.Drawing.Point(12, 119);
            this.username.Name = "username";
            this.username.Size = new System.Drawing.Size(203, 20);
            this.username.TabIndex = 3;
            this.username.TextChanged += new System.EventHandler(this.username_TextChanged);
            // 
            // password
            // 
            this.password.Location = new System.Drawing.Point(12, 162);
            this.password.Name = "password";
            this.password.PasswordChar = '*';
            this.password.Size = new System.Drawing.Size(203, 20);
            this.password.TabIndex = 4;
            this.password.UseSystemPasswordChar = true;
            this.password.TextChanged += new System.EventHandler(this.password_TextChanged);
            // 
            // error
            // 
            this.error.AutoSize = true;
            this.error.ForeColor = System.Drawing.Color.Red;
            this.error.Location = new System.Drawing.Point(9, 221);
            this.error.Name = "error";
            this.error.Size = new System.Drawing.Size(28, 13);
            this.error.TabIndex = 7;
            this.error.Text = "error";
            this.error.Visible = false;
            // 
            // chatBrowser
            // 
            this.chatBrowser.Location = new System.Drawing.Point(233, 73);
            this.chatBrowser.MinimumSize = new System.Drawing.Size(20, 20);
            this.chatBrowser.Name = "chatBrowser";
            this.chatBrowser.Size = new System.Drawing.Size(979, 502);
            this.chatBrowser.TabIndex = 11;
            // 
            // tracer
            // 
            this.tracer.Location = new System.Drawing.Point(233, 527);
            this.tracer.Name = "tracer";
            this.tracer.Size = new System.Drawing.Size(129, 20);
            this.tracer.TabIndex = 13;
            this.tracer.Text = "tracer";
            this.tracer.Visible = false;
            // 
            // SessionID
            // 
            this.SessionID.AutoSize = true;
            this.SessionID.ForeColor = System.Drawing.Color.Red;
            this.SessionID.Location = new System.Drawing.Point(368, 534);
            this.SessionID.Name = "SessionID";
            this.SessionID.Size = new System.Drawing.Size(55, 13);
            this.SessionID.TabIndex = 14;
            this.SessionID.Text = "SessionID";
            this.SessionID.Visible = false;
            // 
            // soe
            // 
            this.soe.BackgroundImage = global::pol_pass.Properties.Resources.soe;
            this.soe.Location = new System.Drawing.Point(3, 82);
            this.soe.Name = "soe";
            this.soe.Size = new System.Drawing.Size(228, 256);
            this.soe.TabIndex = 35;
            this.soe.TabStop = false;
            this.soe.Visible = false;
            // 
            // reboot
            // 
            this.reboot.BackColor = System.Drawing.Color.WhiteSmoke;
            this.reboot.BackgroundImage = global::pol_pass.Properties.Resources.butback;
            this.reboot.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch;
            this.reboot.Cursor = System.Windows.Forms.Cursors.Hand;
            this.reboot.FlatAppearance.BorderSize = 0;
            this.reboot.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.reboot.ForeColor = System.Drawing.Color.Transparent;
            this.reboot.Image = global::pol_pass.Properties.Resources.reboot;
            this.reboot.Location = new System.Drawing.Point(96, 119);
            this.reboot.Name = "reboot";
            this.reboot.Size = new System.Drawing.Size(128, 34);
            this.reboot.TabIndex = 34;
            this.reboot.UseVisualStyleBackColor = false;
            this.reboot.Visible = false;
            this.reboot.Click += new System.EventHandler(this.button1_Click_1);
            // 
            // chatclose
            // 
            this.chatclose.BackColor = System.Drawing.Color.Transparent;
            this.chatclose.BackgroundImage = global::pol_pass.Properties.Resources.butback;
            this.chatclose.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch;
            this.chatclose.Cursor = System.Windows.Forms.Cursors.Hand;
            this.chatclose.FlatAppearance.BorderSize = 0;
            this.chatclose.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.chatclose.ForeColor = System.Drawing.Color.Transparent;
            this.chatclose.Image = global::pol_pass.Properties.Resources.back;
            this.chatclose.Location = new System.Drawing.Point(5, 153);
            this.chatclose.Name = "chatclose";
            this.chatclose.Size = new System.Drawing.Size(86, 34);
            this.chatclose.TabIndex = 16;
            this.chatclose.UseVisualStyleBackColor = false;
            this.chatclose.Visible = false;
            this.chatclose.Click += new System.EventHandler(this.chatclose_Click);
            // 
            // home
            // 
            this.home.BackColor = System.Drawing.Color.Transparent;
            this.home.BackgroundImage = global::pol_pass.Properties.Resources.butback;
            this.home.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch;
            this.home.Cursor = System.Windows.Forms.Cursors.Hand;
            this.home.FlatAppearance.BorderSize = 0;
            this.home.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.home.ForeColor = System.Drawing.Color.Transparent;
            this.home.Image = global::pol_pass.Properties.Resources.home1;
            this.home.Location = new System.Drawing.Point(3, 119);
            this.home.Name = "home";
            this.home.Size = new System.Drawing.Size(91, 34);
            this.home.TabIndex = 33;
            this.home.UseVisualStyleBackColor = false;
            this.home.Visible = false;
            this.home.Click += new System.EventHandler(this.home_Click);
            // 
            // error1
            // 
            this.error1.BackgroundImage = global::pol_pass.Properties.Resources.butback;
            this.error1.Image = global::pol_pass.Properties.Resources.error1;
            this.error1.Location = new System.Drawing.Point(42, 227);
            this.error1.Name = "error1";
            this.error1.Size = new System.Drawing.Size(149, 92);
            this.error1.TabIndex = 31;
            this.error1.TabStop = false;
            this.error1.Visible = false;
            // 
            // logout
            // 
            this.logout.BackColor = System.Drawing.Color.Transparent;
            this.logout.BackgroundImage = global::pol_pass.Properties.Resources.butback;
            this.logout.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch;
            this.logout.Cursor = System.Windows.Forms.Cursors.Hand;
            this.logout.FlatAppearance.BorderSize = 0;
            this.logout.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.logout.ForeColor = System.Drawing.Color.Transparent;
            this.logout.Image = global::pol_pass.Properties.Resources.logout;
            this.logout.Location = new System.Drawing.Point(95, 86);
            this.logout.Name = "logout";
            this.logout.Size = new System.Drawing.Size(127, 32);
            this.logout.TabIndex = 15;
            this.logout.UseVisualStyleBackColor = false;
            this.logout.Visible = false;
            this.logout.Click += new System.EventHandler(this.logout_Click);
            // 
            // chat
            // 
            this.chat.BackColor = System.Drawing.Color.Transparent;
            this.chat.BackgroundImage = global::pol_pass.Properties.Resources.butback;
            this.chat.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch;
            this.chat.Cursor = System.Windows.Forms.Cursors.Hand;
            this.chat.FlatAppearance.BorderSize = 0;
            this.chat.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.chat.ForeColor = System.Drawing.Color.Transparent;
            this.chat.Image = global::pol_pass.Properties.Resources.chat;
            this.chat.Location = new System.Drawing.Point(3, 85);
            this.chat.Name = "chat";
            this.chat.Size = new System.Drawing.Size(91, 34);
            this.chat.TabIndex = 12;
            this.chat.UseVisualStyleBackColor = false;
            this.chat.Visible = false;
            this.chat.Click += new System.EventHandler(this.chat_Click);
            // 
            // pass
            // 
            this.pass.BackColor = System.Drawing.Color.Transparent;
            this.pass.BackgroundImage = global::pol_pass.Properties.Resources.butback;
            this.pass.Image = global::pol_pass.Properties.Resources.pw;
            this.pass.Location = new System.Drawing.Point(12, 142);
            this.pass.Name = "pass";
            this.pass.Size = new System.Drawing.Size(117, 17);
            this.pass.TabIndex = 30;
            this.pass.TabStop = false;
            // 
            // user
            // 
            this.user.BackColor = System.Drawing.Color.Transparent;
            this.user.BackgroundImage = global::pol_pass.Properties.Resources.butback;
            this.user.Image = global::pol_pass.Properties.Resources.un;
            this.user.Location = new System.Drawing.Point(12, 96);
            this.user.Name = "user";
            this.user.Size = new System.Drawing.Size(117, 17);
            this.user.TabIndex = 29;
            this.user.TabStop = false;
            // 
            // pictureBox1
            // 
            this.pictureBox1.BackgroundImage = global::pol_pass.Properties.Resources.active_nav_border3;
            this.pictureBox1.Image = global::pol_pass.Properties.Resources.logo1;
            this.pictureBox1.Location = new System.Drawing.Point(12, 12);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(194, 50);
            this.pictureBox1.TabIndex = 28;
            this.pictureBox1.TabStop = false;
            // 
            // pictureBox3
            // 
            this.pictureBox3.BackgroundImage = global::pol_pass.Properties.Resources.bvback;
            this.pictureBox3.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch;
            this.pictureBox3.Image = global::pol_pass.Properties.Resources.bv;
            this.pictureBox3.Location = new System.Drawing.Point(12, 356);
            this.pictureBox3.Name = "pictureBox3";
            this.pictureBox3.Size = new System.Drawing.Size(206, 16);
            this.pictureBox3.TabIndex = 25;
            this.pictureBox3.TabStop = false;
            // 
            // login
            // 
            this.login.BackColor = System.Drawing.Color.WhiteSmoke;
            this.login.BackgroundImage = global::pol_pass.Properties.Resources.butback;
            this.login.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch;
            this.login.Cursor = System.Windows.Forms.Cursors.Hand;
            this.login.FlatAppearance.BorderSize = 0;
            this.login.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.login.ForeColor = System.Drawing.Color.Transparent;
            this.login.Image = global::pol_pass.Properties.Resources.playnow1;
            this.login.Location = new System.Drawing.Point(95, 184);
            this.login.Name = "login";
            this.login.Size = new System.Drawing.Size(128, 34);
            this.login.TabIndex = 0;
            this.login.UseVisualStyleBackColor = false;
            this.login.Click += new System.EventHandler(this.button1_Click);
            // 
            // pictureBox2
            // 
            this.pictureBox2.BackgroundImage = global::pol_pass.Properties.Resources.active_nav_border3;
            this.pictureBox2.Location = new System.Drawing.Point(-11, -11);
            this.pictureBox2.Name = "pictureBox2";
            this.pictureBox2.Size = new System.Drawing.Size(1983, 87);
            this.pictureBox2.TabIndex = 23;
            this.pictureBox2.TabStop = false;
            // 
            // success
            // 
            this.success.BackgroundImage = global::pol_pass.Properties.Resources.butback;
            this.success.Image = global::pol_pass.Properties.Resources.success2;
            this.success.Location = new System.Drawing.Point(24, 224);
            this.success.Name = "success";
            this.success.Size = new System.Drawing.Size(182, 101);
            this.success.TabIndex = 32;
            this.success.TabStop = false;
            this.success.Visible = false;
            // 
            // bv
            // 
            this.bv.BackColor = System.Drawing.Color.Transparent;
            this.bv.BackgroundImage = global::pol_pass.Properties.Resources.side1;
            this.bv.Location = new System.Drawing.Point(-16, 5);
            this.bv.Name = "bv";
            this.bv.Size = new System.Drawing.Size(1940, 685);
            this.bv.TabIndex = 24;
            this.bv.TabStop = false;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.WhiteSmoke;
            this.BackgroundImageLayout = System.Windows.Forms.ImageLayout.None;
            this.ClientSize = new System.Drawing.Size(233, 382);
            this.Controls.Add(this.soe);
            this.Controls.Add(this.reboot);
            this.Controls.Add(this.chatclose);
            this.Controls.Add(this.home);
            this.Controls.Add(this.error1);
            this.Controls.Add(this.logout);
            this.Controls.Add(this.chat);
            this.Controls.Add(this.pass);
            this.Controls.Add(this.user);
            this.Controls.Add(this.pictureBox1);
            this.Controls.Add(this.pictureBox3);
            this.Controls.Add(this.SessionID);
            this.Controls.Add(this.tracer);
            this.Controls.Add(this.error);
            this.Controls.Add(this.password);
            this.Controls.Add(this.username);
            this.Controls.Add(this.ffxiboot);
            this.Controls.Add(this.loadwindow);
            this.Controls.Add(this.login);
            this.Controls.Add(this.pictureBox2);
            this.Controls.Add(this.chatBrowser);
            this.Controls.Add(this.success);
            this.Controls.Add(this.bv);
            this.DoubleBuffered = true;
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.ImeMode = System.Windows.Forms.ImeMode.Off;
            this.Name = "Form1";
            this.RightToLeft = System.Windows.Forms.RightToLeft.No;
            this.Text = "FFXI-A";
            ((System.ComponentModel.ISupportInitialize)(this.soe)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.error1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pass)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.user)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox3)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox2)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.success)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.bv)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button login;
        private System.Windows.Forms.RichTextBox loadwindow;
        private System.Windows.Forms.TextBox ffxiboot;
        private System.Windows.Forms.TextBox username;
        private System.Windows.Forms.TextBox password;
        private System.Windows.Forms.Label error;
        private System.Windows.Forms.WebBrowser chatBrowser;
        private System.Windows.Forms.Button chat;
        private System.Windows.Forms.TextBox tracer;
        private System.Windows.Forms.Label SessionID;
        private System.Windows.Forms.Button logout;
        private System.Windows.Forms.Button chatclose;
        private System.Windows.Forms.PictureBox pictureBox2;
        private System.Windows.Forms.PictureBox bv;
        private System.Windows.Forms.PictureBox pictureBox3;
        private System.Windows.Forms.PictureBox pictureBox1;
        private System.Windows.Forms.PictureBox user;
        private System.Windows.Forms.PictureBox pass;
        private System.Windows.Forms.PictureBox error1;
        private System.Windows.Forms.PictureBox success;
        private System.Windows.Forms.Button home;
        private System.Windows.Forms.Button reboot;
        private System.Windows.Forms.PictureBox soe;
    }
}

