From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/3] ASoC: mxs-saif error handling
Date: Mon, 14 Oct 2013 18:02:16 +0100
Message-ID: <20131014170216.GI2443@sirena.org.uk>
References: <1381486264-1672-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6977790696384271006=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 91C51261631
 for <alsa-devel@alsa-project.org>; Mon, 14 Oct 2013 19:02:40 +0200 (CEST)
In-Reply-To: <1381486264-1672-1-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: kernel@pengutronix.de, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============6977790696384271006==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YtWd7p+F4osuzCU+"
Content-Disposition: inline


--YtWd7p+F4osuzCU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2013 at 12:11:01PM +0200, Markus Pargmann wrote:
> Hi,
>=20
> This series contains error handling patches for mxs-saif. The first patch=
 is
> a comment about the possible command sequence of trigger functions.

Applied all, thanks.

--YtWd7p+F4osuzCU+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSXCOVAAoJELSic+t+oim9LLMQAJwGTM53+96xTtr7X8ndd+Dx
qNxL6uTsNHQJeov3KKKS0YcAu/wiVlH85go8CNgwYnJ2r7kGfz9cVVpBm7ajJV6a
JIXQYRzHw6SiYIpdt618D6vNLVeaEc9TYrPiwsWEVU6hs1kTA+cWWN2m5vlFYBDh
Jq00yR8JVk/ehnmSz9gOXzG2BNdwTnasCh45ZfyZFSVvF6cCBZMIOKEWTHiVEWWV
C04AKlGxMpRQbT/fbTdXWTcP2UqLSG5PA1xf/eMJLHHYX9oQgeJsJNcVMTcVB1m0
2StLxstA4e/Ad5Q1/Li5np3gZBJtoBM05YJ2Hd97wnvsNGyXdToF79SAAeDJGazE
u4cPbC3BtqBSGVamcvLYCLoIDTI75ID0UNhAUSVpu5hab3ssbb0qe/2+P82m353t
vN/s/lf+9Y0UJzokun0pBmGJRaUCpGfr+mDt8KzxQRbtGCbLf6Md55wD03ZyCayW
Y/H/dcqMxcfDG59MS96mnts6cMySp2T8Nk2uJIjS7vYD0+5QMjlMgBGWYFn9Esci
9XVmw5aYc+qn48oH4Zc6UGvBFQjnAtIhFIxctgxSjzFiLvCSV0JHtTYZ5GVISY5d
G8o50McdeVjHueEAy1tBJPI21ziNVHVii0ME6IiqAiq6CP5Zf1Iy5SB2w1S9VFBx
yLE4NGea2aFYXFzXD6Ag
=pw6W
-----END PGP SIGNATURE-----

--YtWd7p+F4osuzCU+--

--===============6977790696384271006==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6977790696384271006==--
