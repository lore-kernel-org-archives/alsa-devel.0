From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH RFT] ASoC: si476x: Add missing break for
 SNDRV_PCM_FORMAT_S8 switch case
Date: Thu, 1 Nov 2012 14:39:16 +0000
Message-ID: <20121101143915.GL4413@opensource.wolfsonmicro.com>
References: <1351670863.6496.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6712946127511170839=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 174272625D3
 for <alsa-devel@alsa-project.org>; Thu,  1 Nov 2012 15:39:18 +0100 (CET)
In-Reply-To: <1351670863.6496.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Andrey Smirnov <andrey.smirnov@convergeddevices.net>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============6712946127511170839==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="37cJpJlYZwAfNbm5"
Content-Disposition: inline


--37cJpJlYZwAfNbm5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 31, 2012 at 04:07:43PM +0800, Axel Lin wrote:
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Applied, thanks.

--37cJpJlYZwAfNbm5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQkol6AAoJELSic+t+oim9Lk0P/RKvYdQKHtwuxVHrYgalp6yU
ipEhtmm+aoVSVKHDu+31Bwzu1a0PK8fEKv52+VMRSZ4rlmiKLiiXD8pK0NxiQ0+v
VH6MKDXnXCFFA0yYaboFsHp2bFkIpenfiRoVJGrBz6gh0eq/0xO3zzzdTZstvfQG
QOB+p1/zwrOxV5SCEgmSem8MA90JdRn/8MLc/aaZPDdhHogLtF5qsmw27CH1FWvW
wFCiziMK+aZ2csoZ0Z/4h53gxoYR6jIk39MrBFOreHG+ULN5SivKmTBgGZSAzw9G
68hkxD0bAfxwTt1MusNhIohQmMBqPPP9ZF2Cm8txBlEKsA79vzAuoBIi0vjgNYYx
uIjgwthiCYj9JY/aKVEAhdeXnCJalN1y9PbJ+rj4e+UISR7zJDg0Tqbap/VgD6Vf
Cm0iRTzX+s4eLjzLs70d8or8oVeMzxKqBzjCNctlZifxdr1uXRqqiG88+q1AGUzu
3JxaG8bWK9Uf0o/dmgpC5B5N6oV02SEu1rLw7a0GBSLpn8QYNOH4uj2sPX7FBtzY
7Z89FuRlbL1HItHvtTsLGwyv/rAAda0+FkI1uuNhI0XK/O9FHtIsiJ0rfFhqt++E
C31c1cuounY1X2wmDCyhKSVc/e4T4QV9N+7oUvE90/eyUTp8znVaTmx2zlGimER3
cNE2bp+qNr0meLdzKlSE
=X9bl
-----END PGP SIGNATURE-----

--37cJpJlYZwAfNbm5--

--===============6712946127511170839==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6712946127511170839==--
