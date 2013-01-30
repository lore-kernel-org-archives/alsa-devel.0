From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/2] ASoC: fixup SND_SOC_DAIFMT_GATED/CONT
Date: Wed, 30 Jan 2013 16:42:51 +0800
Message-ID: <20130130084249.GA3528@opensource.wolfsonmicro.com>
References: <20130104193712.GN4627@opensource.wolfsonmicro.com>
 <87y5fvyy18.wl%kuninori.morimoto.gx@renesas.com>
 <87vcazyxr1.wl%kuninori.morimoto.gx@renesas.com>
 <20130127035943.GJ4650@opensource.wolfsonmicro.com>
 <87vcag3hcj.wl%kuninori.morimoto.gx@renesas.com>
 <20130129014808.GC4748@opensource.wolfsonmicro.com>
 <87sj5k3f83.wl%kuninori.morimoto.gx@renesas.com>
 <87obg8z4u4.wl%kuninori.morimoto.gx@renesas.com>
 <5107FF97.1070601@wwwdotorg.org>
 <87halz461n.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4257363513712635561=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CD635261717
 for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2013 09:43:01 +0100 (CET)
In-Reply-To: <87halz461n.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Stephen Warren <swarren@wwwdotorg.org>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4257363513712635561==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 29, 2013 at 09:02:32PM -0800, Kuninori Morimoto wrote:

> Kuninori Morimoto (2):
>       ASoC: SND_SOC_DAIFMT_GATED become 0 as default settings
>       ASoC: clock gating is decided by bool on snd_soc_of_parse_daifmt()

Applied both, thanks.

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRCNz+AAoJELSic+t+oim9xjkQAI6CERKcT9kPEUlyaIQp/Axz
Ew35OM4xLnjDSRPqDsSSXgPCMNoHOlqdkx8nI2jpp4XwsLT+SIeY39DIM8erj1i4
YnRRocPWPzErupLdnZGxYd0nRWKt62B+UTKphhlzi1XwUQbMZrp41SbCw/Yef2x6
e+C0foi0T8piHQm65qzaMyAi0qy7iSqGJ8K+QLMx3H0cS6VpemK9XicGgYs9aQZB
+PiHWrrgIHR7O+eGC9F5NPZ9MobkayITyuiF1xdCR4YVFH0yd5pp2FD2u5sdGb37
3DMk/YoBiFXwP5goiXnLQKdhoZ4FCPA/Ik6bAXhcORgSFyQdVSIGsTDI0gZ923Mi
GkoKtpWgT/CRtxqW8RsbKPyWVYLUfdTfpwUJjO/WqHtPgfkNtG/uetPimZCivrjO
ojc7UsI7BQzCBHYHMjbk6eJCXx667L/88v/MFB4mQtCFIKQlVlHRUt1xmSLUjCLt
Rq/O27UJDupESFdfc0LMCNK4B9K4oyNfs5flQ+TgMBZfLtrZlkm+OqG8GMQtSc7q
9M9qbBOg2Sgx7MNOTgVr0enizx2tntbxAzBJqp6vd8tXf8e3BbwgKtmklgQr7iVB
/cfHY1/ABLI8sAwSCsmg8uYariiS3quND15dwS29lj6guqAeiZZBByc9//XLFZpT
hDwsglRnC99KwcCDcmT0
=m903
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--

--===============4257363513712635561==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4257363513712635561==--
