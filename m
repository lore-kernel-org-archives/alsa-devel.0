From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: Intel: Skylake: fix pointer
	scaling
Date: Mon, 22 Feb 2016 12:16:56 +0900
Message-ID: <20160222031656.GS18327@sirena.org.uk>
References: <1455862354-6455-1-git-send-email-vinod.koul@intel.com>
 <20160219153345.GO18327@sirena.org.uk>
 <20160221030456.GO19598@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9203535524671935515=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C4B57265A86
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2016 04:17:25 +0100 (CET)
In-Reply-To: <20160221030456.GO19598@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, Alan Cox <alan@linux.intel.com>, Alan <gnomes@lxorguk.ukuu.org.uk>
List-Id: alsa-devel@alsa-project.org


--===============9203535524671935515==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hTpalTKak4w3chvU"
Content-Disposition: inline


--hTpalTKak4w3chvU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 21, 2016 at 08:34:57AM +0530, Vinod Koul wrote:
> On Sat, Feb 20, 2016 at 12:33:45AM +0900, Mark Brown wrote:

> > Please ensure that the name and signoff match up.  I'm fairly sure that
> > both are for the same person here but it's not something I should have
> > to think about and it is important to ensure that we have signoffs for
> > everything.

> Ah, sure will do. I think Alan wanted the SOB from his empyer ID. Alan how
> do you want me to fix this :) I will send this

Well, I already applied this one anyway since it was a fix (though I did
skip patch 2).

--hTpalTKak4w3chvU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWyn2nAAoJECTWi3JdVIfQVqAH/1mB7rSU/M1BJ1l8/VgO+X1q
N6/tJXjTnUfSdWnWSuopfjtfrUPDg7ycdK5uqeQcIxfbulB1OAGzJ84MbcoUfo6h
AoIzFN+kSkcDyhkiFCZWa4K1F3VDbIGksfmsZOBsMu4TuL3ynv2l6I1D5FRtRqF8
2IT6IIRSMzadxJ7LgoRVgA+ODkz7cqj1cGiWrK6wNtUuK3hqW04+zKNBcWrcPGFm
z2RJHpaMSVZn/z5ZpDdvJGql1lFSD3l95oBK9NEt3BJG5A6pkG2tSrM/FjHoOwFx
v+wPm/OlXoOwLmR0UyZNq6qij5YlXFos/klsms2wyscITj27viL99LrVifwhHDA=
=P9G4
-----END PGP SIGNATURE-----

--hTpalTKak4w3chvU--

--===============9203535524671935515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9203535524671935515==--
