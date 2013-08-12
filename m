From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3 v2] ASoC: wm8997: Initial CODEC driver
Date: Mon, 12 Aug 2013 23:44:25 +0100
Message-ID: <20130812224425.GJ6427@sirena.org.uk>
References: <1371113011-11918-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1371113011-11918-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20130613174702.GC1403@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7001443017978255313=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FBE22650B3
 for <alsa-devel@alsa-project.org>; Tue, 13 Aug 2013 00:44:28 +0200 (CEST)
In-Reply-To: <20130613174702.GC1403@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7001443017978255313==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1l41tKZdfcKQM/aP"
Content-Disposition: inline


--1l41tKZdfcKQM/aP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2013 at 06:47:02PM +0100, Mark Brown wrote:
> On Thu, Jun 13, 2013 at 09:43:30AM +0100, Charles Keepax wrote:
> > The wm8997 is a compact, high-performance audio hub CODEC with SLIMbus
> > interfacing, for smartphones, tablets and other portable audio devices
> > based on the Arizona platform.
> >=20
> > This patch adds the wm8997 CODEC driver.
>=20
> Acked-by: Mark Brown <broonie@linaro.org>
>=20
> Or I can apply the lot to the ASoC tree.

I applied this since it didn't get applied to the mfd tree as I had been
expecting; Charles, you ought to keep track to make sure things are
getting applied.  The same thing has happened to the GPIO driver.

--1l41tKZdfcKQM/aP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSCWVGAAoJELSic+t+oim9kxEP/2uRpg2vB1p/TNdJY8QGaRdX
0YUarFYg3ZWEFtMw0hX4lY6kuMFlvILZN43EKlsG8hcMHIdh0bqVuqj0ZWc0DJ7h
MVNUL9CXiVqT3EgI9qLt8l8DMS4+y4neUpCoHZ/SCB/Q0jKqnkvOMmPgq9gepY4o
fXcGm9OSTX4nMVCa/JL9nbcxcl/mg7CtupPKILjjYYkEWMWoA4FzcTH35SBGk/f8
eRL4KgFNZdnL/CLZ3KT/Sq2+t7Yg1pmJCoQbMu8WEcg+OrjhVazHW+Cn06K/5VCI
pdrPEjS9rD4Zm5OSXPwL2rScB433a9W36yjl1F1i+gj5/kVHUJQWcAltrQzAzcpg
E+1cVJGmcO0T0ZJaBIA3siXGBZ4YYMiD4t8YZRhaFGrGr4I5NTN+5trDv39JG6Dp
L9Z/T8mImW1vXz6a64gx3BzOv8o/Lenmq2fBtV4jyebxbmK4wdywQLf5nYtd2lNS
YH75DVQ0KMgy+7mRmGLD3s4YTQfGFsugSbvgBUZpOB7gSnfvJk++2hjj4ssisDDu
CF/eKbj+x89Nf9QeInV5ftOUH9GAML5+weZraU861GnRso6RzHfu9u0hvg+yBYoX
ky37RYDORZtXZ90y2f4parYWnLJ+OobfItIOLCZLsRHF769Ay3xvdBbUefitX7K5
s1SWLhifsU0c8EEycqRV
=0B0X
-----END PGP SIGNATURE-----

--1l41tKZdfcKQM/aP--

--===============7001443017978255313==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7001443017978255313==--
