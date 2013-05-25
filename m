From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: Add ssm2518 support
Date: Sat, 25 May 2013 10:34:06 -0400
Message-ID: <20130525143406.GF7660@sirena.org.uk>
References: <1369332891-15164-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4442565407447220474=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id DAA672610C7
 for <alsa-devel@alsa-project.org>; Sat, 25 May 2013 16:34:17 +0200 (CEST)
In-Reply-To: <1369332891-15164-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Grant Likely <grant.likely@linaro.org>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>, devicetree-discuss@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org


--===============4442565407447220474==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yH1ZJFh+qWm+VodA"
Content-Disposition: inline


--yH1ZJFh+qWm+VodA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 23, 2013 at 08:14:50PM +0200, Lars-Peter Clausen wrote:
> This patch adds a ASoC CODEC driver for the SSM2516. The SSM2516 is a stereo
> Class-D audio amplifier with an I2S interface for audio in and a built-in
> dynamic range control processor.

Applied, thanks.  Always generate patches against the tree you're
submitting for - this has context differences with -next.

--yH1ZJFh+qWm+VodA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRoMvbAAoJELSic+t+oim9U0cP/0WE7VLzFDhr6siuoE2VxUMc
L2smhmeKT8SEeOZhAkGPuHNlQtVf33BDjkoUji1qB1QbKps2opQ8OjzmpIVgqLO0
rSpWA3AP6zZnwaAK4MB8hjzLsIEPjYaonUeB2sPt3vud7SFavFYoqY1bD6s7rkAH
3bNljLXsNE11zAcZKEzbVxEtpgOpHKUjwcTjU/5p2VJRMG4JIGzmP5axw5uG0bjX
FyNUJeLOMKpHFT8qJ90cjSDb/nYPfRI7Kn86DFRre/fVogFh1CKeWje4nsANmY5p
6JTGFYxEBIrF1YehysBOXwBqojMYujQI1JrrA5XVzd4Hpjh/PLLXyBMupI1s5Jy5
1xJCbZWpjiEwQQik4hXqEu1yTWLWQw9k6g3rAUOxiuL63tK8Z0icWGACG1mEN3fK
x7gS7d0SX9zdIcha1JfaWogocAZtR3NX19RrMyUiUOYYmf86VnwZWj74Zk52Qq72
y0vTuMWqAc6ejyexSCfCDQ/stNqYYhemlgCt2nVwnqdy9QlT0GSpEAhplM6tX8c6
0DQkxguBqGqecIisbnbddEZLNWTsqtyQWB21fMHXGDic+PEc6le/OyyMxkZhSasA
9hSugKgSn0cVHGY2DAqE/qwcqogudckfBUgJhw7Gf87CKJtYEKWN4BvY7e/fuA4L
6hBlUXHImxjUA4NqHHmC
=Rsu9
-----END PGP SIGNATURE-----

--yH1ZJFh+qWm+VodA--

--===============4442565407447220474==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4442565407447220474==--
