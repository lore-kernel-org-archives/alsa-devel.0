From: Mark Brown <broonie@kernel.org>
Subject: Re: Applied "ASoC: hdac_hdmi: introduce macro to
 access HDMI private data" to the asoc tree
Date: Fri, 1 Dec 2017 15:53:58 +0000
Message-ID: <20171201155358.2uz224exbtl4s7q4@sirena.org.uk>
References: <1512119602-2416-2-git-send-email-rakesh.a.ughreja@intel.com>
 <E1eKlcI-0001RU-QR@debutante> <s5hindqjydq.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3970976695308227059=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 591DA267029
 for <alsa-devel@alsa-project.org>; Fri,  1 Dec 2017 16:54:04 +0100 (CET)
In-Reply-To: <s5hindqjydq.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, pierre-louis.bossart@linux.intel.com, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Rakesh A <rakesh.a.ughreja@intel.com>, Ughreja@sirena.org.uk
List-Id: alsa-devel@alsa-project.org


--===============3970976695308227059==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yyt7bhxnihvx35fx"
Content-Disposition: inline


--yyt7bhxnihvx35fx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 01, 2017 at 03:50:25PM +0100, Takashi Iwai wrote:

> Isn't it a RFC patchset?  Please hold on.

These just look like useful cleanups to improve consistency and so on of
the code - they're nowhere near the meat of the series.

> The patchset includes the changes in ALSA HD-audio legacy side, I'd
> like to evaluate the whole at first.  Although it looks good at a
> quick glance, I guess this is the preliminary work for the legacy
> HD-audio codec support on ASoC, so the whole design should be
> discussed beforehand.

Right, I've not touched any of that stuff.

--yyt7bhxnihvx35fx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlohexUACgkQJNaLcl1U
h9Df2Af+I7PnJxugGoaSnUnjC+OwVSupp2eL9O6gdLUoGUycr5UbgL4BIsNxqiMv
ZJZwPXfyFtz7By5vcJBTWvsz8BqVEc9HAnHiGNvdX3NcvSaFFHA3xdvmGQmNTipy
66eoEoUr2pEH0Kwzga1oOfZb6P1DgYoCIwjRC46Qo/MoU23srC3j/dseBPlG4pt1
g6CkxKsdWu7dZpdurWSZwf1CggnZesLbDnDKbGDFeWjTYQq6fTsd2WO0T/bRNsW4
/TPnXUTlpRlByhuoMgXdj27tTs3oy66BQOm00u6BY7JFzoHFt9QHrWL7EzGl65Ex
EA+vVZN49OqhYe8iYA7X42zYnrY46g==
=wShQ
-----END PGP SIGNATURE-----

--yyt7bhxnihvx35fx--

--===============3970976695308227059==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3970976695308227059==--
