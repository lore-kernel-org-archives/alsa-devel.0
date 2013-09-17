From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/1] ASoC: fsl_ssi: Remove redundant
	dev_set_drvdata
Date: Tue, 17 Sep 2013 13:36:27 +0100
Message-ID: <20130917123627.GB21013@sirena.org.uk>
References: <1379068165-8397-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0001992705336886688=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id E1E4C2651AD
 for <alsa-devel@alsa-project.org>; Tue, 17 Sep 2013 14:36:29 +0200 (CEST)
In-Reply-To: <1379068165-8397-1-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: alsa-devel@alsa-project.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org


--===============0001992705336886688==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hqsgWuDCGoNNiKsj"
Content-Disposition: inline


--hqsgWuDCGoNNiKsj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 13, 2013 at 03:59:25PM +0530, Sachin Kamat wrote:
> Driver core sets the driver data to NULL on detach.

Applied, thanks.

--hqsgWuDCGoNNiKsj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSOEzIAAoJELSic+t+oim9yd4P/RWI9pGyx3Y4OTIjdFOQlz52
7cdH5syNBDXyzMzRyX+1yUW6rdF3pCbWr5LICoCjNc2JAEwqpHDw9NANu0i4fCU3
OgzuWVUTx1TOeTgFI475f0VsVBQbBedLXVDB1gkXWibelc/IiAnoQgAw/cRbZ2Jw
K7EyV9rdEq3vaCF0QxXckeqpBJOalK4egB5mDihIl4ITEABlQ0MA2YTkq2S1wszc
xZX5tWDXgBSpKibeNtHoilQ9givuyFjumU5d335aJEV9IVUz5A2HqVb5mp0AJWTc
FxBjgCcO98Oz3QzoS8XrDI+7IKHqxz+Q1QBFoDe2wf/LrovPb+lVAoQheMdUkNVz
XiLg8VgJKJIuRkvjt910t2zkJfOkeA+KCpOxspxv9txAmbpe4G0gniS+xojRUm/g
eH/3WqIMDZIMGzExZedG9t63K7TDWd1t/mTS7T+7JJnOl9zUObAzkmsg246L84Zp
6ZcYNxcAZTW6czULW5cj3rAx+JiJh6ZzjLftQPFxFFvBNuYLJgPnekuZi5clkiC+
yRT036eIff7iuAYwOUNvStoiHkrhYEDxKkzAEv9LCVePY00IUaJJGngR0cbPYl2q
CCgefPyT4/+f/fsQQh17584mNDgm/ozyPlLRPNf6zgneuTDBQ3KgKyEG7EqpjUeD
moVorkgkG8ZNfiHKP3Os
=LxaW
-----END PGP SIGNATURE-----

--hqsgWuDCGoNNiKsj--

--===============0001992705336886688==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0001992705336886688==--
