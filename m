From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: codecs: wm8753: Replace magic
	number
Date: Sun, 26 Jun 2016 02:18:24 +0100
Message-ID: <20160626011824.GH28202@sirena.org.uk>
References: <1466830689-31587-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9111884236901690228=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E21C82651C7
 for <alsa-devel@alsa-project.org>; Sun, 26 Jun 2016 03:18:32 +0200 (CEST)
In-Reply-To: <1466830689-31587-1-git-send-email-shc_work@mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============9111884236901690228==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/xevKuQXtvXNcizp"
Content-Disposition: inline


--/xevKuQXtvXNcizp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 25, 2016 at 07:58:09AM +0300, Alexander Shiyan wrote:
> Use SND_SOC_NOPM constant, instead of -1.

Please submit patches using subject lines reflecting the style for the
subsystem.  This makes it easier for people to identify relevant
patches.

--/xevKuQXtvXNcizp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXby1fAAoJECTWi3JdVIfQKEsH/Ajeq/rhlG126OFgcXS9wy95
0J82gFX3zS6HSuhs82fxG3yOcb66Ac39aHVxNknLNv0G5wXDRxUFfCVaHtP3rGZr
jq/Z2vIqse3bq8C9wfOSjC9HO0oEzU8MS7c4XgdYPTSKwZQb1Tw9xI3JF/In9Qlo
Khgq6xKCTVRTZC1sOgVbEZ5HnoiHnlp0Kg65GmgDUe2nbgEVuf9gfmG2wK/tZ+SR
CsBRJ3hVyl6Y9DytPV1PtNVUhvYoFNqEfwOKBxTjK43JamVEoeTaRRUW1QIorq7M
DJFzXKKcZbfbEG7HNZCDCSKlGnwJv8CCCxPPMoc7nnsycZVjXjBB1wDUr3EtNjE=
=GNa3
-----END PGP SIGNATURE-----

--/xevKuQXtvXNcizp--

--===============9111884236901690228==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9111884236901690228==--
