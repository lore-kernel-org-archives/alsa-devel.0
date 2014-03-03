From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 03/19] ASoC: rsnd: remove verbose function
	parameter
Date: Mon, 3 Mar 2014 10:19:53 +0900
Message-ID: <20140303011953.GD2411@sirena.org.uk>
References: <87d2ib90t9.wl%kuninori.morimoto.gx@gmail.com>
 <878usz90ri.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0379523888213785269=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 855E6265534
 for <alsa-devel@alsa-project.org>; Mon,  3 Mar 2014 02:59:25 +0100 (CET)
In-Reply-To: <878usz90ri.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============0379523888213785269==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kvUQC+jR9YzypDnK"
Content-Disposition: inline


--kvUQC+jR9YzypDnK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2014 at 10:15:00PM -0800, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> priv has rcar_snd_info pointer.
> having priv and info in same time is verbose.

Applied, thanks.

--kvUQC+jR9YzypDnK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTE9i2AAoJELSic+t+oim9ISkP/R+n8DunHQTvAV0yObCcoHCy
MeV918tIPn7Qk4zhmyJtlNDgGtQ9+d5pPtglZr6wrEe5xUk3Fc7K0YwztERp2uB+
OMN22/3wS3CPJQBdAtUFrrtbLiLyXqOd4sJCEflC6MtAec80wT82KHDRRtFeUhTJ
uAuph3HEc73zOHNt0DXu2goaA3B4FcmcYxByvIjL5IjdwjsE4+EDFWVHKKk6nPY9
Jz82Csl64hDbHf8sy8Hi1lY7PuF0FOzlW4oDNzdNYWKht+In3JUAkNiRGCG3foRP
ogjytrgOjepk7QvT75qLr+C1lFSzqIsdVxS9kLqTKYH5THiFZb5HWhNhp9NGMh/0
TamhJwujvN2NMXi4B0wASE2WGt/xqVURgDRkEJxPAjI29Z7DdVnZzlGsHNR0obl5
aXYGVAhN1qIcTuU9e+S9tVVx1A61XC3fark8M7j6qrscZC49hT071KjZgIkUZXF8
GkxUOMKMcxgxjn4T/Xrel0YnSUDpDRq86jzeRmuw+beK2Z8YqqseJMLcCj5oQH1s
npMr07hMrbnshpJHH+aTlGRB9OTF8g8Z+2LLdo7ht6XMsyx+LAE26XzsJqGxcQJg
jMxoM31/6uPEfRcD5HLcserA6Dl3prMspBDd2RlQzpAQmic2iArN/RQszwArUd3O
Vje8qDuSHzpphaR5dphi
=7UeY
-----END PGP SIGNATURE-----

--kvUQC+jR9YzypDnK--

--===============0379523888213785269==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0379523888213785269==--
