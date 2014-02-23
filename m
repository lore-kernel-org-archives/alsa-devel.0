From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 077/102] ASoC: cs42l73: Use
	SOC_ENUM_SINGLE_DECL()
Date: Sun, 23 Feb 2014 12:05:32 +0900
Message-ID: <20140223030532.GR25940@sirena.org.uk>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
 <1392723517-12772-50-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4488507933871233366=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 78C6A265937
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 04:06:07 +0100 (CET)
In-Reply-To: <1392723517-12772-50-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4488507933871233366==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E5Kv0g4zpMKTBL4W"
Content-Disposition: inline


--E5Kv0g4zpMKTBL4W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:38:33PM +0100, Takashi Iwai wrote:
> Just replace with the helper macro.  No functional change at all.

Applied, thanks.

--E5Kv0g4zpMKTBL4W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCWV5AAoJELSic+t+oim9SxcQAIG5DdZCHxj5Pqj+Db1NiLfx
MkbS1LmPYLTLXrL83nLaVhEORSidNSqb38Pu5I47W8WilQws05QkouQBK9Gv4bU4
yK/fcjvDxNomjlsk0G4CEzsWz6YJRjcyk6JOy4d7WprKycrjoXHHwX3yTsaqnAGr
R8QZhH+xusWCrOeHy0fqh6joBKt2/B3qhxFkWCTJ7HOZMRRHYJmc50JeYEKDKV10
W1ZU3HXqyOukr4oHM9wNACA1NaK9ab9eVeSjYmAR66uThslEYF4TLOGnAF/7XPUU
iA5uNeuwK5NEP6SAEi7HwPvE756BMV4WherQnem6IKP9FoAWIqj398fWin7vTFay
2+waTUTAHuo5THpfRt+Mo4jD6vjuqeLd3MfuVnjJkVHJjoySO414Y2EG4AyqMm3D
Qt+X+r4w7kvpwjzu9z6A2hrqoaJlxrJIXihJlyw0cpnHVwRxxxWnG/+k5fE5yQ+d
5LVh1Pst+lCtrZ5kbr6WIGhiLvPoT7t4uI3fvL7EPS9xJN1C/sQcRceMsEFg8B7u
O+XhDSBausn5D+2/Xjju9ptnOGXmrNIZb+DxwGrZUSvkuBobNUbovPTDgbUbih3N
+THknN7BltNybYSJ1aQ8rKwy1W0CW/tz4nt9bp3F1plehBf1vm7PYSWhd8/cOpfo
rbmLUSokEMyP1BYl+mMs
=ZrYH
-----END PGP SIGNATURE-----

--E5Kv0g4zpMKTBL4W--

--===============4488507933871233366==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4488507933871233366==--
