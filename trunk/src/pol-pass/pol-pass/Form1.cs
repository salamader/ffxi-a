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


namespace pol_pass
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();

            string fileName = "ffxi-boot.ini";
            ffxiboot.Text = fileName;
            this.Width = 248;
            this.Height = 425;
            StreamReader sr = new StreamReader(ffxiboot.Text);
            loadwindow.Text = sr.ReadToEnd();
            sr.Close();
        }

        private void button1_Click(object sender, EventArgs e)
        {

            string urlAddress = "http://127.0.0.1/newlogin.php";

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
                    error1.Visible = false;
                    chat.Visible = true;
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
                    sw.WriteLine("[SERVER] \n SERVIP = 127.0.0.1 \n " + "AUTOLOGIN = 1 \n " + " USERNAME = " + username.Text + " \n PASSWORD = " + password.Text + " \n [CLIENT] \n LANGUAGE = 1 \n VERSION = NA \n X_RES = 800 \n Y_RES = 600 \n");
                    sw.Close();
                    

                   // Process.Start("no-pol.exe");
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


            
            chat.Visible = false;
            chatclose.Visible = true;
            this.Width = 1250;
            this.Height = 620;
            this.chatBrowser.ScrollBarsEnabled = false;
           
            this.chatBrowser.Visible = true;
            //http://127.0.0.1/no-pol/test1.swf?myusername=wii&mypassword=123456&mysession=1
            this.chatBrowser.Navigate("http://127.0.0.1/no-pol/test2.swf?mysession=" + SessionID.Text + "&mypassword=" + password.Text + "&myusername=" + username.Text + "");
            //this.chatBrowser.Navigate("127.0.0.1/gethelp.php?id=" +SessionID.Text + "&password=" + password.Text + "&username=" + username.Text + "");
        }

        private void logout_Click(object sender, EventArgs e)
        {
            logout.Visible = true;
            Process.Start("logout-no-pol.exe");
            
            this.Close();
            //CLOSE GAME
        }

        private void chatclose_Click(object sender, EventArgs e)
        {
            
            chat.Visible = true;
            chatclose.Visible = false;

            this.Width = 240;
            this.Height = 380;
        }

       


        private void exit2_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void exit1_Click(object sender, EventArgs e)
        {
            this.Close();
        }

       
    }
}
