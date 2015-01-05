From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6/13] ASoC: Intel: Delete an unnecessary
 check before the function call "sst_dma_free"
Date: Mon, 5 Jan 2015 18:22:28 +0000
Message-ID: <20150105182228.GB2634@sirena.org.uk>
References: <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
 <54A9355F.4050102@users.sourceforge.net>
 <54A93B5A.9050504@users.sourceforge.net>
 <20150105143551.GQ11764@sirena.org.uk>
 <s5hwq51fe8g.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2216389212840317873=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 09D09260441
 for <alsa-devel@alsa-project.org>; Mon,  5 Jan 2015 19:22:57 +0100 (CET)
In-Reply-To: <s5hwq51fe8g.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Julia Lawall <julia.lawall@lip6.fr>, SF Markus Elfring <elfring@users.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--===============2216389212840317873==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Content-Disposition: inline


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 05, 2015 at 04:18:07PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > I'm missing aptches 1-5, are there any dependencies?

> No, all individual fixes.

OK.  SF, in future please always send at least the cover letter to
everyone getting patches in the series so they know what's going on.

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUqtZjAAoJECTWi3JdVIfQeNcH/3X8H4IzkkQQ5jiXGlyJmMh5
PNJuWtY07rolZEkeAOIz0VmMwEST1buBcrqUIvhvX0UbsYeQsqOzhtZMqzgMkK4Q
ZaytOezwik61dmI4fNXAzUTyU0vQ+ydYFwulygLYi/t5D07wp2UeAziPRrCcAHal
rfRR59FAzaoLmsRz8zrEwsf3aMip993bU9Yemf1YAM6X8+8zjRor4P+AtGPZCR0z
7f1kOsk/P7HSEW6KC6egCOHNxM1dHOCP3zNO+nnUBBPDiqOxBtMxQQODy/TuwMro
IVclQPJTDr91gOKMAnr9vmEgKXULKLtp/4eXZ2LWXn9n7ao96vd9KPTHWWaSQqc=
=xW1v
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--

--===============2216389212840317873==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2216389212840317873==--
