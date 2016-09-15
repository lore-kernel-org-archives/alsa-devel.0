From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] Revert "ASoC: core: mark SND_SOC_BYTES_EXT
	as deprecated"
Date: Thu, 15 Sep 2016 15:54:29 +0100
Message-ID: <20160915145429.GL27974@sirena.org.uk>
References: <1473947149-6663-1-git-send-email-o-takashi@sakamocchi.jp>
 <20160915142148.GR21682@localhost.localdomain>
 <6357ad44-b194-7dfd-b3e8-938af89f4b54@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3106010561714744373=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F21A266EEB
 for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2016 16:54:47 +0200 (CEST)
In-Reply-To: <6357ad44-b194-7dfd-b3e8-938af89f4b54@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: tiwai@suse.de, vinod.koul@intel.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, clemens@ladisch.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3106010561714744373==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="opg8F0UgoHELSI+9"
Content-Disposition: inline


--opg8F0UgoHELSI+9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 15, 2016 at 11:41:43PM +0900, Takashi Sakamoto wrote:
> On Sep 15 2016 23:21, Charles Keepax wrote:

> > Although you might want to resend using Mark's kernel.org address
> > as I imagine he would be the one to apply the change and that is
> > the address he normally uses for patches.

> Oh, he uses the domain instead of linaro.org. I missed it.

> Now I add him to CC list.

As documented in SubmittingPatches please send patches to the=20
maintainers for the code you would like to change.  The normal kernel
workflow is that people apply patches from their inboxes, if they aren't
copied they are likely to not see the patch at all and it is much more
difficult to apply patches.

--opg8F0UgoHELSI+9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJX2rYkAAoJECTWi3JdVIfQS4IH/jAqZX8oYrJtYmUdr0/7bls/
1wzuXJjVq4kZAh3vCdJjJ4V79c6z7dd9amj5If0BVDeggUzKhpVQC+JUw0woTKSp
C7wB83VMraCZ/Q4tOT4zOyroyowvZcY1q1HYZWOeOWOsnpalpO75EUzbNrJHcVv7
YgNsLBZk65clbFrkpRap8+fsfVj+LB9ULzjvtmaz7PvX1BB+hJ/jFtfXEn5INVPJ
9skzGyisK28jnULYJkL32U2YIwAW71NKc+nbDMOmSz27+4zvoKvKzmI51s3Pm1Nb
PrzeQHohrUz8LUCXw9Ca128qHoha7v9bLq6yECueesYBq+qUP9ZQuwGBNu35/ik=
=6huT
-----END PGP SIGNATURE-----

--opg8F0UgoHELSI+9--

--===============3106010561714744373==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3106010561714744373==--
