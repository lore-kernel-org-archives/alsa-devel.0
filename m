From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/3] ASoC: davinci-mcasp/edma: Switch
 AM335x/43xx to edma-pcm
Date: Wed, 16 Jul 2014 22:09:37 +0100
Message-ID: <20140716210937.GW17528@sirena.org.uk>
References: <1405512724-23628-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7443557320152623851=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 387EC2654AC
 for <alsa-devel@alsa-project.org>; Wed, 16 Jul 2014 23:10:05 +0200 (CEST)
In-Reply-To: <1405512724-23628-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, jsarha@ti.com, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7443557320152623851==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8Bx+wEju+vH9ym24"
Content-Disposition: inline


--8Bx+wEju+vH9ym24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2014 at 03:12:01PM +0300, Peter Ujfalusi wrote:
> Hi,
>=20
> This series will switch the AM335x/AM43xx SoCs to use the edma-pcm as pla=
tform
> driver instead of the old davinic-pcm.

Applied all, thanks.

--8Bx+wEju+vH9ym24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTxuoOAAoJELSic+t+oim9rmsP/3Y/l+qAHlQXM5T7/zprwec9
9oVyBwFl+NBB+NoIb/82NxqPXE6ZxwDXTJEhg1wrPvgWeyY7HZGaKYk130OWy10Y
ONHESz+Y+wttZTgPWH9LteumDgzTpyc8irP6lrzTxJggAmCelgO/4XnY9ePgcbKX
7QU06XUseC6dAFJe8APyMPF7UTWnhsNP/o3vjuGoAeazL8eZLIgDfkswzYEfOcxG
koVGPE5iCJx1lJcl+yIegq1YYnEwv/GAnS6icKVzpJxR2ixmC/eHerrhXWOe2iAi
7l/6L/HYHryx/K4NQTRViEdBdMxe3VdWwS0X4IHAZYBtVSnkoAeRxAFC41DcbDa2
g5eNhWxMDD8TC5K4PS9ALj+z5LDIe5oKbWj610HzqKV6pJ/zrEns5ov3hQHgvJXT
lsE7Tmqv+zut9VktRVdpiqVyUTPzsECLe22WZQF5zBt1c0t/+rW7r6ZsgqkgONvJ
kTBe8efAfrnjPdSgmRblSX9fIqO9C5Jl9NddTYRl4/g1yX4GfL/HRslfsZEK7tGv
eeCkAQGn4tJkIQuxvFcqJm5mbHde0avH/9bqMJOIWrr1mCGqXvxQ/kY0CQ1Qm0/h
HBmLPQa0S2v8UaQ937iOU4l2hEGYyIyX9ANLoCt5wyclO7fmkxUxVLKJ23YZo97K
bsevSiTaGJ6x3mJAo49w
=7F6A
-----END PGP SIGNATURE-----

--8Bx+wEju+vH9ym24--

--===============7443557320152623851==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7443557320152623851==--
