From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 019/102] ASoC: arizona: Fix wrong number of
 items in enum ctls
Date: Thu, 20 Feb 2014 10:58:46 +0900
Message-ID: <20140220015846.GF2669@sirena.org.uk>
References: <1392723422-12689-1-git-send-email-tiwai@suse.de>
 <1392723422-12689-4-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1172274740842273678=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 47044265610
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 02:59:00 +0100 (CET)
In-Reply-To: <1392723422-12689-4-git-send-email-tiwai@suse.de>
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


--===============1172274740842273678==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LVT3h14SJbKOvfXi"
Content-Disposition: inline


--LVT3h14SJbKOvfXi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:36:54PM +0100, Takashi Iwai wrote:
> arizona codec driver has a few places wrongly defining the number of
> enum items.

Applied, thanks.

--LVT3h14SJbKOvfXi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBWFTAAoJELSic+t+oim9eX4P/R0JmT33+AZkaoDpeeKW9oCc
Jho5oxRj8lWZwVkw2UGpdNA5h55FRs4ZP+lXxjIw12UWCmvcrSAsLfbWINXAPOIu
pPxvy5l3P8lVItxzpDq78fK/hJ7hFGuid3RiWhxqE389f9gG57qjqh8o1xT7rUik
vAhRbIkbR4my/ZzbZO6nVfLZtUsaeB3qVgGgdxDYqQO3WoubUGmMosGVi4zFj25Z
DL8xzf209C+OIoM59Vg8ufxzLZZrMbVn7lg98zYfEsDU0MyfDepo78tbX2QeNhwz
usNqzYPek6s6952qCDjUgAXofFGR12UIx4QFp9Of1tzX0A0dvPvUVBzb4a/yO1aZ
qNtMSFBT/casAwtWtl6gVTbNR89UdQo66qHkEW/ZCk+jn6OePUOAU/sgI5ERZ1yW
Y1ebKJW/Dgk33OreCj00Cx95L41d1kzrpNEDyqAS24MCzxhOOZXffBARhzx6eYZb
+Ael30phO7wc1xE0WG0oh0unLPhqm6hTrckXbvaDTcXOL8TbMMYaTn+26pUn9oit
IjZT0HyoBXUR1bwy/QsXhEQx+og3arZDFgKn1hpW3X38zPEU5NsvWnRgp8b9tgDm
e6Y8dAfct0ep05SB9ikimiWZq0RbRbj2KtUjP8lmAvCK/jlHn5A5LbdkjztPkz/0
tefwtvTue3BvfNRsRtEl
=B36p
-----END PGP SIGNATURE-----

--LVT3h14SJbKOvfXi--

--===============1172274740842273678==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1172274740842273678==--
