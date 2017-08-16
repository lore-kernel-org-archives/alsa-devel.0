From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: compress: Set reasonable compress
	id string
Date: Wed, 16 Aug 2017 13:06:52 +0100
Message-ID: <20170816120652.77eqk6tni5g4sn3u@sirena.org.uk>
References: <20170808032829.11859-1-pengdonglin137@163.com>
 <CAErzpmsV-q5dN8ukdWxgNbGTaDq=MeKNf=AXKQKoHtrdMuzvxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7221096169160302405=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0027E266B1C
 for <alsa-devel@alsa-project.org>; Wed, 16 Aug 2017 14:07:02 +0200 (CEST)
In-Reply-To: <CAErzpmsV-q5dN8ukdWxgNbGTaDq=MeKNf=AXKQKoHtrdMuzvxg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============7221096169160302405==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3o2iahlknj6yxgz7"
Content-Disposition: inline


--3o2iahlknj6yxgz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 08, 2017 at 11:31:21AM +0800, Donglin Peng wrote:

> --- a/sound/soc/soc-compress.c
> +++ b/sound/soc/soc-compress.c
> @@ -737,9 +737,6 @@ int snd_soc_new_compress(struct snd_soc_pcm_runtime
> *rtd, int num)
>         }

It looks like your mail has whitespace damage, it's been at least word
wrapped, so I can't apply - please check and resend (git send-email will
usually do the right thing).

--3o2iahlknj6yxgz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmUNVsACgkQJNaLcl1U
h9DzOQf/byUzHGS3OGFGXjccNjGSnxGSBHQ3+b3tHAevrb7NvC6D05G3TQmDHBNz
GWSXxE8nrGwYMGxst6iUBF3UNY9lLJSq3q1QikDEP+FeQ6EvlPXpTnUhKob59ECy
SIeazo+WRZCe9ACkuXgxcYrlAPM5227HZufiveVXtKOSU9WBgwKWlISBvUuYNtgE
COYYzQPfOvC2GKf4e2MWqtT7rQ0W7RmU5CI1KP9R7flnFit2iL7Z/OCZe0tlttdS
W5mWIH7njS2Ecs6Juw/cEaUGViYsrEpur9popxM88fzDUAdEBfsnwWDVpTEBL6UZ
f8NiwzG3k+1P/6B35L4uHednVQ5Vtw==
=3csF
-----END PGP SIGNATURE-----

--3o2iahlknj6yxgz7--

--===============7221096169160302405==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7221096169160302405==--
