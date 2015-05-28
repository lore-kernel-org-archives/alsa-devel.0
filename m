From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/3] ASoC: topology: Add topology core
Date: Thu, 28 May 2015 16:23:36 +0100
Message-ID: <20150528152336.GC21577@sirena.org.uk>
References: <1432574570-7436-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1432574570-7436-2-git-send-email-liam.r.girdwood@linux.intel.com>
 <20150527190021.GO21577@sirena.org.uk>
 <55661997.2050800@metafoo.de>
 <20150527194827.GP21577@sirena.org.uk>
 <1432824309.2726.44.camel@loki>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3271169304938059145=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4379A2604C2
 for <alsa-devel@alsa-project.org>; Thu, 28 May 2015 17:23:46 +0200 (CEST)
In-Reply-To: <1432824309.2726.44.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org


--===============3271169304938059145==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OERHbdkVeNHCzTtR"
Content-Disposition: inline


--OERHbdkVeNHCzTtR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 28, 2015 at 03:45:09PM +0100, Liam Girdwood wrote:
> On Wed, 2015-05-27 at 20:48 +0100, Mark Brown wrote:

> > Yeah, I was thinking something along those lines might be good long term
> > but it's definitely a separate thing to getting the topology stuff in
> > and I started worrying about things like multiple inheritance.

> Yeah this would also help in reducing memory footprint. Probably a topic
> for the audio mini conf ?

I think so.

--OERHbdkVeNHCzTtR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVZzL3AAoJECTWi3JdVIfQlFMH/j/tWWbltHNUWcjn8N1fNuFN
ougzt/gqBiTl1k9pbqOLXvV5oVZzfHSf4E+8UIxv3lYC8sM3LBkuhZTqEkdH8Bnp
C5y88m02RZS1zmogUUIWXHnjAFJFPA1zdUAyMmlUphLTlGhd4LIrjMppjCJ0X9d+
ms27eSfgIvGacxzXGPzk87w1S+GFtf8vssYfo0ELzg9WRKptZjOKhUKfocnGIiLE
7fJtri/oWn8SqQb3JMFUZW7J+sLZA+4YUrPVz8+AGesHSJ5okoDp/51iJQaJU/Z7
XdI1W9QvLfTxu8FKDorJMwqCZ7n7ldx/hmbpqHQc2P8R2DE2Zl4PRBfKPo69LxY=
=6aPi
-----END PGP SIGNATURE-----

--OERHbdkVeNHCzTtR--

--===============3271169304938059145==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3271169304938059145==--
