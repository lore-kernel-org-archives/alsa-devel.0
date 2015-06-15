From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: DAPM: fix build errors for missing
 snd_soc_dapm_new_control symbol
Date: Mon, 15 Jun 2015 19:20:22 +0100
Message-ID: <20150615182022.GZ18309@sirena.org.uk>
References: <1434386871-24325-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <20150615165723.GY18309@sirena.org.uk>
 <1434388233.2434.52.camel@loki>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4929520896925313933=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 28EB92652E9
 for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2015 20:20:37 +0200 (CEST)
In-Reply-To: <1434388233.2434.52.camel@loki>
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
Cc: "Koul, Vinod" <vinod.koul@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4929520896925313933==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PjJwPjbdn5RfZuWK"
Content-Disposition: inline


--PjJwPjbdn5RfZuWK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 15, 2015 at 06:10:33PM +0100, Liam Girdwood wrote:
> On Mon, 2015-06-15 at 17:57 +0100, Mark Brown wrote:

> > This doesn't apply, I appear to have this already?

> Oh, ok - Vinod reported it was missing earlier and I could not see it in
> your topic/topology either ?

It's a change for DAPM, it's on the DAPM branch.

--PjJwPjbdn5RfZuWK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVfxdfAAoJECTWi3JdVIfQ5iMH/0x587Bz4zOQJQ1MNx4LQtvR
AqCjHa8r9yhBoovZUjE+oyD5Pt9abEJPxZQXDCUQnIrSbZNEJZdyHIZg8WD0ZkgD
Lu7uyzVYrt3fL2eoYdpC/IUtPIQgbZazZSWxmxM9dLTq+OoG3ozE7u3fwxf41PdN
mA58WdyLIy/JMiJ3ii1sDU/pgdOA6c7pMC+tO6lKArUQJ1ZPpGx7QyQmHYIO3JCc
GMILDhGzIdMdIxM0bVdwTYGp0fWwxGfcO+F8l2kjD/FZRLhBujSPcCvBL38DQZix
adp+YF8bHe7L4unIZ8CqUzxvocWo9GqaIMvGtvBvAqGjhZ6dzwAddlYmG3Et2+0=
=hsqg
-----END PGP SIGNATURE-----

--PjJwPjbdn5RfZuWK--

--===============4929520896925313933==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4929520896925313933==--
