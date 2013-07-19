From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: atmel: add wm8904 based audio
 machine driver
Date: Fri, 19 Jul 2013 11:32:32 +0100
Message-ID: <20130719103232.GH9858@sirena.org.uk>
References: <1374132483-25375-1-git-send-email-voice.shen@atmel.com>
 <20130718111709.GL22506@sirena.org.uk> <51E8A6EF.4040608@atmel.com>
 <51E8D75C.7030707@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2658948105664879116=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 128E426566A
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 12:32:36 +0200 (CEST)
In-Reply-To: <51E8D75C.7030707@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bo Shen <voice.shen@atmel.com>
Cc: nicolas.ferre@atmel.com, alsa-devel@alsa-project.org, plagnioj@jcrosoft.com, linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============2658948105664879116==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqCDj3hiknadvR6t"
Content-Disposition: inline


--AqCDj3hiknadvR6t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 19, 2013 at 02:06:20PM +0800, Bo Shen wrote:
> On 07/19/2013 10:39 AM, Bo Shen wrote:

> >I will try to implement this in next version.

> After check the clock implementation, we are on the way to common
> clock framework, so will do this after we fully transfer to common
> clock.

OK, that makes sense - just leave things as they are for now.

--AqCDj3hiknadvR6t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR6RW8AAoJELSic+t+oim9bC4QAIfXVnIQY77JIC5FcnH8OUUK
a36cY92nKw7e/2pV+utj19DzuqGWU4clJNv9KBIwGwfncPuWvpQEirKabrviWZn0
zqOfmaXShXuWd8259w52BIQ297N4yITABg7FGEwdBMH7zqisqyjvjvCkjYqCwdqm
RgG8J6FZ/kElc2ocI6xayu0GsbOOOuljyIFmS4SDVK/nZBDsjZn4GKFDPkOoVLuJ
8CpxaioX+yLVXXRaa+RcUQIpWoRCjihgpR/QldeAcGPas3oLFirltXZsMleuN2zl
Gtpx5ev2cpNa7Vzkb+wE5iHfEeOZtgzzgCkyngkUYph26Y8L2T7un9dWv5mZmxkU
78WB5pxcGM3OBS+sBsfmp+VWVttqnod4n56K0hMWGH2VEDg6pPZmxz6sAbnXyvL2
yS8eh0bjLAqN+r5nzc5AIPLbMTuXR6eirgNj0CByamVKArsaA/HhFFwf7hItctDG
Md5dY7d/6oaCP4xKwo7AHiOF9PHX/ZQcZxQMlBkLMAYhhVx6QAmFO92kOHK10Vm6
azkLWAdyF9AOJOSOao2JRGdG6xF+9mdWrMP1YmKR2I/jUrKek7ujx4sYmAYEsmx2
5bhOpUfHf37KEqGLxz1qDG7f6wXVqVMIUhdVOZiT/jHDDA5up7y7knyPQrPyHXGA
lKd966oeuBXDs+1VU1aq
=uQPM
-----END PGP SIGNATURE-----

--AqCDj3hiknadvR6t--

--===============2658948105664879116==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2658948105664879116==--
