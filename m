From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/3] ALSA: hda: bus cleanup
Date: Thu, 8 Aug 2019 20:03:43 +0100
Message-ID: <20190808190343.GK3795@sirena.co.uk>
References: <20190808095715.29713-1-tiwai@suse.de>
 <ae7d32fe-a279-8309-2370-1832edcce413@linux.intel.com>
 <s5hr25vhg22.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2272204297572513692=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6B83EF800E3
 for <alsa-devel@alsa-project.org>; Thu,  8 Aug 2019 21:03:49 +0200 (CEST)
In-Reply-To: <s5hr25vhg22.wl-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, Jie Yang <yang.jie@linux.intel.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2272204297572513692==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IA03tywDYuoVKXrw"
Content-Disposition: inline


--IA03tywDYuoVKXrw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 08, 2019 at 04:45:09PM +0200, Takashi Iwai wrote:

> I don't mind who actually merges.  I'm going to push out my topic
> branch once after gathering enough Ack's.  Then Mark can pull it into
> his tree (as well as topic/hda-dmic branch).

I can do that easily enough.

> Or if Mark can give me the branch, I can pull into my for-next
> branch, too.  Basically my for-next branch is persistent and not
> rebased, so you can work on it once when set.

> Mark, just let me know your preference.

Well, I don't have topic branches any more since Linus hates them and
it's always hard to write sensible summaries for the development when
it's half way through so...

--IA03tywDYuoVKXrw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1Mcg4ACgkQJNaLcl1U
h9Ciswf+LIQHuD1FFpYRf8ibMYcWDcoLna+z8NANkdKoVGcF6vPPVe8KOT8VM8d5
WorAhIPo3oV38q2LDXH8kjxtZ3O0jSnQ5RWUOzwzCaVMS37FnoEiK11BwVRWZh7J
MNwMQOorCnv8ZUUlH8ibV47MvevOpT6XBcD9jpaP7ezXA22k4Yeu1RZ9EgYiYppI
uaK2+8VzOgJzhyGnpU5DGU8BXtzepC8LNY2rNFmswtvjRU3BM9TB/D93fFUGM70l
R2AEN69YxotoDo12GrEOUjoKynVh2tx47+Y3GlT/PIbPcFm9JciI/8158FxoEOax
OdQkR3OuHIScR8dPy7d6PHTBMnWz2A==
=ARRp
-----END PGP SIGNATURE-----

--IA03tywDYuoVKXrw--

--===============2272204297572513692==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2272204297572513692==--
