From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt286: make rt286_i2c_driver static
Date: Thu, 10 Jul 2014 12:44:11 +0200
Message-ID: <20140710104411.GC30458@sirena.org.uk>
References: <1404987297-18313-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0658239002961922652=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B1FB1261A40
 for <alsa-devel@alsa-project.org>; Thu, 10 Jul 2014 12:46:37 +0200 (CEST)
In-Reply-To: <1404987297-18313-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, Fengguang Wu <fengguang.wu@intel.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============0658239002961922652==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BzhqTaE66jeIVBY0"
Content-Disposition: inline


--BzhqTaE66jeIVBY0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2014 at 06:14:57PM +0800, bardliao@realtek.com wrote:
> From: Bard Liao <bardliao@realtek.com>
>=20
> Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
> ---
> This is reported by kbuild test robot. I don't know if my sob line
> is needed or not.

Yes, you should add a signed-off-by to any patch you forward from
someone else.

--BzhqTaE66jeIVBY0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTvm53AAoJELSic+t+oim9EP0P/0XoGhJ8lQfMuTGx/flruinn
HbSfeSMxSxR0fGk5wUX7SJpVFDx9vEQFsZQfeEfhjWmFaVkjoSbVwP9sRU3AD69S
52kHs3fiKVc/CGuhRq7lRxxJOncZs7w2IUXmmPm9btFa5fbZO2itx5mas7n7Ng1o
GZF7KxRNE5q7Bh2dAdQR7VxlwqPcomxFTr+8oGMP3rQrGjy6b8v+6VeIGxnmxB0A
mrd446mTgwjTgKXdkw41wkPDGaC1zgwNNdm4Y6msu8ZNGhb3GhrmCLKbsXBlQJI1
94qOCWI2u3X3Od2Ix7Cq3AiYkjxCqLpZYD+k4l7Pqjl+Jd4s2ZVIyL/rVOkM4LII
/Z24B/KbTdrtYJyY1cVm/sXVJhHhirU/D/ODWqF6sw9t89v6cFEO43vxn72pZ4Wp
BLNQkXEqyUsOikh+zI6Y+whU+PndCQPfk2LrkAZFP8x6aNK/b405Z8DvJpwwZEU6
fbfkHzaM3bUYskYufGCgZxl4qL5SeXwQJE6rcjRYFPzbicm2/svqKGT0fKrnNJnC
YjG/qd6C3dnv9m+qahdzGOwqGxUMn695I1jVOa95X0qA552HqQGWzfRlrYSjj9JH
GSitOnvI0EtAqStItdN8Xo7S941M2FH3TBUqE8fHOL7rJnQ+s+fxCGIL55GCgFG5
YPKJoLyTB1W2jmHfhQ52
=KhJR
-----END PGP SIGNATURE-----

--BzhqTaE66jeIVBY0--

--===============0658239002961922652==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0658239002961922652==--
