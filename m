From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5645: make bias level more
	reasonale
Date: Tue, 4 Nov 2014 11:37:47 +0000
Message-ID: <20141104113747.GH3815@sirena.org.uk>
References: <1415078110-7381-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7311724945802751346=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 262492605EC
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 12:39:09 +0100 (CET)
In-Reply-To: <1415078110-7381-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, yang.a.fang@intel.com, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============7311724945802751346==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Gs9iBZf6UKWgztis"
Content-Disposition: inline


--Gs9iBZf6UKWgztis
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 04, 2014 at 01:15:10PM +0800, bardliao@realtek.com wrote:
> From: Bard Liao <bardliao@realtek.com>
>=20
> This patah separate bias level off to standby and off. The standby
> level will provide the necessary power for JD and push button
> functions.

Applied, thanks.

--Gs9iBZf6UKWgztis
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUWLqLAAoJECTWi3JdVIfQaWcH/jP1ICBOYj+49LHqPpVUKX3r
+zBYM4wTcLGenCmkjHF37KzXMwXcOYgzHnWKFo0BQ25L3/lGeJhm5JjmAAVJWqCB
f+4bAe1OH+PCUKSZ0wP0UiVnmcc5RxLWSLmWVVhwQ+c8dHzogOfEa2iVc4PXX+F8
inJU9j1dMY6Wa0tO0JaP0vuxZxWx3I2h6vWton2Ok0xRzo5xmmQFKrYnvG+e6Qzd
BYNe+iZVO1EpIvzX3vEXeoVTVPKNOFBofT3bDrzP+vovPD9JGszpP27Oj99QUlRW
CMddZIjHpuPUF1C3f7cweRzWPY85TPiQXbnbOVgVRxc/eDkD8h1TXxbxVm8CXFk=
=8w3+
-----END PGP SIGNATURE-----

--Gs9iBZf6UKWgztis--

--===============7311724945802751346==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7311724945802751346==--
