From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH REPOST] ASoC: tegra: complete
	Tegra->Tegra20 renaming
Date: Fri, 6 Apr 2012 17:36:32 +0100
Message-ID: <20120406163632.GG19424@opensource.wolfsonmicro.com>
References: <1333729852-28692-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6725332485878333289=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 83F932444C
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Apr 2012 18:36:36 +0200 (CEST)
In-Reply-To: <1333729852-28692-1-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============6725332485878333289==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DNUSDXU7R7AVVM8C"
Content-Disposition: inline


--DNUSDXU7R7AVVM8C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 06, 2012 at 10:30:52AM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>=20
> Rename Tegra20-specific Kconfig variables, module filenames, all internal
> symbol names, clocks, and platform devices, to reflect the fact the DAS
> and I2S drivers are for a specific HW version.

Applied, thanks.

--DNUSDXU7R7AVVM8C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPfxuJAAoJEBus8iNuMP3dM2MP/2u3Di+0zQB7PzJGyn2miuxw
O/QRcTquLF78QyZY9bM1ni4MDl5Te4diJO40maulkYz4yNnEq7Hw7R+s2mMIzfnr
PfQ5DacEFySUIlVWlhXrn26dyA4pWdc2o5WKUxsKVYbgIpprWv4mD47xlKnQMViO
33AS0XGkEFLJgQR2WntyC/OKE8uKSmIIXh0KuM8tArWAAtiVW5ifbWTlldnsY/9b
pCru0yiV6iumToZXiCZEbNl1UjB8PxDe5TtLCQ9nrNwloPAEDVNIwvsTm0r+mvXu
2ELgpRWWYT5xHDllnVaom5Lj+y8W7WdLoTSt8WAP5DqvXia3FGg9D2nTlGVWZS7w
/Q02YpaufwOKTuUlFVMx9HPkP+9QK6kLK9CtzBaG7MNvVBy2Eh1qirpilGIZioyD
vbsH4BPanckkghNrzxRDPc9vun7+Mfk9hamWatW33fnNMMUKpGTci5XcY9xU5O8k
I282N+sNnTJPB8QThVR+C8u5g1ojEweGMXaHBZc0xG2+djrj4YvoZqSbahL3EC9I
C1oD3q8r6cy9q0ehS6SXwCQV1Ksmvy0Hf7uLUwQfVcB+HFqfLiVTQf0huk6o6Ow6
n0oIQh6fDIAu0NSwcGCap81CPhvzPqXN/9BfS9sUfLyvFsrK1btZB9orIWYJkxUe
28037Odv253mhzsZaljR
=KzRG
-----END PGP SIGNATURE-----

--DNUSDXU7R7AVVM8C--

--===============6725332485878333289==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6725332485878333289==--
