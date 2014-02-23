From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 058/102] ASoC: wm8993: Use
	SOC_ENUM_SINGLE_DECL()
Date: Sun, 23 Feb 2014 11:42:46 +0900
Message-ID: <20140223024246.GY25940@sirena.org.uk>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
 <1392723517-12772-31-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5495535594884542229=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 59C4B264FF5
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 03:42:58 +0100 (CET)
In-Reply-To: <1392723517-12772-31-git-send-email-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5495535594884542229==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nRkE97iIlkj7lnZ0"
Content-Disposition: inline


--nRkE97iIlkj7lnZ0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:38:14PM +0100, Takashi Iwai wrote:
> Just replace with the helper macro.  No functional change at all.

Applied, thanks.

--nRkE97iIlkj7lnZ0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCWAjAAoJELSic+t+oim9Ia8P/AwTIWh9y2q1Rh4ywKKteP5M
gbpyA0TnXQ2vEp4zT6b/SRr8BMvvBJxA0FjlwtOJwbydxsRtqxLxDhRa7M3SjZOW
9CCd0l5gh+cMYMREBdvuBbubAFxcaw0y7SGYkZxf5EbZcPUquSD7WIrqz1wrg93B
nrukp7D2t2S00/llYmKiizk0PP0xA3JkH769DhZt/h2Y3og1EfrbdJ9qlMxl8/eP
fQnx1O01PShhdFx8664Z+Fne8JwG2ATsbaAE6au1VEFnZDosX7nXEPvDLeDLy88W
HFuOfiZ9uetyO1ecg3EVhkQD8eQlXkuxf3Sxb9/i7E192VhVbEuGW0BA8ZSXlM5g
v3qciaCWsNv/6h9fTRe115K6R0LrhpNc+nYXzXVcRDAY7mR0fD/+5GGIKt7k9jML
FIysw/JY0sX+Tklu55KY/eqirI9hLKfeU32jpX+2zJ5NfSCsz7R5TWqbpRPl55ZF
h1IkgcrtDWvK+pojXhZs8QKx7xRUWYKeqlI0wy+HeRVU5Z4Z2NUrTufIQVGWtC8j
XFb019lIMySQ2Hr4mvt1cKKP+ptqe3afkYdsVD7DVJcsFEPzCQD0RplVFknXyitu
yUn32eIEVSm+882WQF4pcZc39/ceG85+XCrXbiYgvOzR9twjijojzIy0nZ7GhVPV
yujHgfeujOLiH1exhf5w
=3oOI
-----END PGP SIGNATURE-----

--nRkE97iIlkj7lnZ0--

--===============5495535594884542229==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5495535594884542229==--
