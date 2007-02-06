From: maser rati <maseriyer@yahoo.com>
Subject: Question about AT73C213.conf
Date: Mon, 5 Feb 2007 17:05:23 -0800 (PST)
Message-ID: <546450.61027.qm@web37713.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0576051071=="
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

--===============0576051071==
Content-Type: multipart/alternative; boundary="0-1775526355-1170723923=:61027"
Content-Transfer-Encoding: 7bit

--0-1775526355-1170723923=:61027
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,=20
=20
 We are trying to get the audio chip (AT73C213) that comes on the AT91SAM=
9261-EK development board working. alsa-lib and alsa-utils, version 1.0.1=
2 are currently installed.=20
=20
# aplay -l shows that the audio chip is recognized as a playback device (=
and has a driver).
 # aplay -L fails; there aren't any PCM devices configured.
 # alsaconf fails too.=20
=20
 We can't seem to find .conf files for any Atmel chips among the Alsa doc=
s and files. =20
=20
 I assume the missing .conf file is the issue. Has anyone been successful=
 with this?=20
 =20
 Thanks,=20
iyer
=20
---------------------------------
Never miss an email again!
Yahoo! Toolbar alerts you the instant new Mail arrives. Check it out.
--0-1775526355-1170723923=:61027
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<span class=3D"postbody">Hello, <br> <br> We are trying to get the audio =
chip (AT73C213) that comes on the AT91SAM9261-EK development board workin=
g. alsa-lib and alsa-utils, version 1.0.12 are currently installed. <br> =
<br># aplay -l shows that the audio chip is recognized as a playback devi=
ce (and has a driver).<br> # aplay -L fails; there aren't any PCM devices=
 configured.<br> # alsaconf fails too. <br> <br> We can't seem to find .c=
onf files for any Atmel chips among the Alsa docs and files.  <br> <br> I=
 assume the missing .conf file is the issue. Has anyone been successful w=
ith this? <br>  <br> Thanks, <br>iyer</span><p>&#32;

<hr size=3D1><a href=3D"http://us.rd.yahoo.com/evt=3D49938/*http://tools.=
search.yahoo.com/toolbar/features/mail/">Never miss an email again!<br>Ya=
hoo! Toolbar</a> alerts you the instant new Mail arrives.<a href=3D"
http://us.rd.yahoo.com/evt=3D49937/*http://tools.search.yahoo.com/toolbar=
/features/mail/"> Check it out.</a>
--0-1775526355-1170723923=:61027--


--===============0576051071==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0576051071==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0576051071==--
