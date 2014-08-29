From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: omap-twl4030: Fix typo in 2nd dai
 link's platform_name
Date: Fri, 29 Aug 2014 11:55:41 +0100
Message-ID: <20140829105541.GL29327@sirena.org.uk>
References: <1409308223-14281-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5830039128083813475=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D7A0826565E
 for <alsa-devel@alsa-project.org>; Fri, 29 Aug 2014 12:55:58 +0200 (CEST)
In-Reply-To: <1409308223-14281-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5830039128083813475==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oOpJzULQ70+PGW7h"
Content-Disposition: inline


--oOpJzULQ70+PGW7h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 29, 2014 at 01:30:23PM +0300, Peter Ujfalusi wrote:
> The platform_name should be omap-mcasp3 for the 2nd link which is used for
> voice connection.

Applied, thanks.

--oOpJzULQ70+PGW7h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUAFwpAAoJELSic+t+oim9pGYQAIY7iMSkNgL/uQuQ3Lh/IJw/
FDDZWDwuNxpJNZZeFKLoVg3aFkyASP0/LZ/eCnUuWB0ha+kxHLNKy/DICgl8kuDh
vDdRa0fdyQ9G+Iyi+7wwcB4sS0/6vrEeQaMpzEM7CwCWdpVlIIW4oYpiNnYRjoFE
agaxmWC8q+tgRnNDgt5kYcK/x348DeFEbQUY+oMvrVvFnk8uWFlE/J3x6q9eC++u
eNjQQg+hF66Q0fOud551cUu9EuSH7AiNWnoIjFSOiIWajWQsS4NZgJjTn6SPDjFb
f0IvLcggKMNWwd3wLa0CfAX4AQEYDG2mqZ9YRqr40dytEjcF7w9DfdhQPeZBzTrs
FIm+fQRk0Lrx5m9DXpiiRTWzw0sdDwbWZ6PBGibKQSgJv6YubscpsFGixnTr+VjE
zGgwC5kOpyboevnSRmxvjRGpXeSIxQNBNNUg4Fz9gDkm7otJnaqGxy4/jNvDqkAf
NfYg0kfcbea0VvYx7fDBE1zK/QYwnSkjNTLx0/PbDFtQKFnvJZKldZ/LJh1gSEVQ
pcwePGH+lT4jSlMo3a4M42NGtxg78DsjvHw6vNu2by5sSjWwBcs4ni2ORpctyHJc
3C2Srujy23oSXZSBn79lnTW8lVWX42A0Q5pRdVWA90CNDnA8is+AyFwHLJwC8hdN
MtIw/dT5wIP91hpOvx2T
=hMfW
-----END PGP SIGNATURE-----

--oOpJzULQ70+PGW7h--

--===============5830039128083813475==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5830039128083813475==--
