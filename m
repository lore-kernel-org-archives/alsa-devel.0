From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: compress: Correct handling of
 compressed ops
Date: Wed, 24 Jan 2018 16:05:51 +0000
Message-ID: <20180124160551.GH9366@sirena.org.uk>
References: <20180124135525.5633-1-ckeepax@opensource.cirrus.com>
 <20180124142901.GG18649@localhost>
 <20180124144915.p5fo2pypnawqbj66@localhost.localdomain>
 <20180124153330.GF9366@sirena.org.uk>
 <20180124160029.3qurs4cm75owjptn@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1336945391033105989=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 82528266C0E
 for <alsa-devel@alsa-project.org>; Wed, 24 Jan 2018 17:05:57 +0100 (CET)
In-Reply-To: <20180124160029.3qurs4cm75owjptn@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, lgirdwood@gmail.com, dan.carpenter@oracle.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org


--===============1336945391033105989==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4LFBTxd4L5NLO6ly"
Content-Disposition: inline


--4LFBTxd4L5NLO6ly
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 24, 2018 at 04:00:29PM +0000, Charles Keepax wrote:
> On Wed, Jan 24, 2018 at 03:33:30PM +0000, Mark Brown wrote:

> > This doesn't apply against Linus' tree so that's not going to happen...

> Shall I split it into a crufty fix and then a tidy up?

Without seeing how awkward the crufty fix looks it's hard to say, use
your judgement.

--4LFBTxd4L5NLO6ly
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlport4ACgkQJNaLcl1U
h9DXnQf8Dp2xwztwAuIbKtZ1TrkL4ht1MCeaDA0Hik/SsmU7QtHSIw0zXaOmyrYt
UUejLG+srhTauazUcDvErwlDw6SnzajyN7/muw43q50w+bDD9RSjR53vNF9CGZHG
Hcau6ASv36aiCrAvPBMJOa3xARgaE58gpThdI3R7vzwnCmaN5bvHTgnjgirzWHY3
t6HkDpcSiWIdf/kRkbibK9OYUcMJ1RGa7peHVr+3jPLb8/0/kaoFShO2wwP9lfe8
3jd7ggEcBLe4dY3RB02QqsjtY4mI2EAziXGg8mhHBY7eRyIS6wq03tZxJfAJp3u4
nJt9Zx4ikX7VbCRXTiQI3749cvWBcQ==
=1kLK
-----END PGP SIGNATURE-----

--4LFBTxd4L5NLO6ly--

--===============1336945391033105989==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1336945391033105989==--
