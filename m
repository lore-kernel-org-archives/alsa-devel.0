From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: sun4i-i2s: move code from
 startup/shutdown hooks into pm_runtime hooks
Date: Sun, 21 Oct 2018 15:02:26 +0100
Message-ID: <20181021140226.GF8554@sirena.org.uk>
References: <20181016031141.16259-1-anarsoul@gmail.com>
 <6365837.9zzJEACKLf@anarsoul-thinkpad>
 <20181017210159.hni6ozm755orvzzg@flea>
 <1716612.tSkIyEiKY2@anarsoul-thinkpad>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3199502252461991400=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 125AA2677D1
 for <alsa-devel@alsa-project.org>; Sun, 21 Oct 2018 16:02:45 +0200 (CEST)
In-Reply-To: <1716612.tSkIyEiKY2@anarsoul-thinkpad>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Marcus Cooper <codekipper@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Yong Deng <yong.deng@magewell.com>, arm-linux <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============3199502252461991400==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RpqchZ26BWispMcB"
Content-Disposition: inline


--RpqchZ26BWispMcB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 19, 2018 at 09:18:18AM -0700, Vasily Khoruzhick wrote:
> On Wednesday, October 17, 2018 2:01:59 PM PDT Maxime Ripard wrote:
> > On Wed, Oct 17, 2018 at 08:36:26AM -0700, Vasily Khoruzhick wrote:
> > > On Wednesday, October 17, 2018 8:25:23 AM PDT Maxime Ripard wrote:
> > > > On Wed, Oct 17, 2018 at 07:41:55AM -0700, Vasily Khoruzhick wrote:
> > > > > On Wed, Oct 17, 2018 at 12:45 AM Maxime Ripard

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

> Mark, can you pick up this one please? Thanks!

Please resend, I dropped it due to the (initial) negative review
comments.

--RpqchZ26BWispMcB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvMhvEACgkQJNaLcl1U
h9CX6gf+JW8RzD1Oq3ZFjVTqIKjzij7oYUYP9BJ+5n9VxcUhhmpq4Gn8XMN+7Y3R
D/FsXXN0JPciDxxqfr4xvFWbeeCYt9BNPWF5aUVM92P1lA+hSe9WVB5SmFKNT1AU
Lon7FkMV54m51821geu7pBEE7T+Ysr2qe8fsNLFpv7gUlwoVUTttphChOJNrbp3B
4+lDSbqvJyOoVxSUOyYTtVEGw9p1vYLN0J2Bb9WPoAUzJeaxZvNm5fdvD2tycYKG
7kbOKEz49XQktZhhJH621y+Vx71RRufkMRe7SY0czAXbl3oFLVw3tMPlPm+tj09d
FC3xVjLCXRn/expy3bJ503y/xbAM1A==
=zZkK
-----END PGP SIGNATURE-----

--RpqchZ26BWispMcB--

--===============3199502252461991400==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3199502252461991400==--
