From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: rt5670: fix wrong name of sto2
	adc 2 mux
Date: Wed, 26 Jul 2017 12:29:36 +0100
Message-ID: <20170726112936.bubd7zmvvzlvatnc@sirena.org.uk>
References: <1501054106-25264-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0150218164086948609=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C2022673F8
 for <alsa-devel@alsa-project.org>; Wed, 26 Jul 2017 13:29:43 +0200 (CEST)
In-Reply-To: <1501054106-25264-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, shumingf@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============0150218164086948609==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="au5hr3s4vdue43s5"
Content-Disposition: inline


--au5hr3s4vdue43s5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 26, 2017 at 03:28:25PM +0800, Bard Liao wrote:
> The kcontrol name of Stereo2 ADC 2 Mux is not matched with what we used
> in dapm widget.

This doesn't apply against current code, please check and resend.

--au5hr3s4vdue43s5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAll4fR8ACgkQJNaLcl1U
h9DozAf8D+4oPfwJ4MoezsAvIl7eT7/uZIMBwmndJCSD8AlFTRDCthloAN0ceESM
2aXwxha1MtAhHSsHA4VR/ikMTOzSH+K+ohdztxCyUocn8Datl8k6MxD257+adDKy
4lFZzHw+BLW/KTCGk3xP8/t5b+c0Lso7j4s9DuluR61SGD2Nd3B9mfWtxeehAj+m
WvNlwmVqMvOOZltvxi+AeQ+9mzN9sM4tfBoutTK/MputVReFEykzkoVWgExtEED7
1pxuLRMleNhwnywDVwHruuw95cIS7fSXkQvnpY4EH3PDU+tZOTOeZsiRwhXdbqZw
pRPJB2/6HPT6/jJMEUbMc+ZZefniTw==
=sYDu
-----END PGP SIGNATURE-----

--au5hr3s4vdue43s5--

--===============0150218164086948609==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0150218164086948609==--
