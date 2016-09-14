From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [[alsa-devel][Patch] 0/2] ASoC sti: suppress inappropriate DT
 fields
Date: Wed, 14 Sep 2016 18:13:44 +0100
Message-ID: <20160914171344.GG27974@sirena.org.uk>
References: <1473753504-20179-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xaMk4Io5JJdpkLEb"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1473753504-20179-1-git-send-email-arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--xaMk4Io5JJdpkLEb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 13, 2016 at 09:58:22AM +0200, Arnaud Pouliquen wrote:
> Aim of this patchset is to clean some "dirty" fields in devicetree.=20
> As Values are linked to the chip version and the IP usage,=20
> they can be handled by device data associated to the compatibility string.

Please format your subject lines using the conventions people usually
use - it makes looking at e-mail inboxes a lot easier.

--xaMk4Io5JJdpkLEb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJX2YVHAAoJECTWi3JdVIfQ/fIH/A8+Es88JENV0BdIGvRNcNWL
dqLGxrRehh9xtyKOvS9amRJiW0FPIUA5eqC2eachK+fYo6ihU0TmxialHEvxvEJr
XzIRj4CrK8RmgwxXsbQLHtwLqDqNtpuu+3a3pmG3ibCWf0OgvaWBj6Nz26oyK5HP
XK+e5qM0bDjyAMSZ1DJlKG5uEBVT1eN1pd8lt7pXIxUx9SaT3Nu3W5H1e7AgLh43
2gWrYdHUzC8IQXH6sSdaD38Req8UZfBie8fzn8kIn8kW6ACTgm7dDU4T6BvKknU8
DAC+EA4VFU0GIfbzcdJPo7NP37BmkvAoyq5urdUnYYoc+KAaT4IUSGk3duyo9Rk=
=xOOm
-----END PGP SIGNATURE-----

--xaMk4Io5JJdpkLEb--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
