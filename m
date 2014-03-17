From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsi: fixup compile error for
	simple-card
Date: Mon, 17 Mar 2014 13:20:21 +0000
Message-ID: <20140317132021.GH11706@sirena.org.uk>
References: <5323ad1c.V6m3nhSN8UwkI6jk%fengguang.wu@intel.com>
 <87ppllvexh.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5516024953520007810=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 27B3326168D
 for <alsa-devel@alsa-project.org>; Mon, 17 Mar 2014 14:20:58 +0100 (CET)
In-Reply-To: <87ppllvexh.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============5516024953520007810==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pfTAc8Cvt8L6I27a"
Content-Disposition: inline


--pfTAc8Cvt8L6I27a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 16, 2014 at 05:37:06PM -0700, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> This patches fixes
> c7a507eea1db1430476289f525f9c853d5d485e8
> (ASoC: fsi: fixup SND_SOC_DAIFMT_CBx_CFx flags)
> commit's compie error

applied, thanks.

--pfTAc8Cvt8L6I27a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTJvaSAAoJELSic+t+oim96JEP/2KdRrcyhDjCK60ABM8VQIZs
JjjDi0xqOnT50EtIZwKBLsa3yFfFXGQaAaT64fDRVGwNRb058vwcoow51R9NHbH/
QGq6e7GuqSop4YE4WeGZiaRgw6YR/KPM6yMA0ilKllW5ZkHUCJAVAf6bht0dM80d
OxhvN813tAyqJ1w5o1gvm4X40LDpuozadPBWHkUmMm3JC3D0r51u1cga8OLQsKL9
MVbMyrtrRGiME06tZQzb3SR65T5E7XZgOkVVcC1mCsRDR6C7WMLA76/nlPVFtli5
pbM237ov6o58EyJB/QAlV0umLgur71f2t3HSzL7HHcNuIKLstMf2GIWkelxBP0FH
Wq3nNQozg3VCvBzVCXqhUIPNBRN0bQp5y4qrxcE7My/SBor6lsUO5sBQaJZHXome
/ZBVoefiCB4PhMUY4qbF10SE1E7DIpnyRENlc/1vEZOG+JzEq8q7x02QNjtj60yI
jGQBDfmwfnMNh3WYi59ucTlEy7GDaqCK/AkUXGyL2xLUE7wl3n9eNBGW8v4PUQXn
xFCsC60ctKFo1aEKxqzcO4a6oi6ig1CbGQj4L46GRJV8aJogKBjyj+UjhGYF5R7u
T1W4LwQM1AW8j85qDD3zzmdXhRFehthQMknQcbIuFZ3rac8O2tEOi7f5U6x55TVO
Amd9lp+tQT28HP78b3aq
=cmWO
-----END PGP SIGNATURE-----

--pfTAc8Cvt8L6I27a--

--===============5516024953520007810==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5516024953520007810==--
