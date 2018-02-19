From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 1/2] ASoC: codecs: Add support for
	AK5558 ADC driver
Date: Mon, 19 Feb 2018 17:13:43 +0000
Message-ID: <20180219171343.GL32761@sirena.org.uk>
References: <1518532174-11350-1-git-send-email-daniel.baluta@nxp.com>
 <1518532174-11350-2-git-send-email-daniel.baluta@nxp.com>
 <20180216121445.GH5886@sirena.org.uk>
 <1518784101.9517.21.camel@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7925760094077206022=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D2AC266EDF
 for <alsa-devel@alsa-project.org>; Mon, 19 Feb 2018 18:13:49 +0100 (CET)
In-Reply-To: <1518784101.9517.21.camel@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "robh@kernel.org" <robh@kernel.org>, "S.j. Wang" <shengjiu.wang@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "wakasugi.jb@om.asahi-kasei.co.jp" <wakasugi.jb@om.asahi-kasei.co.jp>, Fabio Estevam <fabio.estevam@nxp.com>, "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>, dl-linux-imx <linux-imx@nxp.com>, "pombredanne@nexb.com" <pombredanne@nexb.com>, Cosmin Samoila <cosmin.samoila@nxp.com>, "mihai.serban@nxp.com" <mihai.serban@nxp.com>, "mihai.serban@gmail.com" <mihai.serban@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7925760094077206022==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Z1OTrj3C7qypP14j"
Content-Disposition: inline


--Z1OTrj3C7qypP14j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2018 at 12:28:21PM +0000, Daniel Baluta wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> Are you willing to take patches fixing the SPDX identifier for the rest o=
f the codecs in sounc/soc/codecs?
>=20
> I've got a bunch of students looking for cleanup patches in their applica=
tion for Google Summer of Code :).

I guess, though as I keep saying what would be really useful would be
some tooling and automation around this - having to try to keep this
stuff in line manually is very noisy and especially given the divergence
=66rom well established mechanisms for doing things it's not surprising
that people aren't just naturally doing it.

--Z1OTrj3C7qypP14j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqLBcYACgkQJNaLcl1U
h9C2mwf+NNSESu9H8d0e54P0xVjSY6zoMiu4LMy6NeQBRyINvqlcMstsgD5zGMJ/
26woAzDIKedrbFvZonHG2tI3L06n4dMqW67+BpDnJOZObgEDBNn/0U5ffk5uT59C
IlKHwDuE6JiqveRAXW2m0W0/h/+wnr+ZElUtNxp+y4V0z/PjI2gbfcCVkSWkexmJ
n1TkUOAcRCswFfQ18o019LzJeEyLNFaUNswy5VMovZSmDrleNpikvgYQbz2SHwB+
V3QrP3gnNfIakbAVHfbqrWVEfBGTs5GmDCnygznyJUQmLBlxrcmjp45PYuJEyGLi
UEF+qq7HI9nQUJLVUxZqe+EaXARvug==
=MoIh
-----END PGP SIGNATURE-----

--Z1OTrj3C7qypP14j--

--===============7925760094077206022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7925760094077206022==--
