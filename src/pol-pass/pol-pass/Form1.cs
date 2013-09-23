using System;
using System.IO;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Net;
using System.Diagnostics;
using System.Collections.Specialized;
using System.Runtime.InteropServices;
using System.Timers;

namespace pol_pass
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();

            string fileName = @"ffxi-boot.ini";
            string curFile = @"ROM9\6\118.DAT";
            string curFile1 = @"ROM9\8\11.DAT";
            string curFile2 = @"ROM9\FTABLE9.DAT";
            Console.WriteLine(File.Exists(fileName) ? true : false);
            if (File.Exists(fileName) == false)
            {
                error.Text = "No ffxi-boot.ini";
                return;
            }

            Console.WriteLine(File.Exists(curFile) ? true : false);
            Console.WriteLine(File.Exists(curFile1) ? true : false);
            Console.WriteLine(File.Exists(curFile2) ? true : false);
            if (File.Exists(curFile) == false || File.Exists(curFile1) == false || File.Exists(curFile2) == false)
            {
                error.Text = "Seekers Not Found";
                login.Visible = false;
                user.Visible = false;
                pass.Visible = false;
                username.Visible = false;
                password.Visible = false;
                soe.Visible = true;
                this.Width = 1250;
                this.Height = 620;
                this.chatBrowser.ScrollBarsEnabled = false;

                this.chatBrowser.Visible = true;

                this.chatBrowser.Navigate("http://ffxi-a.com/no-pol/index.php");
           
       
                return;
            }
            ffxiboot.Text = fileName;
            this.Width = 248;
            this.Height = 425;
            StreamReader sr = new StreamReader(ffxiboot.Text);
            loadwindow.Text = sr.ReadToEnd();
            sr.Close();
          
        }




        protected override void OnFormClosing(FormClosingEventArgs e)
        {
            this.chatBrowser.Navigate("http://ffxi-a.com/no-pol-exit.php?id=" + SessionID.Text + "&password=" + password.Text + "&username=" + username.Text + "");
       
            

            
            
                    string curFile = @"logout-no-pol.exe";
                    Console.WriteLine(File.Exists(curFile) ? true : false);
            base.OnFormClosing(e);
                    if (File.Exists(curFile) == false)
                    {
                        error.Text = "logout-no-pol.exe";
                       
                        return;
                    }
                    Process.Start("logout-no-pol.exe");

                   
                
            
        }
        private void button1_Click(object sender, EventArgs e)
        {

            string urlAddress = "http://ffxi-a.com/no-pol-login.php";

            
            using (WebClient client = new WebClient())
            {
                NameValueCollection postData = new NameValueCollection() 
                { 
                   { "username", username.Text },  
                   { "password", password.Text },
                  
                };



                string result = Encoding.UTF32.GetString(client.UploadValues(urlAddress, postData));
                error.Text = result;
                tracer.Text = result;

                if (error.Text == "���������")
                {
                    tracer.Text = result;
                    error.Text = "Username or Password is incorrect!";
                    error1.Visible = true;
                }
                else
                {
                    reboot.Visible = true;
                    error1.Visible = false;
                    chat.Visible = true;
                    home.Visible = true;
                    logout.Visible = true;
                    user.Visible = false;
                    pass.Visible = false;
                    username.Visible = false;
                    password.Visible = false;
                    login.Visible = false;
                    string cleanresult = Encoding.Default.GetString(client.UploadValues(urlAddress, postData));
                    SessionID.Text = cleanresult;
                    tracer.Text = cleanresult;
                    success.Visible = true;
                    
                    StreamWriter sw = new StreamWriter(ffxiboot.Text, false);
                    sw.WriteLine("[SERVER] \n SERVIP = ffxi-a.com \n " + "AUTOLOGIN = 1 \n " + " USERNAME = " + username.Text + " \n PASSWORD = " + password.Text + " \n [CLIENT] \n LANGUAGE = 1 \n VERSION = NA \n X_RES = 800 \n Y_RES = 600 \n");
                    sw.Close();

                    string curFile = @"no-pol.exe";
                    Console.WriteLine(File.Exists(curFile) ? true : false);
                    if (File.Exists(curFile) == false)
                    {
                        error.Text = "no-pol.exe";
                        
                        return;
                    }
                    Process.Start("no-pol.exe");
                }
            }
            
            
        }

        private void username_TextChanged(object sender, EventArgs e)
        {
            error.Visible = false;

            
        }

        private void password_TextChanged(object sender, EventArgs e)
        {
            error.Visible = false;
        }


        
       

      

        

        private void chat_Click(object sender, EventArgs e)
        {


            
           
            chatclose.Visible = true;
            this.Width = 1250;
            this.Height = 620;
            this.chatBrowser.ScrollBarsEnabled = false;
           
            this.chatBrowser.Visible = true;
           
            this.chatBrowser.Navigate("http://ffxi-a.com/gethelp.php?id=" +SessionID.Text + "&password=" + password.Text + "&username=" + username.Text + "");
        }

        private void logout_Click(object sender, EventArgs e)
        {
            this.webcall.Navigate("http://ffxi-a.com/no-pol-exit.php?id=" + SessionID.Text + "&password=" + password.Text + "&username=" + username.Text + "");

            string curFile = @"logout-no-pol.exe";
            Console.WriteLine(File.Exists(curFile) ? true : false);
           
            if (File.Exists(curFile) == false)
            {
                error.Text = "logout-no-pol.exe";

                return;
            }
            Process.Start("logout-no-pol.exe");
           // this.Close();
           //CLOSE GAME
        }

        private void chatclose_Click(object sender, EventArgs e)
        {
            
            
            chatclose.Visible = false;

            this.Width = 248;
            this.Height = 425;
        }

       


        private void exit2_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void exit1_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void home_Click(object sender, EventArgs e)
        {
            
            chatclose.Visible = true;
            this.Width = 1250;
            this.Height = 620;
            this.chatBrowser.ScrollBarsEnabled = false;

            this.chatBrowser.Visible = true;

            this.chatBrowser.Navigate("http://ffxi-a.com/no-pol/no-pol.swf?mysession=" + SessionID.Text + "&mypassword=" + password.Text + "&myusername=" + username.Text + "");
           
        }

        private void button1_Click_1(object sender, EventArgs e)
        {
            this.webcall.Navigate("http://ffxi-a.com/no-pol-reboot.php?id=" + SessionID.Text + "&password=" + password.Text + "&username=" + username.Text + "");
       
            //RELAUNCH
            string curFile = @"no-pol.exe";
            Console.WriteLine(File.Exists(curFile) ? true : false);
            if (File.Exists(curFile) == false)
            {
                error.Text = "no-pol.exe";

                return;
            }
            Process.Start("no-pol.exe");
        }

       
    }
}
