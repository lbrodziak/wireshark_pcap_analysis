<h1>Pcap file analysis with wireshark</h1>

<h2>Description</h2>
This project was done as one of the challenges on Hack the box. The overall task was to analyse provided pcap file and find the hidden flag. As, at the time of creating of this write up, the challenge is active I won't post the flag value here.
<br />


<h2>Languages and Utilities Used</h2>

- <b>Wireshark</b>
- <b>Powershell</b> 

<h2>Environments Used </h2>

- <b>Windows Server 2022</b>

<h2>Project walk-through:</h2>

First thing after downloading the files from HTB was to open it in Wireshark.
<p align="center">
<img src="https://imgur.com/HERM6AQ.png"height="80%" width="80%" alt="Pcap file"/>
<br />
<br />
The file contains information about many failed attempts to access files used by Aoache server (all ended with 404 HTTP response code). But there were also POST request containing php code with shell_exec command and base64 string:  <br/>
<img src="https://imgur.com/0Khi9oQ.png" height="80%" width="80%" alt="PHP code injection"/>
<br />
<br />
Decoding them using Cybechef website revealed that they are in fact Powershell commands:
<img src="https://imgur.com/fkKsH9j.png" height="80%" width="80%" alt="encoded powershell script"/>
<br />
<br />
As revealed in cyberchef the code picked up files from submitted path compressed the stream and converted it to base64. This meant that somewhere in the file should be a response containing the requested base64 string. After discovering one of such responses that contained "HTTP/1.1 302 Found  (text/html)" phrase in "Info" column I filtered out all entries with that value.<br/>
<img src="https://imgur.com/lxN773T.png" height="80%" width="80%" alt="Filtered wireshark file preview"/>
<br />
<br />
After extracting the Base64 strings from the entries I fed each of them into the script which converted base64 into ansi string and then decompressed it I was able to reveal the flag in one of the entries<br/>
<img src="https://github.com/user-attachments/assets/b9300232-1c9c-4c55-a424-6c9241ddc39f" height="80%" width="80%" alt="Filtered wireshark file preview"/>

