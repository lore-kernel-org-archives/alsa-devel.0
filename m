From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Static build of alsa-lib?
Date: Sat, 30 Aug 2003 21:41:16 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200308302141.16626.adrian@mcmen.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp2.homechoice.co.uk (sc-outsmtp2.homechoice.co.uk [81.1.65.36])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id WAA24282
	for <alsa-devel@alsa-project.org>; Sat, 30 Aug 2003 22:41:08 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Thanks to James I now know a few more of things I need to do to build and=
 test=20
my sound driver on the Dreamcast.

But the system I am installing to is based on a static version of Busybox=
 -=20
there is no glibc (or indeed any other C RTL) available on it. Thus I nee=
d to=20
build anything I install as static.

I can successfully build the alsa-lib with the cross compiling tools I ha=
ve,=20
but can see no easy way to get it to build static - can anybody tell me h=
ow?

Adrian


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
