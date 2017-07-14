From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_asrc: constify snd_soc_dai_ops
 structure
Date: Fri, 14 Jul 2017 12:02:33 +0100
Message-ID: <20170714110233.fqkmgy7kyhje7mfy@sirena.org.uk>
References: <20170713072351.GA1485@embeddedgus>
 <s5hlgnsiyg6.wl-tiwai@suse.de>
 <20170713101630.odml56qmsvgxqj64@sirena.org.uk>
 <20170713101814.Horde.q8OhHejhvSALVEt2o11aUTW@gator4166.hostgator.com>
 <1499969891.4457.59.camel@perches.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6qhuysr5s74trsda"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1499969891.4457.59.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: "Gustavo A. R. Silva" <garsilva@embeddedor.com>, Takashi Iwai <tiwai@suse.de>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--6qhuysr5s74trsda
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 13, 2017 at 11:18:11AM -0700, Joe Perches wrote:

> I don't it's better.

> It's not that confusing if the 0/n patch cover letter is cc'd
> to all the appropriate mailing lists and all the [1..n]/n
> patches are sent with in-reply-to of the cover letter and
> send to the maintainers and appropriate mailing lists.

With large serieses like Gustavo is sending the CC list can easily hit
the points where mailing lists start blocking it, and the individual
pathces really do need to go to the relevant people so they have sight
of them.

--6qhuysr5s74trsda
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllopMUACgkQJNaLcl1U
h9AIjgf/aGUdXWkZoKBsOp3IdmBmoESoDqvSNzY8Z3XObcXqhsfE9+TWaYfmaXvn
sgJsxVqWacBDNJ2d0++ac6jK19t+q4DJrRQDzEiGpJ+bG1QaX/ikZJXCVfuDFF5c
J3v+Oz6yY5StC+1IAGZVFPskrdXFqnVuQL7gH+hZRJSGnd/vIjaRdfDkgB452QhK
YcrSFEkMcsJVjKmdOqCBFwUFujROfHAq65IY8p/2vJxWfXmR2X8RLduvqW+ZdVoh
mu0SHJO/Hu9U1FKaG/6wzTeacPrdf4+Pj9b7nYc21unBC2ozQjuPkgpdjCHF7G6g
FUjZRS9h4p9HPFWmV2DipKd4m8BkhQ==
=DNS5
-----END PGP SIGNATURE-----

--6qhuysr5s74trsda--
