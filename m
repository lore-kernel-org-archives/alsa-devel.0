From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/6] ASoC: rt5651: Add IN3 Boost volume
 control
Date: Mon, 30 Jul 2018 09:28:21 +0100
Message-ID: <20180730082821.GA5789@sirena.org.uk>
References: <20180718205542.12364-1-hdegoede@redhat.com>
 <20180718205542.12364-2-hdegoede@redhat.com>
 <20180719150234.GE27938@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D7028430F3@RTITMBSV02.realtek.com.tw>
 <f38e30f0-182b-484e-8de1-a9fd0db4663c@linux.intel.com>
 <ABFD875FF5FB574BA706497D987D48D70284323D@RTITMBSV02.realtek.com.tw>
 <2ea3aaa5-cba7-901b-f0cf-782ce4ebd1c5@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3966090117657169229=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 59E7D267365
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2018 10:28:25 +0200 (CEST)
In-Reply-To: <2ea3aaa5-cba7-901b-f0cf-782ce4ebd1c5@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Carlo Caione <carlo@endlessm.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============3966090117657169229==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 27, 2018 at 02:01:44PM +0200, Hans de Goede wrote:

> > Yes, it should be modified, too.

> Or we just live with the  "Volume" part missing for these 3 and don't
> break users existing setup for no good reason.

You're a few days behind the discussion on the patch series doing
this...

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltezCMACgkQJNaLcl1U
h9DJ1Qf/T59f1AIPfskmQf9EVp9067w1HpfsVCODGBEYIO1nq38YsxyMqjHOMWH+
C9tFdIn9DqGMgYlllMZC9bBcpL7HV1jhQmw9tVTJwBkw9rcfHCu8hGCZhhsAuG8f
KwIdiseN1x8EPGQSVVFz87vH/9+kxiTfb7hPK7FHDOYG3x/94z1VI6BZ2pSd79W1
6ZXeTSR/me9dIlhYYaSylrXj2B/OBWrsHWYJ9CtTG++FBNSSTdlFiosYkpYacjej
OBfvCXlCxoRWZcANoUwgFTmhO8YDFvW10gbO6W7l/Ghd6B6b41BGC+336dxtmgpC
uHrNfFWJjQZbnT4Vef1FW/qPsG0MJQ==
=S5hG
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--

--===============3966090117657169229==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3966090117657169229==--
