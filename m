From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Atmel: ClassD: add GCK's parent
	clock in DT binding
Date: Thu, 26 Nov 2015 01:06:41 +0000
Message-ID: <20151126010641.GY1929@sirena.org.uk>
References: <1448270399-28728-1-git-send-email-songjun.wu@atmel.com>
 <20151125234524.GA16553@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2083809360520250719=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 066392665A0
 for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2015 02:06:53 +0100 (CET)
In-Reply-To: <20151125234524.GA16553@rob-hp-laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-kernel@vger.kernel.org, Songjun Wu <songjun.wu@atmel.com>, Kumar Gala <galak@codeaurora.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============2083809360520250719==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VIFPKPeEU/ajvd6j"
Content-Disposition: inline


--VIFPKPeEU/ajvd6j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 25, 2015 at 05:45:24PM -0600, Rob Herring wrote:
> On Mon, Nov 23, 2015 at 05:19:58PM +0800, Songjun Wu wrote:
> > Set GCK's parent as audio clock.

> > Signed-off-by: Songjun Wu <songjun.wu@atmel.com>

> Applied, thanks.

I already applied this to the ASoC tree.

--VIFPKPeEU/ajvd6j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWVlsgAAoJECTWi3JdVIfQ7HMH/347uWTYpkv0deCfduGCPymK
iK3mEDHgy3oE0fXTPWJs3UOubeL3qUDLaZxu6rKkOUi9T0bkjR064Mzi8cpuNKPQ
aNVnfSUvk0vVpH218PaxIeO8SzcwFTSYR5CwjFaskv9xHZsEzd8UfKEvhWNYR7l6
xx756CAdWlSHTFhHjl3THFAOOHA+m4bLxDaAkK6stkJi0GKT2ZWv07UaL1akp9wF
xrj+hii8SVgjqTJBmOGR8XTYGorQCi5p+zFTLVJahoITV8ielMGM8+mxbPaXglSj
6KYNnAowbySInJpGxFJ46M2cEv1X710cyk5FZRmUR+ZTeLWtjsW/T7cWOLneb2Y=
=AqsY
-----END PGP SIGNATURE-----

--VIFPKPeEU/ajvd6j--

--===============2083809360520250719==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2083809360520250719==--
