From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] ASoC: dapm: Add new widgets to the end
 of the widget list
Date: Wed, 6 May 2015 17:25:09 +0100
Message-ID: <20150506162509.GY22845@sirena.org.uk>
References: <1430496165-13917-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7859402317741864708=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A961A260616
 for <alsa-devel@alsa-project.org>; Wed,  6 May 2015 18:25:18 +0200 (CEST)
In-Reply-To: <1430496165-13917-1-git-send-email-lars@metafoo.de>
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7859402317741864708==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qFD8FSWSlpN2T4cg"
Content-Disposition: inline


--qFD8FSWSlpN2T4cg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 01, 2015 at 06:02:42PM +0200, Lars-Peter Clausen wrote:
> Currently new widgets are appended to the beginning of the cards widget
> list. This has the effect that widgets that are created while iterating

Applied, thanks.

--qFD8FSWSlpN2T4cg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVSkBkAAoJECTWi3JdVIfQyI8H/3cSUpcW9IW8BEh1qFYXrRem
vEiti0F5adMxmOCWRsDoxmDeD9d7xb+ObWH2oG5vSistIDaFWmrt6AhZQp9fmUaA
zmPDokwJ+My6tiHe5OmN6e7Cd87lOCbFpQ3tAa7F8oTwNuh9S4oz7XMNsxA+CV5d
cEzrS1wS3i6Gb027G5Yc6QH3ftYL7cm6wjXmGrWqEVrQN8ybgTiaJ8hQWUPCzv4B
d97D+s+VXanGMEgwMUXJaiJ8YDb208vayw2eBLAmwzEQBZ/sdi2lsesnwmcfUKGT
BAnrKnXhuAwCdeTvoShUnkU/zL8p0AdzM0PS7SqswwBSPfETuGt4o17HMw3SIZg=
=5itH
-----END PGP SIGNATURE-----

--qFD8FSWSlpN2T4cg--

--===============7859402317741864708==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7859402317741864708==--
