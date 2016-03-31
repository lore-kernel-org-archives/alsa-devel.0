From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH resend v5 1/3] ASoC: cygnus: Add DT bindings for Broadcom
 Cygnus audio
Date: Thu, 31 Mar 2016 11:23:07 -0700
Message-ID: <20160331182307.GQ2350@sirena.org.uk>
References: <1459277192-10942-1-git-send-email-simran.rai@broadcom.com>
 <1459277192-10942-2-git-send-email-simran.rai@broadcom.com>
 <20160331141308.GA9670@rob-hp-laptop>
 <CAES42Na+wM6P5yB3tg+bxk88txQA+52kgL8uwFqEW1XO8LfUeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ByALBa1F2BBmKLOT"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAES42Na+wM6P5yB3tg+bxk88txQA+52kgL8uwFqEW1XO8LfUeQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Simran Rai <simran.rai@broadcom.com>
Cc: Rob Herring <robh@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Simran Rai <ssimran@broadcom.com>, Lori Hikichi <lhikichi@broadcom.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org, Arun Parameswaran <arunp@broadcom.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--ByALBa1F2BBmKLOT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 31, 2016 at 11:14:53AM -0700, Simran Rai wrote:
> There was a change made in v4 that introduced assigned-clocks,
> assigned-clock-parents, and assigned-clock-rates, to allow initial
> configuration of
> default parent clock and its frequency.

...all of which are standard clock binding properties.

--ByALBa1F2BBmKLOT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW/Wr0AAoJECTWi3JdVIfQV5gH/17Sjgpt5PAUq4sXb6kovjL6
lCOr6qgTEhUel/aMGDlV7AxAV0RfH0SQK+Nrc0pnz+CCvRjbpQdZifrBNRYsERan
2Fp3hHt8JW17ikGuqawWUI7W9B8A0+X9o8fTT09gjfZS44kjv1oKIXsIkZH5NS4c
G/1NfcdmIQ9RyIMzNNWF50xx5cO5o+bvn2RX6yf72bd8d4zK1DJvc83EaUXOABab
4yujxfxhfBGO6fBTIIqCeGjTvQOvuMCNdQMlyYkuzyHQobsp8QBrP4RDJ1JRumUh
vb/H2JGANCDSFYkZ2NmPzts10ngyMSzq58vDNjcRsk1C2NMo6KEBX+bUgqCmibk=
=nhoh
-----END PGP SIGNATURE-----

--ByALBa1F2BBmKLOT--
