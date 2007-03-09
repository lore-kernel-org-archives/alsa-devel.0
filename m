From: "raghvendra misra" <raghvendramisra@gmail.com>
Subject: regarding sound problem in snd-hda-intel
Date: Fri, 9 Mar 2007 15:26:45 +0530
Message-ID: <3412cfd30703090156m60583c6am62bf66da58143ea8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1931059254=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--===============1931059254==
Content-Type: multipart/alternative;
	boundary="----=_Part_15853_18911324.1173434205115"

------=_Part_15853_18911324.1173434205115
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi
    i am using RTLinux.But here i am not able to play any sound.
   so i downloaded the alsa driver 'alsa-driver-1.0.9rc4' along with the lib
and utlis files.
 I followed the following steps given on ur site

    In a shell type these commands:

Make a directory to store the alsa source code in.

        cd /usr/src
        mkdir alsa
        cd alsa
        cp /downloads/alsa-* .

Now unzip and install the alsa-driver package

        bunzip2 alsa-driver-xxx
        tar -xf alsa-driver-xxx
        cd alsa-driver-xxx
        ./configure --with-cards=hda-intel
--with-sequencer=yes;make;make install





i followed these steps .but after giving ./config when i gave make it
showed error.

can u please help me in finding out the problem



Thanks & Regards



Raghvendra

------=_Part_15853_18911324.1173434205115
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>hi </div>
<div>&nbsp;&nbsp;&nbsp; i am using RTLinux.But here i am not able to play any sound.&nbsp; </div>
<div>&nbsp;&nbsp; so i downloaded the alsa driver &#39;<font face="Times New Roman">alsa-driver-1.0.9rc4&#39; along with the lib and utlis files. </font></div>
<div><font face="Times New Roman">&nbsp;I followed the following steps given on ur site</font></div>
<div><font face="Times New Roman"></font>&nbsp;</div>
<div><font face="Times New Roman">&nbsp;&nbsp;&nbsp; In a shell type these commands: 
<p>Make a directory to store the alsa source code in. 
<p><pre>        cd /usr/src
        mkdir alsa
        cd alsa
        cp /downloads/alsa-* .
</pre>Now unzip and install the alsa-driver package 
<p><pre>        bunzip2 alsa-driver-xxx
        tar -xf alsa-driver-xxx
        cd alsa-driver-xxx
        ./configure --with-cards=hda-intel --with-sequencer=yes;make;make install
</pre><pre>&nbsp;</pre><pre>&nbsp;</pre><pre>i followed these steps .but after giving ./config when i gave make it showed error.</pre><pre>can u please help me in finding out the problem </pre><pre>&nbsp;</pre><pre>Thanks &amp; Regards
</pre><pre>&nbsp;</pre><pre>Raghvendra</pre><pre>&nbsp;</pre></p></p></p></font></div>

------=_Part_15853_18911324.1173434205115--


--===============1931059254==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1931059254==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1931059254==--
