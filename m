From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/4] Add fsl_asoc_xlate_tdm_slot_mask()
Date: Tue, 25 Mar 2014 13:07:11 +0000
Message-ID: <20140325130711.GX2269@sirena.org.uk>
References: <1395382635-16349-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0683713798572172502=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B3ED226260F
 for <alsa-devel@alsa-project.org>; Tue, 25 Mar 2014 14:07:23 +0100 (CET)
In-Reply-To: <1395382635-16349-1-git-send-email-Li.Xiubo@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, Guangyu.Chen@freescale.com, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============0683713798572172502==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JMKEfAmnQy+WzDHS"
Content-Disposition: inline


--JMKEfAmnQy+WzDHS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2014 at 02:17:11PM +0800, Xiubo Li wrote:
>=20
>=20
> Xiubo Li (4):
>   ASoC: core: remove the 'of_' prefix of of_xlate_tdm_slot_mask.
>   ASoC: fsl-utils: Add fsl_asoc_xlate_tdm_slot_mask() support.
>   ASoC: fsl-esai: Add .xlate_tdm_slot_mask() support.
>   ASoC: imx-ssi: Add .xlate_tdm_slot_mask() support.

Applied all, thanks.

--JMKEfAmnQy+WzDHS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTMX97AAoJELSic+t+oim9YbAP/Ru52VJIKkQzzrKQx5UUJUVQ
VpdVNyJbwPImhf559aDXk6AV9BXZG3decfdkqPhPg8WDdiCFZpZ3/37NdCQJh4NK
GaRQG1opx2xKrdq+hcfWoMVtwNKVGdl6lkNAonfjIe2vKObXIZO5lB69B69KTq/U
/bgoXIznHwSVmUa/L2WIsXwnEmxYH72F9Ssc9ooV50rePmpgroRCAGe8S55sFrun
/iM6cb7m4boOnk/C0sSSUzkrvOa+X/77XR7KGHbkYhDt0+/oxOXSwW8hNBb0bcHW
+0vwGX9Df0kbD/CckH6GVZ1p7gDDoAOuEPMef8IRbXy+gDgzsuJRM+Vw8OAZvTF9
L0VTkN9awJIht0Tjdw4ZKRqFDX6ZlvG/LRDjnpo5nao7SOJ8Gxp+ZmqnsjHUfmnx
2JcR8Ezd6wtBjhmBKjVYvn7IOZBb1EDGXO5aEHrmpnftPglE+IFRgmuKSdkPdMPf
i0CT4jW2JP33vjV4b3ysOiyFb2gg0hwb/hQhC2spbgEMQ/xgBPqB+RhdS1NQKmpE
n8B2sE+sn43oVYuu2+B0xYnEcA3J8uTwNRu0fbtzALse3WMQ+xsB75JnSBadumQ9
ge/z+2+aiUCHfVBQoKNQnZbpQJJ3Mq6bZgdMxPMzxIFDkHhu8Junr/ulgCAk+Y9B
ti7rzTwj/EB93ZXcGQei
=4asj
-----END PGP SIGNATURE-----

--JMKEfAmnQy+WzDHS--

--===============0683713798572172502==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0683713798572172502==--
