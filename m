From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 057/102] ASoC: wm8974: Use
	SOC_ENUM_SINGLE_DECL()
Date: Sun, 23 Feb 2014 11:42:04 +0900
Message-ID: <20140223024204.GW25940@sirena.org.uk>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
 <1392723517-12772-30-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0787424650151459711=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F74A261631
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 03:42:19 +0100 (CET)
In-Reply-To: <1392723517-12772-30-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0787424650151459711==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uR2Be0xXxbzP+34t"
Content-Disposition: inline


--uR2Be0xXxbzP+34t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:38:13PM +0100, Takashi Iwai wrote:
> Just replace with the helper macro.  No functional change at all.

Applied, thanks.

--uR2Be0xXxbzP+34t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCV/5AAoJELSic+t+oim9+e4P/jrmhH3jalQs10D3Pl0Yq2kR
NeOSKcXDJKhRQbfaEDFYmk61jzgiSlll1OAvs97uQxHqzww56DWf9iEWOqBAhW/2
eZcLZMhfvQqEHLGdzFKAiW52KHN378dwkUvsVb8AWLbEEaiUDxZoBBr4HjUQhbpE
q/yGv1LTUMkaZQPblT2wlXLZQ0ogleThxCGVdhMjJg8+0tKclkBdEqxl9BrI49+d
uvmu4Ksb0Mk3DQK3Fo0Xxn8PXOKIUApTMNLWWJQg9QRnuWnMEKU1kIm1aBPc35xT
ZHbwkNmY4LVLTtTFK6pTe1HcFGbkBblO7/ysrbLYB8FLwqlw+Pap1j/hpjrsPGTU
kQEq+sdSFdxHwDmxSe8yas0BMPcscR/aVQQoYYRSKYmm3vtLwjjvqvV5ktJHlw37
2JIwgdXi5bdCGEm7J+985AAfxrZ1P552I0XrWjI0gF2IuGaIGw7tNVXL+ttPmsRH
0mL4pQd2JgwG5X87R4sRt4yTN2y2T1efLI6DA8paIexkeEZKW1DJRtBeZAD6Qadw
OKkpc7Bkdqx54j4I5dxwVNj3ENwet4GteVB5TI17rNF+/awXoHQiV2l0fV24UaGi
8EL2KFSZcYYqBOTW5FvCNZBd4MBqWs5cLT7/6a08n5di0Uha0Qcp2O7H+KPQLGCo
pDLv2MxYXErMcUzjr2Gt
=8Z0C
-----END PGP SIGNATURE-----

--uR2Be0xXxbzP+34t--

--===============0787424650151459711==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0787424650151459711==--
