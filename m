From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/6] ASoC: max9867: Drop probe function
Date: Thu, 1 Mar 2018 20:39:03 +0000
Message-ID: <20180301203903.GO12864@sirena.org.uk>
References: <20180301141843.GB30722@lenoch> <20180301142027.GE30722@lenoch>
 <20180301175654.GF12864@sirena.org.uk>
 <20180301200618.GB2304@lenoch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3903644256915077036=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BBE51267C1B
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 21:39:04 +0100 (CET)
In-Reply-To: <20180301200618.GB2304@lenoch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: alsa-devel@alsa-project.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: alsa-devel@alsa-project.org


--===============3903644256915077036==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f9b3biUB1f7FHqGn"
Content-Disposition: inline


--f9b3biUB1f7FHqGn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 01, 2018 at 09:06:18PM +0100, Ladislav Michl wrote:
> On Thu, Mar 01, 2018 at 05:56:54PM +0000, Mark Brown wrote:

> > This doesn't apply against current code, please check and resend.

> It was generated and tested against next-20180301. Which version do
> you want me to generate against? Based on 4.16-rc1 it'll fail to
> merge later.

That is my current tree but I don't have a topic for this device other
than your patches...  please resend and I'll take a look what git didn't
like.

--f9b3biUB1f7FHqGn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqYZOYACgkQJNaLcl1U
h9Ck0wf9G2jFKqcgXD0YDt6FQAGOzzOFFIl1wudCfsk7XED/LDg9dPUjY5nHTysQ
viYXQebQWeVpXurU3J/CLmBjyy4BUCefaE+hncOiA0KRReeQYzVRXaaFy+o5PYrk
7zjAy4AuZWN/OeqjWDaZiQKs8Rnug5BP/s/QxKP95Lp+/IglT5KzszyuKZfsl/HZ
N+/qwM4vId7u8IMXKHgoC11h4lPdbr51KtpLWNi+1K4uHQVKC78ESj4blOVjE08+
66f/4Qxrdh98YIooDKaKqjPAPH7HfSXsjsYB7JzrKXDRRrmBH7x3HWri58acPNFk
XK7rRe4AsRACQ824sdAMbh9FHCC9TA==
=Y8Ko
-----END PGP SIGNATURE-----

--f9b3biUB1f7FHqGn--

--===============3903644256915077036==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3903644256915077036==--
