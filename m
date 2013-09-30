From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: pcm: Remove extra spaces from dev_
	prints
Date: Mon, 30 Sep 2013 18:06:48 +0100
Message-ID: <20130930170648.GE19304@sirena.org.uk>
References: <1380550095-21080-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5924949414332383034=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 11C93261AB3
 for <alsa-devel@alsa-project.org>; Mon, 30 Sep 2013 19:06:51 +0200 (CEST)
In-Reply-To: <1380550095-21080-1-git-send-email-jarkko.nikula@linux.intel.com>
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


--===============5924949414332383034==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+zeCMqFCsETNqUaq"
Content-Disposition: inline


--+zeCMqFCsETNqUaq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 30, 2013 at 05:08:15PM +0300, Jarkko Nikula wrote:
> dev_ prints are already prefixed by ": " before format string so there is no
> need for extra spaces.

Applied, thanks.

--+zeCMqFCsETNqUaq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSSa+kAAoJELSic+t+oim9AzkP/jdRT974J+eiRPvnIUqMrL3y
s8ROyv01gC8eb68ZFxSQ916p6Sv1V0IbB3QxjP9i9tPiuzyVJ830qXhQRMHyoSxU
2+6zh5b7X7jZmU9O7oYdxYCL0GUAkNdBB/xRkUWfjaNHOEve3IEepvQEYdNLG0ik
Cr0eRrVf275f5zvpMKjDao3u+2JeTlTo126mPNOQibpqGg+k8nAdPhKFgCMh3Ryq
xhcqSH59mYanKdtJM8nUNTsi0IcxysKjL1sQtYwsuPfFh9PFJdYPKgV5hk2IxzHB
ZhC+B9MdbsFcB5lxkukdc23xSFzOEKF/qz6e/SKidp5+ru3I3ZgDPrZX1qGhq4+7
V4QKnmLy9lDRBE6eB5vQtZErUAYtPcnx/R2VMS8ylGEipSJFpeqkR9NqCIrwXIej
zcGsLZfIPO/Ox57QalWBQkDuynSOUC35HF7NhrshlWik7uUtNgaLi0v86eIQp8hq
mv1JVVmcWWq5W2EU6ggPHyMoKI5LtWzxUXHw6Ai8c1EcHye1KwhnTt2nxB8jlJJo
bTwHxpNraYtwnJyBIk7Gr7xg8U9Ea8YUlibfIlpGDNs+Xo27Q9w3qhUvAzw26Dug
DFZXa9DdaXvXsrYn4eCeSf0DW235sC9s5VlRAkt/ibTkJMu+TeSA+5iDB6hBCbk5
YKuAXfeXsfSSAbLSNZso
=JJZb
-----END PGP SIGNATURE-----

--+zeCMqFCsETNqUaq--

--===============5924949414332383034==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5924949414332383034==--
