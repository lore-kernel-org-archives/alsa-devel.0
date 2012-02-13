From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC update for 3.3
Date: Mon, 13 Feb 2012 15:15:52 -0800
Message-ID: <20120213231550.GC11931@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4854305725596415791=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5B8E624332
	for <alsa-devel@alsa-project.org>; Tue, 14 Feb 2012 00:15:57 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============4854305725596415791==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0vzXIDBeUiKkjNJl"
Content-Disposition: inline


--0vzXIDBeUiKkjNJl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit a7c4183be2d6a7da8c97a9b671b5f3aed321127e:

  ASoC: wm8994: Disable line output discharge prior to ramping VMID (2012-02-08 19:52:00 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git asoc-3.3

for you to fetch changes up to 1987877d869027ab63dc9df515e11f19279a8091:

  ASoC: fsi: fixup fsi_pointer() calculation method (2012-02-09 10:50:53 +0000)

----------------------------------------------------------------
A simple fix from Morimoto-san for the pointer() operation in the FSI
driver.
----------------------------------------------------------------

Kuninori Morimoto (1):
      ASoC: fsi: fixup fsi_pointer() calculation method

 sound/soc/sh/fsi.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

--0vzXIDBeUiKkjNJl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPOZmgAAoJEBus8iNuMP3ddI8P/jVc3pZz2pybIUXEgCM/woh8
azfgCG0fanHC88PBys5j0fP+LGxADjxdg1+Ym5iknt6asXhTmiiEAT/2hyp944Rq
K06CiR4Yf44KkmRrqvxioPwzb4+qQjEJmMT3m2eJcFS16RMcbGdW1+IuKmmoPWie
0Ui1nhzO2gteovMbVUPSdx4BxlSsJlXhEhM6AhNfWlPJx0eTZyXzAvDMtz9d9Y35
xlcpFQflViSADe/i0RwN2jhgz5GIQchvNt2pB+odcATXlHPgXkGGWBiBHI9ksKjq
7d9EBPqgQasKb7yIn0UWnwJxwOvOp96ENAXGIAtTlPRk8A+bnppTCWWSlxFpVmZb
SOYIrLRvHh2rU23iTLvNiqk77wP9FlWQS0he4uq4o6UoCUprfzxbr8Xb7YCMvzOd
9okrD4XljQMq8pseWMHKZQgADVyPOW1IuJ2ffM3eEWNgGpQ1KRG1UNN72I5COiWD
dakQ9eqbKTPNgtDOq/mZZm+RQaq8jxxZU6lQomGS7kqbpCjUg6mWcSrsvdBwvWFn
u3+AdzEEGx7g9tzT8VUKXy7VM4+OApeSfPSF/LbN3e9gVGUmbTKWD+n4Dr3MlyYW
KXZYg+vRFmPolB+1askbph8v8oDzEunT45eRC89hT2UbNufj1xIxOlbzjMIzLqTY
jTntO1FGRVSGtvXUCVEV
=gidT
-----END PGP SIGNATURE-----

--0vzXIDBeUiKkjNJl--

--===============4854305725596415791==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4854305725596415791==--
