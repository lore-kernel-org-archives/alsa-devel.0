From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/2] ASoC: fsi: bugfix for DMAEngine
Date: Wed, 30 May 2012 11:04:32 +0100
Message-ID: <20120530100432.GE9947@opensource.wolfsonmicro.com>
References: <87txyzmrj6.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1110515772184392337=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 633E724634
	for <alsa-devel@alsa-project.org>;
	Wed, 30 May 2012 12:04:33 +0200 (CEST)
In-Reply-To: <87txyzmrj6.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1110515772184392337==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SWTRyWv/ijrBap1m"
Content-Disposition: inline


--SWTRyWv/ijrBap1m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 28, 2012 at 11:26:41PM -0700, Kuninori Morimoto wrote:

> These are bugfix for FSI DMAEngine.
> Without these patches, FSI playback includes noise.
> These are for v3.5 kernel

Applied both, thanks.

--SWTRyWv/ijrBap1m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPxfCpAAoJEBus8iNuMP3dJoYP/ifTys7qwDmKcRlMV+RxxdOK
Rfn2iMjNzlo3rSzh0nSEOn/43ObWdBpra3iXqwY/4H0bMI8TimJCUB4GzPbRuTrA
JwnC0d5zVxNEyowCpRFUsBqEO/JwGmdRRAPj22JG+X1jGVAYBLi7nmL07l+4WD40
edZxYSLousQOdnywntM/phkN/GKlpSX2MaOWhokP/9+hJDZPsPBIDAqhidhT4hM7
F3YL90NRbc7oVuTaYmDUAWC457ravMB/Z63/XF/mz0dbrJXitl9R8q3doL7Lv0KZ
JRcJ1elKBu5L9i156s7k8XSUbk5Qd20PxYmTTdEchxPZ1dt123FnGoWePlANUndk
HqNrdHs+xqryp0Yh+zDAvighzjM4yF7VETlFBV+6jU2kqJ3czM8y5JdNYnobK+tw
Rxnr4TTGH9Wod+RpV6EzWrTVsmJJf+nSqWOQC7sJfjzZhZqJ5zmTn2Io9n9YOan5
VdngCm90Zv1pZEIiRlwiW72tGSbm3225x1fUhtE3n34L4G8CKoFelnstKE7e7z+G
aFoRpQQezlCNyEl8By0nJaQjBR0ukH91g1RlJ7P/klC1dkbJusVzowuSuEX2L+rH
UI3YM1D/nHkizDhLvnQnKXyF3MRxerbrhZaUM8zauIX3dyjnUQsimBjRkslQuwGN
GNzVkpfJKH73E1mtFxIw
=xhAl
-----END PGP SIGNATURE-----

--SWTRyWv/ijrBap1m--

--===============1110515772184392337==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1110515772184392337==--
