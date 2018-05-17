From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 43/45] sound/soc/zte: remove duplicate
	includes
Date: Thu, 17 May 2018 15:38:06 +0900
Message-ID: <20180517063806.GN20254@sirena.org.uk>
References: <1512930723-5037-1-git-send-email-pravin.shedge4linux@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0697180888584178966=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id CFC8A2671C0
 for <alsa-devel@alsa-project.org>; Thu, 17 May 2018 18:44:54 +0200 (CEST)
In-Reply-To: <1512930723-5037-1-git-send-email-pravin.shedge4linux@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pravin Shedge <pravin.shedge4linux@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, jun.nie@linaro.org, baoyou.xie@linaro.org, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============0697180888584178966==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s8J8qjRpxLkp1Gun"
Content-Disposition: inline


--s8J8qjRpxLkp1Gun
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 11, 2017 at 12:02:03AM +0530, Pravin Shedge wrote:
> These duplicate includes have been found with scripts/checkincludes.pl but
> they have been removed manually to avoid removing false positives.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--s8J8qjRpxLkp1Gun
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlr9I04ACgkQJNaLcl1U
h9ARbwf+P2Oq3YquIZNXfw6884eu6+lDJUqPTUX0v8jSNNaMD65j8Z0dgLZrwSiA
LxlvM6f5Y+Tym+YmVibhKn2PaZ9MQBO90cvsccAiKEYx++L+ngyR9xmVtic4FFHD
XhpEW3/PRKcDn5vRJTm4xbbmdtpsKl1p95oslh9hMqNOXN36ylBwYbinZYNkovPc
ouhNFVlgJ+QY+MA4FVrxUkEfa/iIsi6lDOVha6hzOAy4rzRzWjSl0yqXj0ROKQvn
8m2ZzVZyfDSqnXuI6OuaqdkJJiga5SibKaa+mmR7wjezuc5YkaFXk5GAO48xUQev
9HhucI1oAcImvrDZxwv2XoaR4VLEiw==
=6Dwl
-----END PGP SIGNATURE-----

--s8J8qjRpxLkp1Gun--

--===============0697180888584178966==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0697180888584178966==--
