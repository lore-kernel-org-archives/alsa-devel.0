From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoc: wm8580: Add the wm8581 codec to
	the driver
Date: Mon, 24 Oct 2016 18:25:29 +0100
Message-ID: <20161024172529.GH17252@sirena.org.uk>
References: <1476815075-12976-1-git-send-email-flatmax@flatmax.org>
 <1476919754-9636-1-git-send-email-flatmax@flatmax.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2203915441448266152=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B058266C86
 for <alsa-devel@alsa-project.org>; Mon, 24 Oct 2016 19:25:36 +0200 (CEST)
In-Reply-To: <1476919754-9636-1-git-send-email-flatmax@flatmax.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Flax <flatmax@flatmax.org>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============2203915441448266152==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1XWsVB21DFCvn2e8"
Content-Disposition: inline


--1XWsVB21DFCvn2e8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 20, 2016 at 10:29:14AM +1100, Matt Flax wrote:
> This patch adds support for the wm8581 codec to the wm8580 driver.
> The wm8581 codec hardware adds a fourth DAC and otherwise is
> compatible with the wm8580 codec.

Also:

Please submit patches using subject lines reflecting the style for the
subsystem.  This makes it easier for people to identify relevant
patches.  Look at what existing commits in the area you're changing are
doing and make sure your subject lines visually resemble what they're
doing.

--1XWsVB21DFCvn2e8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYDkQIAAoJECTWi3JdVIfQIIoH/Rg0QraCcQg5deohZGPQG3ep
FRSeBJUpgxvFVJzng7o+/XUvLMh0lPmDIkTdhrzEBLMsLAgSD7ga/EkOw6/P2ClZ
Sg9VtA36DCn1zNU2pII1PBsw5TxYOh0S82UQvxce1zGHCyreIvn/bZHDdZKgfM/C
fFC+D++zHLLDYkRFzICw7MtF51+9rLT8yGzjRAxJ1wNpAs3WXCaUOqWx6KpAWQX2
YMPyeCISuE2f189/65HsP0GbwaZxFmk/u7suug8XG/pvxR8mzE8coYyw/V1SC3TW
1MfhHVhHsQyD5efe8AGv+eNSykWOFqdXjoeVglmofP/0z3lKZzl6Fz6nF4DHxM4=
=+tJt
-----END PGP SIGNATURE-----

--1XWsVB21DFCvn2e8--

--===============2203915441448266152==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2203915441448266152==--
