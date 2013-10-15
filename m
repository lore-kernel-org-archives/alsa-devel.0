From: Mark Brown <broonie@kernel.org>
Subject: Re: Audio Miniconference 2013 schedule II - Edinburgh
	21st October
Date: Tue, 15 Oct 2013 20:26:36 +0100
Message-ID: <20131015192636.GW2443@sirena.org.uk>
References: <20131014161003.GC2443@sirena.org.uk>
 <20131015164408.GQ2954@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5754626228774106207=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 00FA8261A27
 for <alsa-devel@alsa-project.org>; Tue, 15 Oct 2013 21:26:41 +0200 (CEST)
In-Reply-To: <20131015164408.GQ2954@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Colin Guthrie <colin@guthr.ie>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Arun Raghavan <arun.raghavan@collabora.co.uk>, Liam Girdwood <liam.r.girdwood@intel.com>, Tanu Kaskinen <tanuk@iki.fi>, David Henningsson <david.henningsson@canonical.com>, "Bossart,
 Pierre-louis" <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============5754626228774106207==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O6md6STqe0byfsXt"
Content-Disposition: inline


--O6md6STqe0byfsXt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 15, 2013 at 10:14:08PM +0530, Vinod Koul wrote:

> I want to bring the attention to DAPM framework bugs. Somehow recently I
> stumbled on quite a few occasions of DAPM bugs and the best part was that the
> fix was already availble upstream, ported to stable later version than I had or
> NOT ported. Mark, can you pls help by ensuring the right fixes are marked to
> stable so that users dont get hit by it!

Any specifics?  I'm generally very conservative about DAPM changes in
stable because I don't want to break systems that are currently working
by luck - giving people a reason to worry about stable updates isn't
good.

There's also sometimes some dependencies with development work which
doesn't help.

--O6md6STqe0byfsXt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSXZbpAAoJELSic+t+oim9V98P/3fvOGHLIK4TVOM2PYP6PipI
ZR7+3qAdZRiDG7y11QKGvMz1tToW7rQP2MXmH6K+FYqXRxloIaZ7SVqyqLMOxZvX
uILnSvUBK414pz6yj+3qHrwnO/HTBmTRuDvMO7OapzFomHmO5+6Fpk0JuGlbPSTq
dEdlwYkSTjhyLDSkp2ixFNJ0whhbHmV6oh0rj5arZFKg/ZGWUAuLplUZaY+PUggS
i5rKnmbTRh11HMA/cv4KajdJ7ffMCR7PD/0Mev0ZxHYANQ67M5Bk7iQKwWkDoWWg
klvraOG9mlF73jo4VGJ/iiZFnjPBviSHMOobzPSS/Br7WxKuWRKuwkyE/eW0DBS+
R8CJa6Ikkb94TjJEC1m99BoZOu/71sJAjzIK+u9T1yXBMHBUgfx5kiRrQgIQHyPq
oB0S8mkOBDGpZR8MPQ4zIHEesBRqACxoWf4An/Avl8gyTNAFfYW8IP/51HVubM6j
D9lnvLWbfZasaC0/8P4aWJ7Dg4LVfyA1a4TKO8RU7xezEs+HPAEvVSMDfnDrF9a+
W9YvMwEcwQqRLgP6jj5UeL7Y++eNAZsJLXwVclvLjfv3Z9Kb2QQPPdIRc/SpMW0P
wp+sGvLYGoJ1H/qlyWMXbJ7AJxIu7vWXd5l3Md3V2CMAUv8PwH8jozMwPrho0Pk6
ivfHKYgex6pavZyHmhwY
=wQbO
-----END PGP SIGNATURE-----

--O6md6STqe0byfsXt--

--===============5754626228774106207==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5754626228774106207==--
