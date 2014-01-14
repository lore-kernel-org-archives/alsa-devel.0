From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 0/6] dma: Indicate residue granularity
 in dma_slave_caps
Date: Tue, 14 Jan 2014 21:29:04 +0000
Message-ID: <20140114212904.GB15567@sirena.org.uk>
References: <1389445341-17227-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3189258905008792201=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 72953264FD1
 for <alsa-devel@alsa-project.org>; Tue, 14 Jan 2014 22:29:18 +0100 (CET)
In-Reply-To: <1389445341-17227-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============3189258905008792201==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jE+K4o1MICf3EEet"
Content-Disposition: inline


--jE+K4o1MICf3EEet
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 11, 2014 at 02:02:15PM +0100, Lars-Peter Clausen wrote:
> New in v3:
> 	* Expanded the kernel doc documentation for the dma_residue_granularity
> 	  struct a bit

Applied all, thanks.

--jE+K4o1MICf3EEet
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS1awdAAoJELSic+t+oim9Gr8P/3NyHfWW9xLWvQRpKVe9/y3F
Rnxjp7a+CQxBpsk7xkjiF7rGg+IdgcIWuB+GRzQTRbzLSylgGKAdpulwLTiMEz7d
/0t+bXu5ndszUe/+jyrBw8Djs4Jkhf+CeP0Hmp6KPR5EIZeuPaQcSHzn5WmVWOi1
Di7ySblqv52mgmrHktoU6bKPRbxcFuhXvewVg0OnS36TRer0js5ibPYv+bECzTcS
TkQS0rYiLftpMj5fkb4hsBYyHVeSkCo9iiNHIUMZKgtb2y/UYxWnQ3YG7XgSVX/S
1Yvyo+ypvrcv/DUmIRLXbyvEg6wF2P+ZBBL5oSEalX2qtUZM5N9i7FekhYnFYSlT
cuocKB/4pyATzIpv7RrB+dHbvvsilq0orwoYj9TCUpP29fsHuZdYjgxBym/IRPIL
iLsy2pLrhMTZb628mndBiiq1cb2N0aBnnwVlTSddbA2GCho3NzzU9+W0depiLS1q
Ma8wWtNq/zipbZKsnC5oM438c4cL1qWPIUcWOb1jZn/A9KpS51FeLZHbMgVo+uap
/rPuPU+TYkd9EWlcyBzprZyFXWOpSg0Mx4Ou+EiiuqO91B+IcK6MR1w/we1N603Z
YDcy4Nl+ktgb/ow5CG1LBVY9Q4ANBaMOgLbBbYhd7p//g9+5iCmSABmhQXjYfr07
NMOBmMaCI/rbfgi1kw1V
=QcVq
-----END PGP SIGNATURE-----

--jE+K4o1MICf3EEet--

--===============3189258905008792201==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3189258905008792201==--
