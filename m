From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/7] Audio support for Armada 370 DB
Date: Mon, 10 Feb 2014 14:57:29 +0000
Message-ID: <20140210145729.GP1757@sirena.org.uk>
References: <1391102051-5319-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140210152141.1391fb67@skate>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0890286237924221620=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 38C4A261A98
 for <alsa-devel@alsa-project.org>; Mon, 10 Feb 2014 15:57:49 +0100 (CET)
In-Reply-To: <20140210152141.1391fb67@skate>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Liam Girdwood <lgirdwood@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0890286237924221620==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BfIB/hDtUWEgpOfz"
Content-Disposition: inline


--BfIB/hDtUWEgpOfz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 10, 2014 at 03:21:41PM +0100, Thomas Petazzoni wrote:

> Any comments on the patch series? I'd like these to be included in
> 3.15, and so far I've only received one simple comment from Jason
> Cooper regarding the defconfig changes, but no other comments.

Don't send contentless pings, they're more noise in the inbox.  In this
case the fact that you didn't use subject lines matching the subsystem
means that they tend to get pushed down my list (or more exactly don't
come up when I search for patches for the subsystems I maintain).  If
your subject lines stand out in git shortlog output for the area you're
working on that's generally an issue, for example with ASoC you're
looking for an "ASoC: ".

--BfIB/hDtUWEgpOfz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS+OjWAAoJELSic+t+oim9BxkP/18Xrm7EmgUnBqxpSpDyR1uK
cyOhh3emKYXmEKubLj6XPTG+WC1APq6IkICEbT2kglgMUN9v/2T4T4P+RV92bMxz
PXyySPkIxB24MPBIli/tHj54QNgMMrhppMNCBXJQQ8zkErqsSufLiteYYcXRMsvY
mYvG4YOaC+Q3OUIBFn054pTfkg2d/jCciaEQpbPxut8a8bfahDTM/ipcA1aMkPgc
VGlzRO4/1F7AQQTdVchhNZkMqAr3AmVaYrjz3xLp4TiUnUy2lgkQLYc0H5Ao/Kvx
B7aP5CkXd+eKVCnzAFrjeFSMAstJShFXGIpRnNDKPQ23HKlI/UhFhfv9TJd6duxL
f7mu3jLYtr0A3FBufjjY2KiWYRTk37H2Q2GaUiyQeAci0B5rK8fpdFkX5uOpaO40
MF7D1DHD6MZtJq1KKLj95Un821mSuz854saN3dxaLDeJygKcQOD13z6gyNp8k707
2lFcxESwrUWKMrzkFZSLhR9skxKi2LEcIJdRdMbe8S9PAjAdpL3X6RWcgVIlNsCc
Bt9oXVREC6eh8lSgsRXO+wSVmZu0cMKRE9l6V3owx0Kks98Xa1PCMq91yDHmE/rY
YsShaw27ChDtvJJPAWbx4RG/M+1i37jWmK2ReDsqqmfzB/nlk9BxsMyXRkMD9niW
i5rp218BZ0Wt0ydPiluA
=ol+k
-----END PGP SIGNATURE-----

--BfIB/hDtUWEgpOfz--

--===============0890286237924221620==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0890286237924221620==--
