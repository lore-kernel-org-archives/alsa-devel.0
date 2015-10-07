From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 0/3] ASoC: da7213: Add DT support for
	codec
Date: Wed, 7 Oct 2015 15:10:39 +0100
Message-ID: <20151007141039.GL12635@sirena.org.uk>
References: <cover.1444223905.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5279788564929561623=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 38FD3265E1A
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2015 16:11:53 +0200 (CEST)
In-Reply-To: <cover.1444223905.git.Adam.Thomson.Opensource@diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Support Opensource <support.opensource@diasemi.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>
List-Id: alsa-devel@alsa-project.org


--===============5279788564929561623==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mxgVX529wKDqfd1k"
Content-Disposition: inline


--mxgVX529wKDqfd1k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 07, 2015 at 02:27:04PM +0100, Adam Thomson wrote:

> Adam Thomson (3):
>   ASoC: da7213: Add DT support to codec driver
>   ASoC: da7213: Add support to handle mclk data provided to driver
>   ASoC: da7213: Add bindings documentation for codec driver

Please remember to send the DT binding before the code as is normal,
this helps review the code as we know in advance what the code is
supposed to do.

--mxgVX529wKDqfd1k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWFSfeAAoJECTWi3JdVIfQiQkH/jNUACpDdSlNm2PKEtcbxF7a
cnv3MCJ6+fIP9It28dZnm6nC+1nRkuhNs3k9oRHt4zAo0eWNQSkfXlsR+XSS681Z
HXJf6BYEoNmZ3vW7Jjh2BPzD1RZc0dBXN7dfK01FFDieU2CNvxuinO0/PsyfNxKA
buNLTCKICYqdoo9n81M2afEpYHnYC3MkOXBXNg5jhOb49ehBKuDl6KKN3wfGonYk
klteu+LzUGl9XeOOi57jF+sSwWDYqMt3ajvsI4fIyz9bzUfPllQWO7SY4Y4rBvLS
YIJ5gs6cErCpqjkS9Aic9h02STckFhOaTqUo2ZEFUWqMHPQLZSsVQmckP6FjbY0=
=453t
-----END PGP SIGNATURE-----

--mxgVX529wKDqfd1k--

--===============5279788564929561623==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5279788564929561623==--
