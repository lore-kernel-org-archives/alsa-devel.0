From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6/6] ASoC: Intel: Skylake: Add more
 platform granularity
Date: Thu, 13 Dec 2018 18:21:48 +0000
Message-ID: <20181213182148.GY10669@sirena.org.uk>
References: <20181207235008.22988-1-pierre-louis.bossart@linux.intel.com>
 <20181207235008.22988-7-pierre-louis.bossart@linux.intel.com>
 <20181213153710.GO10669@sirena.org.uk>
 <4d3fb881-596b-8c7c-22bc-d497460064ab@linux.intel.com>
 <20181213175444.GW10669@sirena.org.uk>
 <46ed95dd-9408-43e0-8849-92acedfa7c24@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2811340241642206794=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1375326789E
 for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2018 19:21:50 +0100 (CET)
In-Reply-To: <46ed95dd-9408-43e0-8849-92acedfa7c24@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Filip Kaczmarski <filip.kaczmarski@intel.com>, tiwai@suse.de, Chris Chiu <chiu@endlessm.com>, Cezary Rojewski <cezary.rojewski@intel.com>, Daniel Drake <drake@endlessm.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, Michal Wasko <michal.wasko@intel.com>, Gustaw Lewandowski <gustaw.lewandowski@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============2811340241642206794==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7tPHY7RFL01rOa8z"
Content-Disposition: inline


--7tPHY7RFL01rOa8z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 13, 2018 at 12:02:58PM -0600, Pierre-Louis Bossart wrote:

> > > This is odd. I just rebased on your for-next branch (SHA1 below) and see no
> > > issues? Did you push your latest changes? Or maybe this conflicts with Hui
> > > Wang's new KBL machine driver stuff?

> > I'm guessing it's the latter.

> ok, i'll wait a bit then for the remotes to be updated, I don't see it yet.

I did a push a few minutes ago, there's no unpushed changes here - let
me know if I missed something here.

--7tPHY7RFL01rOa8z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwSozsACgkQJNaLcl1U
h9ADJQf+JENXQ8LHZRjfB7gCy6XFoa08iZhdrchuSpyk0Y54VVI54E4lWHi6/3tS
UZBhORLO9qRDMs5JzajwYI3CAf0TUejDB03V59GwbZd8uHuDDU/6owqup9S3ToQm
Mr9MwMHKp8MFwcpLKSCRVIVQjlM+FzNdhHidiNz2rTb3Leed+glcOZFOsAgFT1k7
bqWRJmaOrKOS0YLoJzz/92a20ig/hjpvmh3GH+rIcz3kH2zpN2FmKlaLIPXOAsdP
5/4FV+gWzyoLg6d7G3I10nCUpm/l+ycL7/qbGJUv5vkKUDoHhcpe8yncrr1FsPTD
4FTdVFJyoNfWEjple4HENA1BMqiXyw==
=Xsl4
-----END PGP SIGNATURE-----

--7tPHY7RFL01rOa8z--

--===============2811340241642206794==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2811340241642206794==--
