From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RESEND] ASoC: rt5670: Fix the speaker mono
	output issue
Date: Wed, 4 Mar 2015 17:30:33 +0000
Message-ID: <20150304173033.GU21293@sirena.org.uk>
References: <1425378689-21214-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2704657327756435395=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0AEEF265289
 for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2015 18:30:42 +0100 (CET)
In-Reply-To: <1425378689-21214-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, mengdong.lin@intel.com, lgirdwood@gmail.com, john.lin@realtek.com, yao.jin@intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============2704657327756435395==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DXt5MuXPEbodL4kP"
Content-Disposition: inline


--DXt5MuXPEbodL4kP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 03, 2015 at 06:31:29PM +0800, Bard Liao wrote:
> We need to set left/right control for the speaker amp to get stereo
> output on speaker.

Applied, thanks.

--DXt5MuXPEbodL4kP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU90E4AAoJECTWi3JdVIfQ1WEH/1HH7S8CJJEL4QTl5oY8XLJj
xeFDvv8hEULfJVnAd87sJ1cVf8rKMdld5sT2TTdzpB1XBwUaH+53kMVAOPJoxBNV
CxyQ0CCI0unsP92JORkU3UKrVPyOt/WDrZIcW37I8Fr4V7bV1hN0VDn/Y8bCAMOo
YuJKNvkB675GMa6ORHm1xwoEcEWsUOpaAqfeEJwpzogpp9B59RXHNdcN8weP5qgY
3glB3Qc9z4v/yNTuuYNK6jrc/BkukYJLup8/dt8as8WxYurWsTeR9xj7KYzUSMKp
hgZZA5jHfTmaTff+7oAYlriZ5p7P95iFr9XqdATIwxml2dB2ZJw4N5lBDcrqNoI=
=xx0B
-----END PGP SIGNATURE-----

--DXt5MuXPEbodL4kP--

--===============2704657327756435395==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2704657327756435395==--
