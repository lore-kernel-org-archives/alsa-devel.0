From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl: imx-pcm-fiq: Remove unused
	'runtime' variable
Date: Fri, 8 Nov 2013 10:20:59 +0000
Message-ID: <20131108102059.GE2493@sirena.org.uk>
References: <1383879300-19947-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5771489267986266534=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E129265636
 for <alsa-devel@alsa-project.org>; Fri,  8 Nov 2013 11:21:09 +0100 (CET)
In-Reply-To: <1383879300-19947-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, oskar@scara.com
List-Id: alsa-devel@alsa-project.org


--===============5771489267986266534==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tfudkhBUqbdcU4Ca"
Content-Disposition: inline


--tfudkhBUqbdcU4Ca
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 08, 2013 at 12:55:00AM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> Commit 68f9672b (ASoC: fsl: imx-pcm-fiq: remove bogus period delta calcul=
ation)
> introduced the following build warning:

Applied, thanks.

--tfudkhBUqbdcU4Ca
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSfLsIAAoJELSic+t+oim9y78P/1vEOOvixZ/6ldvzmpaCLf6M
+aAmIFfBn971X864FIGGNop7bVjbYAZz17siLfRBXDTxioQKlDDVzCpbY8OLh/Aq
0npH/VAhqw0liHZCDEi2aMWXSrT58XBLRVBH+aYDYtfJa1R46L/xB4TIKAaOsCIJ
EWibIs5Qg+EvRZ0oWuiSOf2vmP3ozi/QvXkag7pB6aSQosOoSkyjQ2GPA0baaTkf
HYMAZoKe467lqjRQEFC9Uc+v00HbbW5wNrsS2P2vG60aOm3/qh9tKpi1KyUvr785
qJ0VMdSBmXQy3ODrpcs51e3QCKEWcxrf3hhI9Cug0dtK8pMzhP+LdNQVS/4FrfgV
ReJ4sPGXcdkwVrhm31qnArjPijNI8Eejf0QSHSvVH2oLDNbzJB0oE2c1EsTyGxfU
YWjvKgJk7mnf18D3pgTyZ/ncBTFOEf+macKf6I0EtkTU/GSCTL/uSWFu/ntMhfGS
/eN/9ojZ2DD5SOh3GqUYJTlkzXfGEXudej+8ZKUXiHYjL07v1GBD7YQAOObQke7n
Eud/H9byCSFkms3IZcn9Ol6NbUiisHGDYFnPb1xwtEFGItMHdCi6miI2h8GANlva
jCtMITFi8Zjp2A2Vk74G1m7t7juaOtTArSy0G+j2fRCBTzlRypg/MSK2bBLBLAkf
ZxB7C68W3FFppfYlskU+
=dkI4
-----END PGP SIGNATURE-----

--tfudkhBUqbdcU4Ca--

--===============5771489267986266534==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5771489267986266534==--
