From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: Samsung: Fix Kconfig dependency
Date: Thu, 23 Jan 2014 12:23:17 +0000
Message-ID: <20140123122317.GH17314@sirena.org.uk>
References: <1390474326-5544-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2769410008950912622=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 149F22625D4
 for <alsa-devel@alsa-project.org>; Thu, 23 Jan 2014 13:23:25 +0100 (CET)
In-Reply-To: <1390474326-5544-1-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: sbkim73@samsung.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, patches@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============2769410008950912622==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pH/3LGhlig8q9Bjz"
Content-Disposition: inline


--pH/3LGhlig8q9Bjz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 23, 2014 at 04:22:06PM +0530, Sachin Kamat wrote:
> Select S3C24XX_DMA instead of S3C2410_DMA to avoid following dependency issues
> and build errors:

Applied, thanks.

--pH/3LGhlig8q9Bjz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS4QmyAAoJELSic+t+oim9oOwP/i0MA3yvpw1d8IEgYXehX7lV
UCxIK0w9rlrLdNHq5SZguTgGSOvgQ/xZJRBgzEHMSnX+B0P6893t7v7gSvq7Hdhf
zl9CiXcq5y5smNY/gzdsv7OGvcINwUbtzQ6Wc94DSiKBSnu7ApOv1r+WQEBOgkM9
K9B/8Lt6NLPz5VWCMCB/9WVTMtV+DDrlb5iy2NKH0qFwoQMW+T9kNkPV/RO7KX8X
I689FieIeUBLLpzQyvNfX4J+nFK+1Dc7u5QMJoTlt5SiRKmy5OXFXR1P4udCO4Ip
q/A6aq+SGkpvgQ8Y12jjF2iVvZ+dpl7J0prQVwZ7+vSMImeHdx5B9htStLcjh9DC
pPq2W+wEKkKezEVxN05iY5yc6ihJ7k+JaI1oVij6PkEPVrKMuQMRijEaZ6MKJOvg
65zw/fxwJyBZOPH9jV9w6fWUjg1AU0SNbXzCWb03Xu/Kvyy9iTR6Xb8fvvJ1T0eC
YKhsdnQlpguqVMj/PyhNNNixS95warUU9K6FSCTeHAVRclbHmAjm3aRAGbHQpZFq
4//q0YMxgqlRxihKVoFZ/rDUireflI8c7ae5UnmfOy1rOYOIt02vdRImpY1p+3US
NWgf+a2y10FO6fWtxGg9SWSu6y+SHe19Ai7BF9lp7RTGf+g+pxF8SxDxzGvwKVqE
OfWEjJSjGJbw29XyBQOg
=X9Ob
-----END PGP SIGNATURE-----

--pH/3LGhlig8q9Bjz--

--===============2769410008950912622==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2769410008950912622==--
