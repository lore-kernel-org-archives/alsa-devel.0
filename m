From: Giuliano Pochini <pochini@shiny.it>
Subject: RE: [ALSA - driver 0000540]: alsa driver will no longer function
Date: Mon, 27 Sep 2004 10:48:08 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20040927104808.pochini@shiny.it>
References: <20040925130336.2AE072014E@server.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from denise.shiny.it (denise.shiny.it [194.20.232.1])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id BAF7222A
	for <alsa-devel@alsa-project.org>; Mon, 27 Sep 2004 10:48:09 +0200 (MEST)
Received: from agnus (agnus.shiny.it [194.20.232.6])
	by denise.shiny.it (8.11.7/8.11.6) with ESMTP id i8R8m8605622
	for <alsa-devel@alsa-project.org>; Mon, 27 Sep 2004 10:48:08 +0200
In-Reply-To: <20040925130336.2AE072014E@server.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On 25-Sep-2004 bugtrack@alsa-project.org wrote:
>=20
> The following bug has been SUBMITTED.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=3D0=
000540
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [...]
> How reproducible:
> in XMMS, select Alsa driver, attempt to play an mp3/cd, get:
>=20
> Please check that the sound card is configured properly and You have th=
e
> correct output plugin selected and no other program is blocking the
> soundcard.

The xmms plugin doesn't work well. I also am using
version 1.2.9 with a patch that removes mixer support,
because it is the source of the problem. 1.2.10 had
another problem that I don't remember now, but I will
try it again if you're interested.



--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
