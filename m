From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: byt-rt5640: Enable headset
	mic bias voltage
Date: Mon, 9 Jun 2014 20:48:31 +0100
Message-ID: <20140609194831.GG5099@sirena.org.uk>
References: <1402313946-12398-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8998458701570836100=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 93AEF2652DA
 for <alsa-devel@alsa-project.org>; Mon,  9 Jun 2014 21:48:46 +0200 (CEST)
In-Reply-To: <1402313946-12398-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8998458701570836100==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IfZ7xA51UQS4uQU3"
Content-Disposition: inline


--IfZ7xA51UQS4uQU3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 09, 2014 at 02:39:06PM +0300, Jarkko Nikula wrote:
> Connect "Headset Mic" to "MICBIAS1" supply widget of RT5640 in order to
> enable bias voltage for headset microphones.

Applied, thanks.

--IfZ7xA51UQS4uQU3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTlg+LAAoJELSic+t+oim959AP/06FpHsunJJK+GUN7sP0pJW2
Jlm53cMBDpWbB4ZyhZy/t+eAbXvzF1C/iaoDWvZ1CXwgJLhzTPjhcxlp61BP95k4
KTgc+RK2uX5mK8gw+6jO7B4AAh4JjqDP8ETlVQrNt34S+zIUNnWQiYzAGl3len+g
mH3KEKw+c5gteEx+1656sJYCba8f2KdMrNwPjFowBaDoADv00v7g6zMNSny5UdvK
wNpxFwnlNYc5fUthEnou78xxbISRJvBF28X/WChCfa8qo4stGFB2YDJzOyYRZgTD
7ROKCtU/r9fRjrjA/m31RMna+7neaJBpM0WDLxweJLmfsFQafd+1GOEm2EsBHav3
024tOGIKhhnoGMsPr/4CgEgvDS5l7C/2v6SwoSN4rErjcDOY/Q5cA6YoM8wKTcnv
jV/uiTevGrsMo9w1zzeuVXEWSo+sUNRRAU9CwNpmTZIzfMUfToTVRZ1AKenykb4s
veP9YBw5+1LvWO1GavgWm6NevH1HqNx/1q3MKebZ2s6weMdUhPKoeYQyZXFBPinL
ukxOkJNebSdwl8o/AJXEeFu6IlBm+0OUKeGW+f9YPoijyAE3gzjocm+gnJkbZRoJ
KqQWW6RE/5F2SXmyyJ2AsQY0FrT804oAgdjWXweT30mlHWRkxjc8Dy58sLhMek+h
ihXkbpQ9Sb+VVsXC8n+T
=QRx2
-----END PGP SIGNATURE-----

--IfZ7xA51UQS4uQU3--

--===============8998458701570836100==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8998458701570836100==--
