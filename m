From: Orm Finnendahl <finnendahl@folkwang-hochschule.de>
Subject: RME, Alsa, Hdsp
Date: Fri, 14 Feb 2003 21:31:43 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030214203143.GB2704@finnendahl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Paul Davis <paul@linuxaudiosystems.com>
List-Id: alsa-devel@alsa-project.org

Hi,

just a quick note: trying to record using pd (with the new alsa patch
of G=FCnther Geiger) freezes the machine in rotterdam. I'll probably have
to wait 'til monday to have the guys there check whether input with
arecord also freezes the machine. As G=FCnther reported that pd works
well with his (older) rme, we suspect despite the working output
something is still going wrong and the syslog reports of a firmware
download failure might give a clue.

I'll report as soon as I've tested with arecord.

--
Orm


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
