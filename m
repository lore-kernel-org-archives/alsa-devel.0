From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sun4i-codec: Distinguish sun4i from sun7i
Date: Tue, 6 Sep 2016 01:58:26 +0100
Message-ID: <20160906005826.GC3950@sirena.org.uk>
References: <20160905192404.13871-1-dannym@scratchpost.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ULkDCyeHsmlwbqED"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160905192404.13871-1-dannym@scratchpost.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Danny Milosavljevic <dannym@scratchpost.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-sunxi@googlegroups.com
List-Id: alsa-devel@alsa-project.org


--ULkDCyeHsmlwbqED
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 05, 2016 at 09:24:03PM +0200, Danny Milosavljevic wrote:
> Here's just the part that allows distinguishing sun4i from sun7i.
>=20
> Since I'm waiting for Chen-Yu's DAPM_DOUBLE patch series I figured I'd po=
st the preliminaries in the mean time which will not change and can be appl=
ied independently without problems.

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--ULkDCyeHsmlwbqED
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCAAGBQJXzhSxAAoJECTWi3JdVIfQWUYH/1oC6NzWu3gx1jPkM76i8itk
4trc7emA2epDnHy02XzAn454JNIz/ZmWZJJe/pui3W3UrkERt0M9FYNWOMSAv+x8
vN9YGmqi5HwZ/AMyBvui8LMDf2Wr3L8ueDSOKEu/BIrDoQyiNprobXZ0kn0iwcrA
5cvUf+JYXtc5Ffln4VUQ+6glnJiJlnyoKCgGdQK7F6jbdA8lLKZrn3XmFeAoPaCb
kd2QJT4qjuWLOCoafUoT0Fnc1f6aDhFUfzweA73r8I1sSKuFnuDkZUOLN/c9tEg2
3jkE4CbXKf4ssbBccR20qE5kbyjsuYgKT1EPGfdwA+7sHwohEF4nzqPZS3qtvso=
=NwJJ
-----END PGP SIGNATURE-----

--ULkDCyeHsmlwbqED--
