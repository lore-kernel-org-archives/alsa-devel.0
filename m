From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v5] ASoC: Support TI LM49453 Audio driver
Date: Thu, 29 Mar 2012 22:30:16 +0100
Message-ID: <20120329213016.GB4153@opensource.wolfsonmicro.com>
References: <290463D19D2E064191F1F96ECA480A89434B1A69FD@EXMAIL02.scwf.nsc.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7189733281273717145=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 23B1C104548
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Mar 2012 23:30:19 +0200 (CEST)
In-Reply-To: <290463D19D2E064191F1F96ECA480A89434B1A69FD@EXMAIL02.scwf.nsc.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Reddy, MR Swami" <MR.Swami.Reddy@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
	Liam" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============7189733281273717145==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uQr8t48UFsdbeI+V"
Content-Disposition: inline


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 29, 2012 at 07:21:13AM -0700, Reddy, MR Swami wrote:
>=20
> ASoC: Support TI LM49453 Audio driver
>=20
> The LM49453 is a high performance audio subsystem that supports both anal=
og and
> digital audio functions. It includes a high quality stereo DAC, a high qu=
ality
> stereo ADC, stereo line level outputs, stereo Class D haptic drivers, ste=
reo
> class D loudspeaker amplifiers, class D earpiece amplifier and stereo cla=
ss G
> headphone amplifier with microphone detection capability.

This basically looks good and I was going to apply it but unfortunately
it looks like your mailer corrupted the patch and replaced all tabs with
spaces so the tools don't understand it - can you please check and
resend?  If you're really stuck try an attachment but ideally not.  A
personal account might also work (all the Marvell people used to use
gmail for submitting patches for similar reasons).

Some other TI people can probably help you out here, I know a lot of
them have been through similar hassle setting up the mail system there.

--uQr8t48UFsdbeI+V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPdNRYAAoJEBus8iNuMP3dgXQP+gNKEiZzE7rmA6OMrbvtLun0
udWGq5WCMJHd9LmEzWWxRjY8eUCdXx6zMYmqLK5XoIy+VPY0FrnNa5Oc+XLfp2VD
GuT6R9XVVW9H3qYIDdlH4Quc6VWeKSSaV2Mw8g2R63ZCLoH+o5y1zWOkEdtznr50
7N1YS35HGBL5v2dCO04Ht+RTmr628/3EorA0nhvY7J+Dx0luK0wFvGf6AkEyKhK3
u0Yb4lhAKFuch+zaXYnDF4yO2KHjSY3+QncGz+1E/jMjivBAmO5aDussCIsfYxhj
q5IZCTifxXZlRWplKdo8B+JHYPp7Fm/2PI+/JS/jWKf7fEMdb42qgU85FInayTAM
RA8R9j5ExgGSnwChAs9fKVZ6XDnuW3WKvZTYNpmvNxRxx69EcU7QMcQCuX4cEcul
/VXKAlsYa4fuTG3uoVyMLmVCWEPyFg875r3yPk+EZMy+IR9TRD4iBAe86T7UfXG3
Py8165Cs4rBvfNb2hW7bVX8JIpgeQcEqthOeOtLLCiThrnlgXOW7+W8p456koMu0
ieVIqs+0OphTBz2FWTrBxolfIYEBiO999rFD1jGZeH7qvLnzP+NXqY9USliAcUU0
EYmKyXW32R7MjtyDp11JEPVbIwgw42KkV2SDiwNTvzQrIn6YUAyI5YyWdMiywiWQ
UiV8we7E8e+CwfaipoBW
=qloD
-----END PGP SIGNATURE-----

--uQr8t48UFsdbeI+V--

--===============7189733281273717145==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7189733281273717145==--
