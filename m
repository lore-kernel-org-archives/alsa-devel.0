From: Mark Brown <broonie@kernel.org>
Subject: Re: [GIT PULL] ASoC updates for v3.18
Date: Mon, 6 Oct 2014 14:31:05 +0100
Message-ID: <20141006133105.GO4609@sirena.org.uk>
References: <20141006115105.GL4609@sirena.org.uk>
 <s5htx3hxtjy.wl-tiwai@suse.de>
 <20141006130728.GM4609@sirena.org.uk>
 <s5hlhotxry0.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4896806305143433717=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 823012604A9
 for <alsa-devel@alsa-project.org>; Mon,  6 Oct 2014 15:31:19 +0200 (CEST)
In-Reply-To: <s5hlhotxry0.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Sean Cross <xobs@kosagi.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Sachin Kamat <sachin.kamat@samsung.com>
List-Id: alsa-devel@alsa-project.org


--===============4896806305143433717==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hXth9cGL35Nvpk4x"
Content-Disposition: inline


--hXth9cGL35Nvpk4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 06, 2014 at 03:12:39PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > How are you generating these - none of them are showing up in any of the
> > normal -next autobuilds and I don't recall seeing any of them from 0day
> > either?

> Maybe depending on the gcc version?  My cross compiler is a bit old,
> gcc 4.6.3.

That seems odd, I'd expect an old compiler to do worse than a new
version not better...

--hXth9cGL35Nvpk4x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUMpmZAAoJECTWi3JdVIfQsmIH/jEe5E3suC6ITLO9a0idkgwc
8wDivXJqyMfF/VKTkX8vB+ZAsEy7fv1DRgjogqePkxuAGQqIC5nJGrQ3fsxWoE9h
Lxle+J0mVXS5PFdeie+YKz1t6qZh+lSsR72rRkDIFvvgs6w6r0MXpzpy1fBlApuP
QLLsxzYruwm73UDojBmHcuaZEW/a7n4O4IDZwDnlmvQXUfvQr0rXERdRBFzmSjzu
Kvaj8tt0shpZ0vVOG80zC2ALVFdl52PfvFeYlyQZdbdIqsL1BJTFFCszQmeclE41
SmCd+mOoTmrLOItoaHfgyOb58aodaEV11bbxnQvgM1wHouEfbavILmjSARnSG9A=
=HkVF
-----END PGP SIGNATURE-----

--hXth9cGL35Nvpk4x--

--===============4896806305143433717==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4896806305143433717==--
