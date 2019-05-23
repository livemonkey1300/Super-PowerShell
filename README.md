<h1>Powershell</h1>
<p align="left">
  <img src="docs/display_console.JPG" width="350" title="hover text">
</p>

<h2>Information</h2>
<p>
<strong>Installation</strong>
<p>
On windows if you have install git run the following command: <br><br>
<code>git clone https://github.com/livemonkey1300/Super-PowerShell.git </code><br><br>
If git is not install on you PC please copy paste the following link into your browser or click on the link bellow
<a href="https://github.com/livemonkey1300/Super-PowerShell/archive/master.zip">https://github.com/livemonkey1300/Super-PowerShell/archive/master.zip</a>
</p>
<br>
<br>
<strong>Usage</strong>
<ul>
<li>
<p>
1 : Open a command prompt and navigate to the directory created by eiter extrating the file or pulling this repo Type the following command<br><br>
<code style="background: #002456;color: white;" >powershell.exe </code><br><br>
Make sure you located in the correct directory <br>
</p>
</li>
<li>
  <p>
  2 : Type the following command to access you tool menu<br><br>
  <code style="background: #002456;color: white;">PS C:\Users\ > <strong>.\Basic_sets.ps1</strong></code><br><br>
  The menu from the the image should pop up<br>
  </p>
  </li>
<li>
  <p>
  3 : Select one of the option from the menu</p>
  </li>
<li>
  <p>
  4 : To exit the tool type q in the main menu</p>
  <p><br />
</li></ul>
<p><br />
</p>
  <strong>Option 1 : Install New Services</strong></p>
<p>Description:</p>
<p>By selecting option one , a panel will open showing all the windows feature not currently installed</p>
<p>by selecting one of the option , all the sub-feature from that services and management tools will be installed.</p>
<p>&nbsp;</p>
<p><strong>Option 2 : Select a server </strong></p>
<p>Description:</p>
<p>This option contains no option yet it's a beta</p>
<p>&nbsp;</p>
<p><strong>Option 3 : Create New IIS Sites</strong></p>
<p>Requirement:</p>
<p>Windows DNS feature install on the current operation system</p>
<p>Windows IIS feature install on the current operation system </p>
<p>Description:</p>
<p>This options setup a new website inside the default app pool</p>
<p>In the process a new directory located in C:\inetpub\wwwroot\ will be created with the name of your domain</p>
<p>Finally, a DNS zone with an A record will be created on the local DNS server, pointing to localhost 127.0.0.1 where local website testing can be conduct </p>
<p>&nbsp;</p>
<p><strong>Option 4 : List IIS Sites</strong></p>
<p>Description:</p>
<p>This option will only list the site currently available on the server</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<h1>Warning</h1>
<p>This is not a fully completed powershell , in no case it should be use withing an infrastucture until completion , or  if it's modify by system addriminstator. it's still in the beta phase</p>
