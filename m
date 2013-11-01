From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: ak4642: prevent un-necessary changes
	to SG_SL1
Date: Thu, 31 Oct 2013 23:45:53 -0700
Message-ID: <20131101064553.GO2493@sirena.org.uk>
References: <87vc0cy7u8.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3913006523487906305=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 063B7265002
 for <alsa-devel@alsa-project.org>; Fri,  1 Nov 2013 07:46:21 +0100 (CET)
In-Reply-To: <87vc0cy7u8.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Phil Edworthy <phil.edworthy@renesas.com>, Simon <horms@verge.net.au>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3913006523487906305==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="80d3ujMCT5hHQAFF"
Content-Disposition: inline


--80d3ujMCT5hHQAFF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2013 at 11:06:17PM -0700, Kuninori Morimoto wrote:
> From: Phil Edworthy <phil.edworthy@renesas.com>
>=20
> If you record the sound during playback,
> the playback sound becomes silent.

Applied, thanks.

--80d3ujMCT5hHQAFF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSc04dAAoJELSic+t+oim9J1QP/3nXRMH7ZgUuo2jiOX6JSTOf
EsGM4966hLmGDfP7EdSJoUnRHIBqNiE9qDE6XsNJnO6jlur1jC1Nr2BhWzDF9UfB
ijIaLZsH+ZbZtH7pa0cdkxDilRfQ4QAOp5NAPxDfgSVZ5lYamTmfmAZNGQtNmn0f
rcAAAZE4tpvlcbIdX+QHzmQAnv9HkynE2QU+m+zTHlRG8jAN8/A7I7Rz/OpIdfpY
T5HMgwynuYD5vIgoI3ZhIM3O1ye1JxZBq8boeJEQ7DUZN7BQg/mzkUg4hhOctx+I
3sz8v/nIhvQMDxjIlY/WhUo/a6LRBTLmOU8HgvkgwAIh64DXg2OmSfR5QYz1MCeA
id3bZO9VpgXW9pQ2aDEeeeXGCNN/c7r6ZJFNb6y+YVaPyEaNgeoTMHiZJlJufRbi
S0OhKgKnCx69hhlS9MaMRKQtOqnywI+k4QKt6Rgpj8ZRJJ2ydIT2NIa0n/b7GSKd
Qwhxsu/yLUY06618BXZDYZ7fK/gmTMV4KyigqFUsj4xOnRM5qVJXk139xv6+RdON
QoAF6O2YOYSsJtSnc/MnVbvImmiO1N5f5nhZ70JhADqfSD7x9c8ekHZX6WGDVDeb
TayppUOZGEWW/6GG1M2y3H8NI/ehk/U6kfMx+zY3rULSCIN9sHClv4/rFnf7Eyae
KC/xLUnOThvPkVyfz+x9
=TIXj
-----END PGP SIGNATURE-----

--80d3ujMCT5hHQAFF--

--===============3913006523487906305==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3913006523487906305==--
