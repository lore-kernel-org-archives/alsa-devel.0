From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/7] Audio support for Armada 370 DB
Date: Mon, 10 Feb 2014 18:25:19 +0000
Message-ID: <20140210182519.GD13533@sirena.org.uk>
References: <1391102051-5319-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140210152141.1391fb67@skate>
 <20140210145729.GP1757@sirena.org.uk>
 <20140210160432.27281741@skate>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2928851434132119112=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C5002625ED
 for <alsa-devel@alsa-project.org>; Mon, 10 Feb 2014 19:25:38 +0100 (CET)
In-Reply-To: <20140210160432.27281741@skate>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Liam Girdwood <lgirdwood@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2928851434132119112==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4zI0WCX1RcnW9Hbu"
Content-Disposition: inline


--4zI0WCX1RcnW9Hbu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 10, 2014 at 04:04:32PM +0100, Thomas Petazzoni wrote:

> Sure, sorry. The patches that are of interest to you are prefixed by
> "sound: codec" (for the patch touching sound/soc/codecs) and "sound:
> soc" (for the patches touching sound/soc/kirkwood).

> If you want, I can resend with subject lines containing 'ASoC:',
> however maybe it's better if some other comments are made before, to
> avoid additional noise.

It's OK, they are on the list and I will get to them (most likely
tomorrow now) - I did notice them.

--4zI0WCX1RcnW9Hbu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS+RmMAAoJELSic+t+oim9pL8P/0cBnfKSc5Q5RhXaVdsdaw3R
j10LWl9pCZsihVVWwiZmoXx/qpcbxnrZ1OquL5c754jGWBBzL71MttX21bJ+BjL1
L0z30CiHIoF0gVkO9U9MxElYY1Dmy6puNiufF89L44JCOCEQKVtju0ypJG8T29P+
00U+RfvotDy+QOD6bj5Jry3EFLZcWrWk+QB4PNfwX7awhtYHfjAmtMPl76RdwDpG
Pwi+4tEHsB6BVRF2m3V6qOhBze5LpgWpXyLQMedfviddHXm60XqA8Yu9dQU0M1hl
4/ZcTQnyp4a3sZtVaibIwDW+JWsZhJt41/60Krsi6EaLfKQb6z+RwY43IQs3w1+r
/vLNvw9P+e0vzf6HGiZISc0DIneqcB3K9PjsJDBNxWRnGPw/J4DpqxdzgJwWZOM8
eRGmVdfqMKLyBTCLeiXd5MFjfkVjsh+oK3EimcZ29075Trh4wKKssv3J9w3JtLwn
8UBd8EVn4IYhc+B0YREbIpLAgbZV676Ukdro/iUDmDU3esRkQxYBVBKu+es6IvdO
GVD5/t3IMRnwJTT2Ye22Vne50SEWIYmv6tWl2HGkymzecq1Q58L2MClqC6FUIa9J
Pr1WfTXBdwguu47pcbImgEigTXwucc3i7mzRkyiWz5j281cSb3lPENAd+R8XQKbC
26DpzbpN5iRzmgxmgENT
=ubRe
-----END PGP SIGNATURE-----

--4zI0WCX1RcnW9Hbu--

--===============2928851434132119112==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2928851434132119112==--
