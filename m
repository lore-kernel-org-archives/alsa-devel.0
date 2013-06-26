From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH -next] ASoC: mid-x86: Convert to use devm_*
	APIs
Date: Wed, 26 Jun 2013 16:22:10 +0100
Message-ID: <20130626152210.GR27646@sirena.org.uk>
References: <CAPgLHd89RzJrpMEs+zR8cQvGHruWvne8e0kGb1LeCqoHdKogHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5376936263638629368=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id EE37226550D
 for <alsa-devel@alsa-project.org>; Wed, 26 Jun 2013 17:22:28 +0200 (CEST)
In-Reply-To: <CAPgLHd89RzJrpMEs+zR8cQvGHruWvne8e0kGb1LeCqoHdKogHA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: vinod.koul@linux.intel.com, alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, ramesh.babu@intel.com, yongjun_wei@trendmicro.com.cn, wfp5p@virginia.edu, namartax.kohli@intel.com
List-Id: alsa-devel@alsa-project.org


--===============5376936263638629368==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w1WLgcEPVIWvtHEy"
Content-Disposition: inline


--w1WLgcEPVIWvtHEy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2013 at 10:16:56AM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>=20
> devm_* APIs are device managed and make code simpler.

Applied, thanks.

--w1WLgcEPVIWvtHEy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIbBAEBAgAGBQJRywcfAAoJELSic+t+oim93ZsP+PCyAc5HubQFBzarNnVXlhEo
zYozhcA5oLg6PqopnqavLV0Zn1lEZE14EBMRo2tdUm6UWeV7sYrdatDkLTriqgm9
I4b5cm9tRRAjwlqJrsY4nE39hPpMECFADO80vyEfKrCpNFvSGFVZhGFOH8J/al7a
N+Gy2Yr7/qU0m1paaoKpkAYeZg1v0yVqUJvryQVIQcG2RdhsEswIOyGZGRU6E1jU
pdIhy+fBsvwwitJdz5aoVUUKQiSJYlzq6r4L6TYf8Ul1aunSkrGNmL8qygeGrmv3
tCJeZ/qfmeIltKupszNm6y5lvRhpLggGBG1tK/jGqAOKM60iVloW3wUgOfzWhrav
kB4zQac3F2iNI37PBUBqfUhPN7DHEOhoBNJQSoyMZvdXut5q8ixo8A2gMq7xgYFX
1OyHvz2//0fj3jG7p2Jh0KbTNAdWrs/mDfBFGe1YCOMmi0rIohOvPjoVo5ENIMwG
tm2U/GfpF/3fvEDcy1csMVfkBBvOGqVklhoFsUxAjjRVL4Vs4Xew6UVtAIquKVLZ
1PPdfrv+Pr89O6sV7vqH6hVTKjGn9wJz6j3sKJzEFtBF3PRufjE4hWI85CxNWYds
dzUyT3/dSasdlXXMowL9w7/uEw/Aw04A9yEViOhSqWpeCB1z5Yj1WRk30P7GxlZc
ZCJFnnUN9wuqmk0dc6w=
=oLF2
-----END PGP SIGNATURE-----

--w1WLgcEPVIWvtHEy--

--===============5376936263638629368==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5376936263638629368==--
