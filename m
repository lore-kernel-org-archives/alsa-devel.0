From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: Intel: rt5645_set_jack_detect is
	changed
Date: Mon, 20 Apr 2015 21:57:04 +0100
Message-ID: <20150420205704.GM14892@sirena.org.uk>
References: <1429497442-13021-1-git-send-email-bardliao@realtek.com>
 <1429497442-13021-2-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2084072776243501921=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 19BD5265B6D
 for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2015 22:57:12 +0200 (CEST)
In-Reply-To: <1429497442-13021-2-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, zhengxing@rock-chips.com, yang.a.fang@intel.com, lgirdwood@gmail.com, john.lin@realtek.com, koro.chen@mediatek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============2084072776243501921==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="z9sQuz+HmDh2hVO4"
Content-Disposition: inline


--z9sQuz+HmDh2hVO4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 20, 2015 at 10:37:22AM +0800, Bard Liao wrote:
> rt5645_set_jack_detect is changed, so we need to modify the code
> which is using rt5645_set_jack_detect.

This is all good, but it should have been part of patch 1 - if resending
then please squash it in.

--z9sQuz+HmDh2hVO4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVNWgfAAoJECTWi3JdVIfQlvQH/1m39tCgZ0NUyY79DokITdcU
smYCJu2fMThXpY7p4njbV96aCBG7np7y8TljUxUR+Os7w5D7gf/VlPI+XPvOlbDP
zaaQCdoGcKIY6JhZH1XpQxhTPIfA6vim2dcrEs9KbUTPqyjBdjinA8dx529Y0zcA
QjrM0IN7xaDn4/RDyvjP8JNDCTYVsXE00+zc00FRwRKf9xrl7UmbFUwPTUkMNKn2
AMBJda9LTmt/1jhbfoU8OasfCEC/7eLnrs20IRCAA8NR/0C0kJG5hX6V1Nt7oh/6
jhxIxLlcbKfv4pAlb7SB4B51LGAl6bIVp9xdp/kc1IQPFMbfSciqkuhgPcTM5cY=
=j3Au
-----END PGP SIGNATURE-----

--z9sQuz+HmDh2hVO4--

--===============2084072776243501921==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2084072776243501921==--
