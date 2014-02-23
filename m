From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 041/102] ASoC: sn95031: Use
	SOC_ENUM_SINGLE_DECL()
Date: Sun, 23 Feb 2014 11:22:25 +0900
Message-ID: <20140223022225.GG25940@sirena.org.uk>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
 <1392723517-12772-14-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0220216869394710537=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B79826501B
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 03:31:39 +0100 (CET)
In-Reply-To: <1392723517-12772-14-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0220216869394710537==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vj77qGokqwYdeLil"
Content-Disposition: inline


--vj77qGokqwYdeLil
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:37:57PM +0100, Takashi Iwai wrote:
> Just replace with the helper macro.  No functional change at all.

Applied, thanks.

--vj77qGokqwYdeLil
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCVteAAoJELSic+t+oim9AoEP/jXD/yIM0oi8Us7oqd/BQxAh
qqhyAUdqtlWQGDgV+bnFXhbRymrX6+VS+6dF6gjMGFAnKoSxtO4IaURkv6WjkI86
jfDbcJmxNgDCcwGOsONMLXkSkbUin2JLkJqw77CLuWB3cue8n5BMLe7XvbAoGds8
ktoRI/V4fbk+XpBekMzuPRwi6lpwV3rLnERCDyhqNz0mr4T6aO3yZdTLF++d9EGl
RBqCrr1NL50N2sknCk5oLBTQK8ybIzHU/AwqCCL0M27S6R6MYmH1Ad6oiZcsolAa
FksMLOZT1K0UvP1CeT1LHsurP4k7gNxoNdrxlXRjEazHMfiJncy8ZKr+BzsZOgAN
+TE1h4zRZVOibf8Q4xVt+bXZnJ8nLe/5lOR1+SwCiVfS/VQLbeWwI1HQTopXQn1O
VNWC1JfmxOUTyH8KlywI3+jF474EEs5p1/STygCKzqEGov79dp8qrj1BFXCmlht1
/H2wnhOrkTlptvPDBwdYmDDTxP04adgDN9EYVmWx+sYxou9GFkYUj6aHMOn44QaK
rzz6mAPuNIi8WhyhynRlVTdqDO8UPho6/SkGwl6JphEtoeiCCoot64L0U+M9bbB4
BO1U1pPQpkL73lqQlp7gd2FQBPkU0ZgFOfKBphEgUB/AQ0YRKJ6/jArzaKCbzg6t
hPUcYTWmGk9uoqhWQDRQ
=TPAO
-----END PGP SIGNATURE-----

--vj77qGokqwYdeLil--

--===============0220216869394710537==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0220216869394710537==--
