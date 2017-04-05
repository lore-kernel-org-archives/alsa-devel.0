From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 07/16] regulator: madera-micsupp: Mic
 supply for Cirrus Logic Madera codecs
Date: Wed, 5 Apr 2017 14:40:54 +0100
Message-ID: <20170405134054.kz3j56vza4pqki75@sirena.org.uk>
References: <1491386884-30689-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1491386884-30689-8-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1243590200263891673=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 42F1D266BA4
 for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2017 15:41:07 +0200 (CEST)
In-Reply-To: <1491386884-30689-8-git-send-email-rf@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: gnurou@gmail.com, alsa-devel@alsa-project.org, jason@lakedaemon.net, devicetree@vger.kernel.org, linus.walleij@linaro.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, robh+dt@kernel.org, tglx@linutronix.de, lee.jones@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============1243590200263891673==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yg7s55w6sf3rsynu"
Content-Disposition: inline


--yg7s55w6sf3rsynu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 05, 2017 at 11:07:55AM +0100, Richard Fitzgerald wrote:
> The adds a driver for the microphone supply regulator on Cirrus Logic
> Madera class codecs.

Again, this appears to have only data and minor code style changes
relative to the existing arizona driver - is there no opportunity for
code sharing here?

--yg7s55w6sf3rsynu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljk8+UACgkQJNaLcl1U
h9DjLQf/V7WQSviOq7Bmu9Ux6URk3qyYGILULku08/0wNCeZIsuhueHgIW3p+JI6
tpSTMtnAbXGHW2NqRvxGS0rDkmOYkfP0oFZE2zBXt3ve8EFVjK4YBVOaOhL1iXYl
bfLCw/hF3Ct6XF1qpW1btD9kBb4TQuDfRXW+ywTk0pbQtHjBlTl7dJVK5o44psYk
/OVRKw8dj67PZkzcx1bdd8zwicu8KQuwYjYk2ku1HX4qDUE0ImuOlg25EJifimAR
TqsxrFR+FRoX9fC/TzJcGrG6DYVLebmnHgvF2v/QM9jWW/0oHRJ2G5+TW3iShUTc
DDO7TlDHKRNzAAFpdwFhUPvlPXT/Mg==
=WT0w
-----END PGP SIGNATURE-----

--yg7s55w6sf3rsynu--

--===============1243590200263891673==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1243590200263891673==--
