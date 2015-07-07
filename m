From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: wm8731: initialize the hardware
 when loading the codec driver
Date: Tue, 7 Jul 2015 12:53:44 +0100
Message-ID: <20150707115344.GB2887@sirena.org.uk>
References: <20150605115527.d7c116e0dfbc751f066d417c@intel.com>
 <20150608180155.GQ14071@sirena.org.uk>
 <20150608123450.8acd0eeae32d852b39cab41e@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4786585967650266831=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 36ADE2617C1
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2015 13:53:56 +0200 (CEST)
In-Reply-To: <20150608123450.8acd0eeae32d852b39cab41e@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sergey Kiselev <sergey.kiselev@intel.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org


--===============4786585967650266831==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Content-Disposition: inline


--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 08, 2015 at 12:34:50PM -0700, Sergey Kiselev wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > This doesn't apply against current code, please check and resend.

> Weird. Works for me. I am using
> git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
> for-next branch.

Please note the "and resend" above...

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVm73HAAoJECTWi3JdVIfQ3goH/iiHNxDuTavk7opvapCNI7Ms
NV1n1qyuNoRnquzHYpShWPDC3adrpKXHWYcIHaXnf4+A341jY5A7q/9IHcMnh743
IyApLfmLcou4f5go5oAnNzpblJy0ayrxxvrt8TxXHKlTEF3ijZ5M63j0gltoXg4k
4hpjkyPaKIDgpyrC7TgjyjXaOeUE7PayVpK5BZHJbSdyAa76NnogQFt0wVXPp3+G
kWd+YwyG4EKXnaY5sr/1qzvhb9jz08yC/NSuQIyjJmYOJ8w2U40q+nKPRNAPoQJz
Ms6QrvMMcfvnvTKfOUBVzeOWL20NljCRTXBE7zt4fBNBLZXc1ZjPCoFiD6crGjM=
=v2ek
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--

--===============4786585967650266831==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4786585967650266831==--
