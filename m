From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: cs42l73: Add Device Tree support
	for CS42L73
Date: Fri, 18 Oct 2013 00:39:53 +0100
Message-ID: <20131017233953.GY2443@sirena.org.uk>
References: <1382025815-7912-1-git-send-email-brian.austin@cirrus.com>
 <1382025815-7912-3-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0784821266429993745=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id B753F261622
 for <alsa-devel@alsa-project.org>; Fri, 18 Oct 2013 01:39:55 +0200 (CEST)
In-Reply-To: <1382025815-7912-3-git-send-email-brian.austin@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0784821266429993745==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5iQfWP9hwu8WkYTt"
Content-Disposition: inline


--5iQfWP9hwu8WkYTt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 17, 2013 at 11:03:35AM -0500, Brian Austin wrote:
> This patch adds device tree support for the cs42l73 codec.
> Reset Gpio and Charge Pump Frequency are available

Actually this doesn't apply for me, some missing dependency perhaps?  I
didn't check exactly what's conflicting.

--5iQfWP9hwu8WkYTt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSYHVGAAoJELSic+t+oim96HcP/3qk/wLAy7qCjWf4QDluvgSu
vLpUxdbWOnhdWQHO7JydNU2DA8HP7nI+uRFhXfL6UYjbDkip571uVM+1XsMS5BQt
pMlW0srBYieXDaHMA1zITUNwOFM7A6l3vGtLHrYvZIcvZ2d6QS+ea5hQe1QygXzs
s6QPhQzGRrdQDQ+cKbfINK2UmYnvFH/8o+PuZ9cUW7sjAQAJkdiIlVM2uEvqrsiD
lklD1HgU1ASN8nu1PcOi53aC8MwsNoe7h31pjdkbm3sYQ9nGD9NYkBY3ucidfXMu
Mmvk/8XHZd6JQ8rrFO4hGCUwC/D0mOGsQGfwBgD21GEcyiWO64uomY2B/TnjB0c5
GWlKwODxWwB8Yq727h+rfNAd4hQD0cwJ/yb+6TI2j19WbQlw7ZjY0ueFGxwtkVgs
SGPoMGZ0yP8VVS+hFjvu10u0YHogjZQ18zZgGmaBEIvdZcWlKwzxQwJMa+UM3/kY
FgiwZ0kD03SoFWSWc+d8cR2Q4NmUKCIzQC1+6tcoSzEoJTstCQOMP50mv1ckz4PI
gvOkNx4dvxkf49D0UYkfs6uXeYsYyGE3u1ii2OuBOz8POagnIcZCqENuUsMSx6yR
RSpIPV5htxQBe/P2LXix9YILxMiycRSvM0YxNs9/rVWebpZXPhMwCpQsHNTjooVB
ntN+dsj4HVT6mysJxXIq
=5wL1
-----END PGP SIGNATURE-----

--5iQfWP9hwu8WkYTt--

--===============0784821266429993745==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0784821266429993745==--
