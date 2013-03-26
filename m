From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: export snd_soc_register_component
Date: Tue, 26 Mar 2013 22:50:57 +0000
Message-ID: <20130326225052.GO18316@opensource.wolfsonmicro.com>
References: <1364337499-10156-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6126992258799961041=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 28C4A261723
 for <alsa-devel@alsa-project.org>; Tue, 26 Mar 2013 23:51:02 +0100 (CET)
In-Reply-To: <1364337499-10156-1-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============6126992258799961041==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="euPBw9es1zTRSaXv"
Content-Disposition: inline


--euPBw9es1zTRSaXv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2013 at 04:38:19PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>=20
> Without this, modules will fail to link against those symbols.

Applied, thanks.

--euPBw9es1zTRSaXv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRUiZEAAoJELSic+t+oim9mEEQAIUQThI9hAClFf4MBdnVnlvG
iosOr4g6rTxwVO1f1+RxPl7iRNoCtmWNbN0kY4g526KlQ/80WnJHBzRTcaUMkef8
8ewZhvy5JJZv3zlkzHiAxLSJO0du/lbvytS9M/o/BWjl838Z3MN6SHDEOMrTLMW6
5OAXnh3ssEZAY40cP9kcXMjWzT5g7HkIgdZxQx8+TF3M/XrfqUxD1y61Bi+grdro
5Dzn5TfLJL+yRJaVDXWeB8dlb5vxLUtuPl/OyQyswgFQF3yg5YeSG/ZS0f34Plq/
RDVrV/KoZD/sKm4JCgHerccxresVBvcav2jruq7AyZPCkSYsXrGKIc+kqfEa5RZt
um19lXEXGtxaJAOYK3gAMTPg3kLgBP0OImRmwKIEGtMgBUP/lr2iV6GwzWMtqNO3
boxV/VG5ihhgitSKrZBi7bcO03Di+DFJL/Bd2bcFTFQU3VD3aHVDtSMWJ0K8rmYW
GtWeq5waG40vogyHM7ste46X4IfxF+PUFYLEzlLACCFfa5RUPU+Z8xNEx3o5EGio
ZOQ9k/mwHLKSNfFuUChoNfCtzLukW99rKuDV/dgD9Nct7dC9NBwTZOus8ihYw+9u
VmUOUp9FPP9Q0bEjyxZsv2hZsM4somLRBYP7aC0Fc0yVHIiGX+j8S8W0e/9wzjoZ
O4BfFc7n76UsWg4tSngx
=0Uum
-----END PGP SIGNATURE-----

--euPBw9es1zTRSaXv--

--===============6126992258799961041==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6126992258799961041==--
