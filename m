From: Michael Gerdau <mgd@technosis.de>
Subject: Aureon 7.1 Firewire supported by ALSA ?
Date: Fri, 4 May 2007 08:08:16 +0200
Message-ID: <200705040808.30501.mgd@technosis.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2140938282360270839=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server021.webpack.hosteurope.de
	(server021.webpack.hosteurope.de [80.237.130.29])
	by alsa0.perex.cz (Postfix) with ESMTP id 0927724423
	for <alsa-devel@alsa-project.org>;
	Fri,  4 May 2007 08:08:30 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============2140938282360270839==
Content-Type: multipart/signed;
  boundary="nextPart2006129.KhR1ZE9sdS";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2006129.KhR1ZE9sdS
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi list,

looking for an external (USB or Firewire) interface to record at
least a single stereo 44.1kHz/24bit S/P-DIF signal I've come
across the Aureon 7.1 Firewire but have not been able to find out
whether it is already supported by ALSA.

Another option would be the Aureon 5.1 USB MKII but according to
the specs it is 16bit only. However when feeding S/P-DIF with a
stereo 44.1kHz/24bit would the driver be recognize that and give
me that signal unaltered or would it be trimmed to 16bit ?
[Or is my understanding of S/P-DIF just plain wrong and such a
signal would not go through the box at all ?]

Any advice welcome, best,
Michael

=2D-=20
 Technosis GmbH, Gesch=E4ftsf=FChrer: Michael Gerdau, Tobias Dittmar
 Sitz Hamburg; HRB 89145 Amtsgericht Hamburg
 Vote against SPAM - see http://www.politik-digital.de/spam/
 Michael Gerdau       email: mgd@technosis.de
 GPG-keys available on request or at public keyserver

--nextPart2006129.KhR1ZE9sdS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBGOs3eUYYhyuxDQc4RAsMYAJwIq43GWkGETOAj0Uz/l1vqw/lxXgCfT610
b5zxx6EOILK098ovZlnq20U=
=nCiU
-----END PGP SIGNATURE-----

--nextPart2006129.KhR1ZE9sdS--

--===============2140938282360270839==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2140938282360270839==--
