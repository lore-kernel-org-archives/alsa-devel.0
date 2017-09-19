From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/4] ASoC: dapm: Refactor the code in
	snd_soc_dapm_new_pcm
Date: Tue, 19 Sep 2017 13:32:12 +0100
Message-ID: <20170919123212.7ch5spt5hwbuaafl@sirena.co.uk>
References: <CABCoZhB7MJ=nvq_CAskJMfk6R9nt1uQ7EZ+szRz2bpbb6vGUow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3474535312980680259=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 41925266F0D
 for <alsa-devel@alsa-project.org>; Tue, 19 Sep 2017 14:32:14 +0200 (CEST)
In-Reply-To: <CABCoZhB7MJ=nvq_CAskJMfk6R9nt1uQ7EZ+szRz2bpbb6vGUow@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: anish kumar <yesanishhere@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, tiwai@suse.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3474535312980680259==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5krz4xxljvpc2qzb"
Content-Disposition: inline


--5krz4xxljvpc2qzb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2017 at 10:02:40PM -0700, anish kumar wrote:
> From: anish kumar <yesanishhere@gmail.com>
>=20
> refactor snd_soc_dapm_new_pcm to reduce the size of
> this function to facilitate further refactoring.

This doesn't apply against current code, please check and resend.

--5krz4xxljvpc2qzb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnBDksACgkQJNaLcl1U
h9BEKQf/YrcFcG6NYqo8vocBeci8XRIEjbEVpmcF+raZrRt0PyW/n2v5FptHR1Vz
yiPIjY3K4YqFHISAPMBxV5hhFqmmIr0wQy4g/DS6O8DJcY/HRt86Vs08+XcpF1i1
TqlnGYv5r3UnuVhYrnRqp6XAEjJc3wYmrmZ1hMym4jYr3QMQlD3PKLCR4pPMf+ZJ
cHhrGy4Spo/gGJXu82Iw9CLfUQR50S26BNQzyPZZuh/lls/b2Az9gcaHNGBFvwyO
WuywRGA26LJa/AWKFxgti+vSrfrpKBuLubCNvGwximldv46BHgMBBnGyg32y+aJz
aYyMLfO+QCZMe1N3LGKmcSY4/51vHA==
=sEln
-----END PGP SIGNATURE-----

--5krz4xxljvpc2qzb--

--===============3474535312980680259==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3474535312980680259==--
