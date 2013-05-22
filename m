From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/4] cs42l52: microphone bias is controlled
 by IFACE_CTL2 register.
Date: Wed, 22 May 2013 13:38:50 -0500
Message-ID: <20130522183850.GX1627@sirena.org.uk>
References: <1369243167-28700-1-git-send-email-nschichan@freebox.fr>
 <1369243167-28700-3-git-send-email-nschichan@freebox.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8440046744610697609=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id C178E2608ED
 for <alsa-devel@alsa-project.org>; Wed, 22 May 2013 20:38:58 +0200 (CEST)
In-Reply-To: <1369243167-28700-3-git-send-email-nschichan@freebox.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolas Schichan <nschichan@freebox.fr>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Brian Austin <brian.austin@cirrus.com>, Georgi Vlaev <joe@nucleusys.com>
List-Id: alsa-devel@alsa-project.org


--===============8440046744610697609==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ttZyFY8Q/ImP0sT1"
Content-Disposition: inline


--ttZyFY8Q/ImP0sT1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2013 at 07:19:25PM +0200, Nicolas Schichan wrote:
>=20
> Signed-off-by: Nicolas Schichan <nschichan@freebox.fr>

Applied, but please always CC maintainers on patches and use changelogs
appropriate for the subsystem.

--ttZyFY8Q/ImP0sT1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRnRC3AAoJELSic+t+oim9yDIP/3wgQsqFuRqP/yFEfljoUvlT
+RuvRogUomBBGWS0yIdpEFWtBWWVPC1ZEi/aYsDUKsRS3SP7o9ULW2q4EZyDvzmP
sqguc/Mv7bofywAqKXWRWZhS+beRjRFv4mx8F/ZYq5VSKmUhQ9mkj0xqrdLIvqxU
kfn6ykMmUIkcpvaNXMlENblbeXZg3nQQ1l9qMDmY1350U5EMaTJ0Y7Jqwn2OJTqL
uhyUn6fv2s9NX5gMVWQ3DvmVREnHHo9rHysOsT2B47WwYle8KXqsPzTVYv1cFGSn
9C9nPJ+rgOAOjJwFykmcdh53VBwMECDIBVGwkdh0V/7jNOVbhbtUtaU/NYuMz/5F
f72+396rSlAonsoIM2kDQBIen9/SuxsZLIZRZjjpCr3jE9DrjAIFXiySGnfqXnEc
bTEaP3MPryxSVDDGBqHX/2OA6kIACikKuAPLIg2OUI2i/6bCx5OSygvxIxPkjEic
YzwGR2s4ljJSwe2thNhUdUt1n6Ph9CbFZBEA7FsKAoWdp50TlMZcEYH3+zsNQKPQ
3K2FKdZ7oqu73rQ60/8P1Is5pWAnKXXQv6Tk2Nld0cAE1O4IncRHNdPe6ppHNJF0
RdWTiy777IEf9Bd6rrwzttV0SO3qpHO41PwehSU3qIBnT2C8yXK2eyIkHIJPa/a4
YnCMV/Fa1obBNuilgP4N
=ZYAr
-----END PGP SIGNATURE-----

--ttZyFY8Q/ImP0sT1--

--===============8440046744610697609==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8440046744610697609==--
