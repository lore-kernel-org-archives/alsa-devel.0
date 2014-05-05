From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/5] ASoC: fsl_spdif: Rename all _div to _df
Date: Mon, 5 May 2014 12:27:51 -0700
Message-ID: <20140505192751.GN22111@sirena.org.uk>
References: <cover.1398853588.git.Guangyu.Chen@freescale.com>
 <1b18017499e7570126b80cda1a8997aee2609dc5.1398853588.git.Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6764048300439103981=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F1919265054
 for <alsa-devel@alsa-project.org>; Tue,  6 May 2014 02:57:35 +0200 (CEST)
In-Reply-To: <1b18017499e7570126b80cda1a8997aee2609dc5.1398853588.git.Guangyu.Chen@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6764048300439103981==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JVu9XMG6uEpKCPDY"
Content-Disposition: inline


--JVu9XMG6uEpKCPDY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 30, 2014 at 06:54:06PM +0800, Nicolin Chen wrote:
> We should have used _df by following the reference manual at the beginning.
> So this patch just renames them.

Applied, thanks.

--JVu9XMG6uEpKCPDY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTZ+Y0AAoJELSic+t+oim9lWYQAIpXBLbL0lx9zz/2jUqhQyxE
ojMBhNFOoXkCoToStaz6syqmCCpEoG5dt16Smo84C6mZtyCfN7PGR9GtxIPKK/Vj
Ov16EoMbjoeKOFtPzgvRDH4Qmt2sbD3C6JqazJ2WXYWZY/YT0S8bA1KnWKcTAB19
06kHknlBrO+/NrzazCrvHpQIcZJdWekhfBdDwQO6BOkhxj99hnTpvW3m3wVaJbAq
k945Es2G/V2LR83IerO9GVViMOjJC17GjApi0yKiBdx0n3OOAlxQJWICGK+yAao6
MC3YOQ9mIz5wEjKRIFl+Ysbw0R7x5DTzCeDipL+Pk5xSonl9xncWrs2myrZ1T3pu
43h88x4/8OfWVZPzHEx4arl+l+1CJrNwQVBTlUMzTQAdTgNeUW5JIan4Udvr6HHO
vVGQXDULg7BaJ0Rh5AbmVOutj+0itvW2VNin5HjlwHfJCfnTXVqsCSx1rVgnmlqW
TAzE//fWv8VVBF+0UTFUEd6WlRBkXAZ2hJBZ+JrllxCfKO46vwpl9vQ7Nzx3vxPF
/VvHnQe2yU+xCe9+TXejYTfF3tUkhCfNRu2J6hezjI53+9DsYqW45DTA6Dr6nr+o
Qzy7wnShGBn1kSBb4TqXxNuoJ6V5VqdjS6izQmbNYo5Ohzsf+d9MTG+BWGyDh6Xc
zWByW8ULOo8/IbMaGr2m
=HAuZ
-----END PGP SIGNATURE-----

--JVu9XMG6uEpKCPDY--

--===============6764048300439103981==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6764048300439103981==--
