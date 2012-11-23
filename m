From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/10] Kirkwood ASoC drivers fixes and
	improvements
Date: Fri, 23 Nov 2012 10:38:28 +0900
Message-ID: <20121123013827.GB4385@opensource.wolfsonmicro.com>
References: <20121120121726.GN3290@n2100.arm.linux.org.uk>
 <20121120122051.GA12063@n2100.arm.linux.org.uk>
 <87ip8xodv1.fsf@lebrac.rtp-net.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8453879260025877227=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BB24326030F
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2012 02:38:31 +0100 (CET)
In-Reply-To: <87ip8xodv1.fsf@lebrac.rtp-net.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Takashi Iwai <tiwai@suse.de>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Rabeeh Khoury <rabeeh@solid-run.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============8453879260025877227==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
Content-Disposition: inline


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 22, 2012 at 04:29:22PM +0100, Arnaud Patard wrote:
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> > Argh.  Just noticed the driver author is _not_ listed in MAINTAINTERS.

> hm. right. sorry. I tend to always forget this. Is this still really
> usefull given that there's get_maintainer.pl ?

Yes, get_maintainer.pl is far too prone to problems like false positives
and other issues when it guesses based on git - real information helps
it a lot.

--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQrtOFAAoJELSic+t+oim9Jj8QAIQs1Gq07tXPIl1UyTP2nQSl
r1V66BkKZQZ7nmV53EGYWBCMwB+PzPtF57IXLnqCzZsnADUtco73uR6ZSMtlVF/c
fOMrYfIWDO1H4FguWJAGgHaB6gCvBKk9xvVAItHTtRYrZSnzL+/89waFvOLtZadk
QOJcJOTqT0SdE5mOI12/83zfGgkZr282kUOyN1hVzpxNfvlljTDsbk4U1QzcLbk/
3IRYq7tLTYZCl86iOePaog4LueuELtEfJ3OSEB+547qb+EcvRIsRuqDKp42izhcB
WeG69aFmUlQzgFiEmjYxH5iupc98gl1UUS0NHZ2g6ZtkeN8R4459UeU78ZBusLAb
WW7nLuvbb/tJWMdOaZ8gvDzvsp80+kFsraBdKdGdw/Wvir/zdWlwqGxTp8rb+aOb
C1MI9o3yLJgGQamj7CTgj8jJiJzCk//mO99rYX3RPsxYGW6wmrOxv2icKpBK+PLK
jD0IEpP7khwwwn/VTFWB0j18sMofclfKEC1CzskMp5AAgD2iA3z1SKTHmC6tfm2f
Gb+Anq+xba1GNVpAVWbFZJI/WiFnnhr4Y8AfaMliEN0fWoODdQjU72HjoFITQiG5
ouFfhn8VspH9c7xfam6rEWgOgQTVdlLKXTOnQuP31b7BaeYUxaRt5IrCQGzCp2r3
v5su4dPH5IW/cXgZV6kD
=tEAn
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--

--===============8453879260025877227==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8453879260025877227==--
