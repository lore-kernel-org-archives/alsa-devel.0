From: "Mirabella, Mathew J" <Mathew.Mirabella@team.telstra.com>
Subject: FW: Fix for front speaker output on Audigy2
Date: Fri, 28 Mar 2003 12:09:48 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <73388857A695D31197EF00508B08F2980A00EEA6@ntmsg0131.corpmail.telstra.com.au>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
content-class: urn:content-classes:message
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel list <alsa-devel@lists.sourceforge.net>, alsa-user list <alsa-user@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


>Hi, this patch enables output from the front speakers on Audigy2 cards. =
I've removed the=20
>rubbish I had for disabling the AC97 codec mixer.
snip.

Can you tell me if this is now in the cvs snapshot?  I have an audigy 2 =
and have had these kinds of difficulties and wish to use alsa to get it =
working.  Are there any special settings or commands i should know about =
for the audigy 2 in particular?  i just check out the cvs for drivers, =
utils, libs and kernel and then do the ./cvscompile for drivers, libs =
and then utils, and then edit modules.conf  and a few other things with =
the mixer... should this be all?

Thanks.

mat.





-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
