From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sgtl5000: Improve the error message
 on slave mode setting
Date: Fri, 3 Oct 2014 11:20:48 +0100
Message-ID: <20141003102048.GE4273@sirena.org.uk>
References: <1412277410-25888-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5051551575114691324=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1ADB6260436
 for <alsa-devel@alsa-project.org>; Fri,  3 Oct 2014 12:20:54 +0200 (CEST)
In-Reply-To: <1412277410-25888-1-git-send-email-festevam@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============5051551575114691324==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Z79+P6LHXcBZ81w+"
Content-Disposition: inline


--Z79+P6LHXcBZ81w+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 02, 2014 at 04:16:50PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> For sgtl5000 to operate in slave mode it can only work in "Synchronous
> SYS_MCLK input" mode.

Applied, thanks.

--Z79+P6LHXcBZ81w+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJULnh/AAoJECTWi3JdVIfQDWIH/ixZaqScl1hZSsMNoYQrm7nP
67LCUS8eBZvLs3l9sPQNRw0BWfbjVYrG8bQbtH8CHWBHvpnDIpy6V+6WaKxxPaIa
wNcUybcQx6JEaXzFF3o+T7+z/5hpyiAnaexVUBNkkJ3LRT/drmTWF8ycP6ge1x+3
8OdajYUQYw9SVX0Aw+m+F02liD/p9vty46lCur0yaGY+MEMCJ774bu+Mf88ZmHXs
7YbtL+yZHsNmk+fLjVugtXUOmK+jFxETPHf7mv6LwbqVm89a9nWCyHfpXPTcmaLI
+UQ+alnr50cJaL1A5EY7LcC2Q3z76TaBd6jo/OiEx6UJvRmMDcm4axgCObvuYeA=
=ELyO
-----END PGP SIGNATURE-----

--Z79+P6LHXcBZ81w+--

--===============5051551575114691324==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5051551575114691324==--
