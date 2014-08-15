From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH v2] ASoC: tas2552: Add DAPM calls for amp
 and PLL
Date: Fri, 15 Aug 2014 12:48:57 +0100
Message-ID: <20140815114857.GL17528@sirena.org.uk>
References: <1406908624-15290-1-git-send-email-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oNEXPFkTTJNzq0nB"
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1406908624-15290-1-git-send-email-dmurphy@ti.com>
Sender: linux-sound-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--oNEXPFkTTJNzq0nB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 01, 2014 at 10:57:04AM -0500, Dan Murphy wrote:
> Add DAPM calls to enable/disable the Class D amp.
> Also add a DAPM call to turn off the PLL upon
> the stream completing.

Applied, thanks.

--oNEXPFkTTJNzq0nB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT7fOmAAoJELSic+t+oim9/EMP/RrdGdpVSZkouR+8lEqqcvS3
cObTqI5nyZ8PS96rwfDepITbN1wY34raeUuHH4mxWmHaIN8lIcrfunzf9pSORAe/
daTqtmYTnhx0uBtxkw+Z8ijZq/58PmWBNrCmiro8waMLdUJzwFqwGKT7aTvGVqck
uJ3g34MKZ7kTwz00AeWptxw81de2Te0EGfycJ/DoPI0lJmKuapacXU2proB+12ty
RG/OEjgl5RgdgA8m0K5lyvps/EYqancG4Z+G6xxSiy0DMiKLKGxdVZPmaI8E9yHJ
WC2JWaVzU9CngvtqE0qsLFxWDCI6xl3iATfpEjwdrL5tnyDJBG9D77zqFDtuj5Zw
8k1ZJiwNytczzhbIcpdaJHlF1wA1bnK/pQ3N2htyVS8yrDu9vugiK8Uj0scPPoiv
M5oKZGGGQZUhH0Q5wfeTshDW+D6JzeaHQWmw0+avjr/JmGtHXYjBCE50+Jts2ayS
NWc69D6JEmfRQ1dvwMivKuJIgGxBJlgfSnR4oR/sdZDzuIh2EUtZ+/L/vIkIbD5z
b+slvnqNpzmE9bUMj0CU1VPPudhk/SXnjIGNfCMy7BI8r2u0KJEcMo8jn7/8/qYH
PNE/2hXKDa+OLZdxow3GQc2rINQUJGiP38wA89eRQoH+v5Qc6wFTzL9u2Lzf03eB
/kYDNsbltZcQXZWRroW7
=06hE
-----END PGP SIGNATURE-----

--oNEXPFkTTJNzq0nB--
