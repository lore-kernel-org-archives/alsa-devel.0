From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl: Drop SND_SOC_FSL_UTILS from
	SND_SOC_IMX_SPDIF
Date: Fri, 30 Aug 2013 11:01:04 +0100
Message-ID: <20130830100104.GW10783@sirena.org.uk>
References: <1377808301-10344-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1551112872293472725=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id A1B922655DD
 for <alsa-devel@alsa-project.org>; Fri, 30 Aug 2013 12:01:07 +0200 (CEST)
In-Reply-To: <1377808301-10344-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, b42378@freescale.com, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============1551112872293472725==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hImnF3KMhyKrbB+/"
Content-Disposition: inline


--hImnF3KMhyKrbB+/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2013 at 05:31:41PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> SND_SOC_FSL_UTILS is only used by PowerPC machines, so let's drop it in t=
he
> i.mx case.

Applied, thanks.

--hImnF3KMhyKrbB+/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSIG1dAAoJELSic+t+oim9N8oP/jr+Komu9xop/VnToB72wYET
BD2M2DB1KdZH+lutmFqUH+onJ1DFBnDsju5v2uzxrtEsVgydJlP6vTHknU3fGBqL
pXTtUeFI3BmAHhhsnpY7LSba3Si2Bhakr/PoIuk5WXgsVMW5vGiKH5cwQhz9WJDo
KISaA3L/DKnC6mknP19Ju8e8k7dzejQ4CaPUjfN8Xhy4ZFOWnulD+6iCt4i/fztM
pL0CD+M8SuuIf1Jg6mlOi8iybLwa6oKRwrfweqwB+4PWtq4ZALRdDL9OXA0ZRYmp
x3tfTZ9jXtODKJXQAVs38FOmO6sUpTIOo1XcRwtvwVQC+H7bhGNJy8FAT91EAVZv
fUcudnmLv6z9T4h67fx39plh7DIG0av11xrT/vRmRBk8oQqZ2N8jgIUy0Unn0NIA
nzLdvli1DELCFQJOkghszJm21Oy/Z6z3RdiG9bUDYyd0qV/dTG3quZMjNn8i0vFZ
RKdr8B59jlHB15J5LJ358fOeE46EbJN9h9oqRY3LHrmy44KQSX7OszE/LO+7vT+e
VxCj/19p/PLy9xsgdAsFKU0BjEz1K9p3NPPxbyPsKSxoeebyRTQKRHjtfGNgnmUw
6EvVZDSEAlaIEhw7aVEn0/aEHY6OaVmiVvXiExwfnuEyWUMwJIylV36aHFQ+f/VZ
/18ItNLux2I6BAw65Bql
=0d8X
-----END PGP SIGNATURE-----

--hImnF3KMhyKrbB+/--

--===============1551112872293472725==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1551112872293472725==--
