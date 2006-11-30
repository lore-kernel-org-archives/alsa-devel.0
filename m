From: "Jean-Charles Quillet" <jeancharles.quillet@gmail.com>
Subject: Software equalizer
Date: Thu, 30 Nov 2006 15:15:29 +0100
Message-ID: <3dd8f9530611300615x3173bb93u36923f2c471e121a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1114446998=="
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

--===============1114446998==
Content-Type: multipart/alternative;
	boundary="----=_Part_17962_15001539.1164896129300"

------=_Part_17962_15001539.1164896129300
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
I'm looking for a way to install a system wide software equalizer on linux.
I'd like to be able to change the settings in real time just like software
equalizers in classical applications like xmms and problably others.
I've been looking around and can't find anything that suits my needs. There
is apparently a LADSPA plugin that would do it but it doesn't seem to work
with ALSA: http://sourceforge.net/mailarchive/message.php?msg_id=37078053
I'm interested in starting to develop something new if nothing like this
exist. I'd like to have somehow a server running and be able to drive it
using different interfaces (command line, graphical). What would be the best
way to go ?
1- develop a plugin for ALSA
2- develop a plugin for JACK and use the alsa plugin for jack to make it
system wide
The first solution seems more straightforward, but the second one could be
more modular.
Any help or comments much appreciated,

Jean-Charles

------=_Part_17962_15001539.1164896129300
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br>I'm looking for a way to install a system wide software
equalizer on linux. I'd like to be able to change the settings in real
time just like software equalizers in classical applications like xmms
and problably others.
<br>I've been looking around and can't find anything that suits my
needs. There is apparently a LADSPA plugin that would do it but it
doesn't seem to work with ALSA: <a href="http://sourceforge.net/mailarchive/message.php?msg_id=37078053" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
http://sourceforge.net/mailarchive/message.php?msg_id=37078053</a><br>I'm
interested in starting to develop something new if nothing like this
exist. I'd like to have somehow a server running and be able to drive
it using different interfaces (command line, graphical). What would be
the best way to go ?
<br>1- develop a plugin for ALSA<br>2- develop a plugin for JACK and use the alsa plugin for jack to make it system wide<br>The first solution seems more straightforward, but the second one could be more modular.<br>Any help or comments much appreciated,
<br><br>Jean-Charles<br clear="all"><br>

------=_Part_17962_15001539.1164896129300--


--===============1114446998==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1114446998==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1114446998==--
