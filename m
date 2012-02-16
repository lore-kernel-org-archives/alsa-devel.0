From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: spitz - Fix kcontrols to use card
	instead of codec.
Date: Thu, 16 Feb 2012 08:27:32 -0800
Message-ID: <20120216162731.GC3383@opensource.wolfsonmicro.com>
References: <1329393623-28816-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1101602722583272979=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 257711039DE
	for <alsa-devel@alsa-project.org>; Thu, 16 Feb 2012 17:27:37 +0100 (CET)
In-Reply-To: <1329393623-28816-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1101602722583272979==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GPJrCs/72TxItFYR"
Content-Disposition: inline


--GPJrCs/72TxItFYR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 16, 2012 at 12:00:23PM +0000, Liam Girdwood wrote:
> Machine kcontrols now use card instead of codec for thier "chip".

Applied, thanks.

--GPJrCs/72TxItFYR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPPS5tAAoJEBus8iNuMP3dhB4P/0eJiaJvIDfUZ6jshiIRa1kF
Ljedzr6QckZAoAbqYJWVGQwRFFd2Ot2l6wB8Zfv7my5Xtn42SIaUOjUjQYRQMmtE
sNlpwJJru3IelCV5eFd+GL0NxuibDYXD4EF8QecQf9YqWo5LPplXVUC5qM0V0ie6
c3t3T6YaFsWV4oJyJPMwxXFKXY4R+BcZLd3+bEqFnTibdGxIbtm0lhBgcWPyeVdT
q/vcybxOLr418NP7zRzIfvZHOvu65+O9m14U7BHSJikj3UJ/DsUjdSOpwdzyaIF7
qP04+RA1Wn7ymzhxKWz6Y0muh597SsXZ/5Ethv562u5qtZLdXtfKcQyjl287PKoJ
l/5QbOk10GeqsnMB3ivc4/QFEBFhUNeEnyOEGNJ97R8/kY7ZtamqI1vhuoFXbmEG
K7P3hXINDyrKywxAPF8oxw5G4lt3tJS/S0VZS3WonUjEd2Pmu2zINGC3nFq1WegD
nzW/7QbYi9BJ5sfaV8f/BMwRFF43yarqvQ4kgrLhvtNvSZe7WC/eif2bUz2c1ikh
yAg80QU9qOxTW1Y5cPAy0bZa4DhSshvRTMoVaIyq//LE6T0IjNZh+xFXLLf199zd
JD7fGCgMEKSr04wpJLrU/X1sKTcHytucvwX0F94mnDIYNQVWhSlRJ1eqUfqBG7dp
6KJv64Jv/zkiVsbjmPJ0
=HiP6
-----END PGP SIGNATURE-----

--GPJrCs/72TxItFYR--

--===============1101602722583272979==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1101602722583272979==--
