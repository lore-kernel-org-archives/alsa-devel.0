From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/4] ASoc: kirkwood: simplify probe error
Date: Fri, 26 Jul 2013 11:32:50 +0100
Message-ID: <20130726103250.GX9858@sirena.org.uk>
References: <20130725111357.7c976963@armhf>
 <20130725191059.GO9858@sirena.org.uk>
 <20130726082818.480d2a02@armhf>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4671545085583742926=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D2892608DA
 for <alsa-devel@alsa-project.org>; Fri, 26 Jul 2013 12:32:59 +0200 (CEST)
In-Reply-To: <20130726082818.480d2a02@armhf>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Russell King <rmk+kernel@arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org


--===============4671545085583742926==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x9eD2RskteXOQWXz"
Content-Disposition: inline


--x9eD2RskteXOQWXz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 26, 2013 at 08:28:18AM +0200, Jean-Francois Moine wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > This seems fine but doesn't apply against current code but otherwise
> > seems fine.

> My base is 3.11-rc2.

Always submit against where the code will be applied - -next in this
case.

--x9eD2RskteXOQWXz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR8lBPAAoJELSic+t+oim9zmkP/iAVMMZdWXAVm7B+SvNMPfqG
Iwa7wsV6m83cXPzGisvS4rIIL1ygbtZBnfoKYJE8uq+QDgFd/lBGQlGYkBkbWhYt
EqhXkHT47Be9b9CmfOI0tfe29WJbk1goubqz/no5Nb3fpuOBxtmUVdiEo5cHyFcf
Y/1iYIVwafYN5lJLHa5B7C1aOkPDhVN0GkMdWQDBnVnNwA66MXbNjuvz5+BwRoij
c7JpI2PHDtDjYypNu6cRaMBHKo2+BR+dTz4X4bKVXFfuFGCX6YsXk2SiXgAEEzqs
6OBQ+bZ9iDdYFRI1zFwe1SI20Xtofn3vph4SrqQP/FmH1kWCGoNap3pReRQb5/ZT
jo9ryNwORUKY7O3iEp+bcwmqlp+vPsfMXI1v+pF6PCQ6RScrgjNAhZeXOTIX6xiV
TGbYWDtE90THit0nVscvJWhRzOq6T0TszJgZP8oY9bAe2IhptIyJ5aMtgRYlFbZp
ZAlh3YU+tORHiR8wVwsak0ygSQXssb1zVpoqdR64Q7p2OriR35etnbgkE4aMjRdC
5rH0FuSJw+8+hTdPHihWtiScFdpHfKLr4D/LtbeRJ8R4UXXYynvyPjiHpvSfr+ad
x2A0riLmmhfBIH/Fob3kEvCMBLSYqQbvVgg1ApkNfv3erXXykAG59Rw/ci6XYtP/
R6TrfBpPf9PUQjLDIXy7
=X1z7
-----END PGP SIGNATURE-----

--x9eD2RskteXOQWXz--

--===============4671545085583742926==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4671545085583742926==--
