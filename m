From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/3] ASoC: Intel: Add Kabylake machine
 driver for RT5514, RT5663 and MAX98927
Date: Tue, 13 Jun 2017 21:25:29 +0100
Message-ID: <20170613202529.2acgiwzeeh5omy4h@sirena.org.uk>
References: <1497046734-31753-1-git-send-email-harshapriya.n@intel.com>
 <1497046734-31753-2-git-send-email-harshapriya.n@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4098070298385852544=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9AF6D266F88
 for <alsa-devel@alsa-project.org>; Tue, 13 Jun 2017 22:25:42 +0200 (CEST)
In-Reply-To: <1497046734-31753-2-git-send-email-harshapriya.n@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Harsha Priya <harshapriya.n@intel.com>
Cc: tiwai@suse.de, vinod.koul@intel.com, alsa-devel@alsa-project.org, Hsin-yu Chao <hychao@google.com>, Naveen M <naveen.m@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============4098070298385852544==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iwvzn2slwx2hoozl"
Content-Disposition: inline


--iwvzn2slwx2hoozl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 09, 2017 at 03:18:52PM -0700, Harsha Priya wrote:
> This patch adds Kabylake I2S machine driver which uses codecs
> MAX98927 as speakers and RT5514 as dmic on ssp0 and
> RT5663 as headset on ssp1.

This doesn't apply against current code, please check and resend.

--iwvzn2slwx2hoozl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllASjkACgkQJNaLcl1U
h9CQ3gf9GN0HFVWK3CkNm2ooUR77gSasD/FX9iRwT6rFQQ8HLHQa7Ia1LDL8JuoB
i1Npnu30nm9q3Y3TUY9B5XiSToBIf3XpSpQamDKIZiwaWIBMSWwqXMByeouGrJfq
IWfqygb7SHDugd51iqbX+S5+F35Ps3QQCdNayGmOZM97zwqr906Uqs7zBvSUzQGj
BKjPcOxI6LPn4eH5nqkQyETqqtIKpviUPnigihLcXIcxL0vyyTTC3jASME+RZ1DH
YRvsuqoOh2MYx91+u1PJvBX+nJod/Ihf2HefuNFi8VG7A0CVR2eyVwX5v2eIYI16
U5KCaF9uUaGfreR6bSWBlsZOE0JJng==
=2mJh
-----END PGP SIGNATURE-----

--iwvzn2slwx2hoozl--

--===============4098070298385852544==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4098070298385852544==--
