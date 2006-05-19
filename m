From: vincent Guittot <vincent.guittot@yahoo.fr>
Subject: audio stream other than pcm
Date: Fri, 19 May 2006 07:39:44 +0000 (GMT)
Message-ID: <20060519073944.15025.qmail@web27312.mail.ukl.yahoo.com>
Reply-To: vincent Guittot <vincent.guittot@yahoo.fr>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="0-2111093745-1148024384=:97547"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--0-2111093745-1148024384=:97547
Content-Type: text/plain; charset=us-ascii

Hi, 
 
I'm trying to develop an alsa driver for an embedded audio card which includes some hardware codec. I would like to use alsa for handling the whole audio card : mixer, pcm and hardware codec. Right now, I have no major issue with the mixer and the pcm stream but several question about how alsa behaves with an encoded audio stream. Several audio format are already defined in the sndrv_pcm_format enum but i can't find any details about how the period size and the elapse notification is handled with encoded data . Where can i find some details ? is there any alsa sound cards driver which already manage encoded audio stream ?
 
Regards,
Vincent
--0-2111093745-1148024384=:97547
Content-Type: text/html; charset=us-ascii

<html><head><style type="text/css"><!-- DIV {margin:0px} --></style></head><body><div style="font-family:times new roman, new york, times, serif;font-size:12pt"><DIV style="FONT-SIZE: 12pt; FONT-FAMILY: times new roman, new york, times, serif">
<DIV style="FONT-SIZE: 12pt; FONT-FAMILY: times new roman, new york, times, serif">
<DIV>Hi, </DIV>
<DIV>&nbsp;</DIV>
<DIV>I'm trying to develop an alsa driver for an embedded audio card which includes some hardware codec. I would like to use alsa for handling the whole audio card : mixer, pcm and hardware codec. Right now, I have no major issue with the mixer and the pcm stream but several question about how alsa behaves with an&nbsp;encoded audio stream. Several audio format are already defined in the sndrv_pcm_format enum but i can't find any details about how&nbsp;the period size and the elapse notification is handled with encoded data&nbsp;. Where can i find some details ? is there any alsa sound cards driver which already manage encoded audio stream ?</DIV>
<DIV>&nbsp;</DIV>
<DIV>Regards,</DIV>
<DIV>Vincent</DIV></DIV></DIV></div></body></html>
--0-2111093745-1148024384=:97547--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
