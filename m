From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RESEND v2 1/4] ASoC: cs42l52: Add platform
 data for reset gpio
Date: Fri, 25 Oct 2013 16:42:48 +0100
Message-ID: <20131025154248.GB26122@sirena.org.uk>
References: <1382713277-10306-1-git-send-email-brian.austin@cirrus.com>
 <1382713277-10306-2-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7061408097798673723=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id AB11F26566D
 for <alsa-devel@alsa-project.org>; Fri, 25 Oct 2013 17:42:52 +0200 (CEST)
In-Reply-To: <1382713277-10306-2-git-send-email-brian.austin@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7061408097798673723==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
Content-Disposition: inline


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 25, 2013 at 10:01:14AM -0500, Brian Austin wrote:
> This patch adds platform data support for a reset GPIO.
> Also uses reset_gpio to toggle reset of the CODEC

Applied, thanks,

--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSapF1AAoJELSic+t+oim9w4oP/RocZ3QZZXGw/25I/3Fjff1L
xnBeATOMPhinAxYDWtDiqKfh+RP5Z5c82ndgNCSpltTo/M08PLYRmLoRxkok7x/h
vPafJzBu2Ecr2X6VWvtUyYm4LwEOClT3f2j0OeyrkuqbDAnVMFqmoJSvuE08L0bl
IaEYqdKV/i0p8/HSKh3LmrLSvyKAmpzJIftLDzei+1wIXrhjdqFDHcX4Gvx+CdXE
SbPwkaz9463R0w93kz3CJu29I/9/pXJOPMA4R/P/Xbry/SFuh7TKh/LAMRMCA4Ig
yhLJZTBjPJfErlrXilDhthp3jDxZuawH2i/o1BoL/riwTVEk9bZpn+b7OpOvKvd0
WsqOb0aCGflB6Vcxh0ihF7jX7HWRsN90uSfK1Lroy8xMtRdnIxqnFIxDyty0UZsH
2slm3EwyC9nNZoEhN4N7xUrDYJGPC2SzAjfivLdN26I5yg+rO2MV1PsP1TkjvAUP
MwezUDFnQMdUTRbAJPSlgK8Gb7IbqOYS7g3lNZ8EBSxthKK1UroEhYcxJe0qNc/j
2QZuyBOB9hxrRzDAjyW38tgL0VeDUFXhgIayuTuVMPW3w996Y2N/By/ypkhvA/9U
pAsHtnqHHTTeIwxC2625GtxLBpehDKUUZBxMlAIGZhQBfHX1OcyAHCKTpwKz/hFz
pC2IS2BOTXIrHXP08V/j
=FQ/D
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--

--===============7061408097798673723==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7061408097798673723==--
