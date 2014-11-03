From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tlv320aic23: add dependencies on
	I2C/SPI_MASTER
Date: Mon, 3 Nov 2014 11:31:53 +0000
Message-ID: <20141103113153.GB3815@sirena.org.uk>
References: <1415009453-1018-1-git-send-email-jcmvbkbc@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4121563873876179125=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A8BD6260441
 for <alsa-devel@alsa-project.org>; Mon,  3 Nov 2014 12:33:07 +0100 (CET)
In-Reply-To: <1415009453-1018-1-git-send-email-jcmvbkbc@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4121563873876179125==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
Content-Disposition: inline


--U+BazGySraz5kW0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 03, 2014 at 01:10:53PM +0300, Max Filippov wrote:
> This fixes build errors in configurations with I2C/SPI master disabled.

Applied, thanks.

--U+BazGySraz5kW0T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUV2eoAAoJECTWi3JdVIfQsoIH/3cC7pY750QPoLxqUAEs7k/F
q4zQv8pkEQpBZkHuqZ3TvdFTku2GmUCXsYTXmJZDaX+fbwPtE3QqixUrVI2jA/37
5BxcOmSQtoIv3oocXyxeTMd4AuVT5otED+tQpsVhBQ0/joKezZItFBCVfxVAH3gy
tT8WFl0h1QW5MmQqm5MA4ii4G/xZlx1hOvojneQLnjpBvgkjblWNIVBZe0gGO0TH
vdtWTJ05umX1XZdGvZx5TE7zxzj4eCgb3HOqng4T/gGO2a1BcNsrh2OLM2lJeoTF
ImGEh7HNDBQVzAj4+KmI0T9fnNaqs+Fqows6pZYj5z4yjulMknkXomOl52S2EBw=
=K4PI
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--

--===============4121563873876179125==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4121563873876179125==--
