From: Mark Brown <broonie@kernel.org>
Subject: Re: [asoc:topic/max9867 2/4]
 sound/soc/codecs/max9867.c:294:11: error: 'component' undeclared;
 did you mean 'complete'?
Date: Thu, 1 Mar 2018 21:36:30 +0000
Message-ID: <20180301213630.GW12864@sirena.org.uk>
References: <201803020314.sOjeazAH%fengguang.wu@intel.com>
 <20180301200155.GA2304@lenoch>
 <20180301200430.GA23704@sirena.org.uk>
 <20180301213436.GB3833@lenoch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0573605390197060152=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E9A2A267C56
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 22:36:37 +0100 (CET)
In-Reply-To: <20180301213436.GB3833@lenoch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: alsa-devel@alsa-project.org, kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org


--===============0573605390197060152==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kjzasy1UhXmRStS5"
Content-Disposition: inline


--kjzasy1UhXmRStS5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 01, 2018 at 10:34:37PM +0100, Ladislav Michl wrote:
> On Thu, Mar 01, 2018 at 08:04:30PM +0000, Mark Brown wrote:

> > Which other commits in my tree does this depend on?

> 91880a6b6ba3 ("ASoC: wm9867: replace codec to component")
> Note, we have naming problem here...

Ah, I see.  Like I say, please resend.

--kjzasy1UhXmRStS5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqYcl4ACgkQJNaLcl1U
h9Bf8Af+PO2ji62oAWc4Isl/3K+cxBW2VpUU6+Rc4t6ZCIYvMa+09HmuLXk7OKBw
PSC539rIRZuuB/A5EORtez24MQ3TKmdjfxgDgFdXE4pSo66eaW3eowKZhxrQbXis
S77Y/bdGHm2HgMFGF8qS7aUjjPFnF385VKQ235mkCFM6eTlp1vf4qXGOfjjNvXu6
twztlnTp2rXi+AiDzTXzgDc9GiY+k1KSv01mI3uYAjgMCXJ0O0BMUPUf9DzK/sd4
bTfLcnn623xPTm9i+VOk3MpX5orF6IKCoZqMQNxOhAHVd0X4qbSJjWatGVUHRuou
rxXbOX9fE8BJgtmRyhSjhnQIkPpaCA==
=lGvw
-----END PGP SIGNATURE-----

--kjzasy1UhXmRStS5--

--===============0573605390197060152==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0573605390197060152==--
