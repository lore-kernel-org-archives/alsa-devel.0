From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] sound/soc/fsl: remove leftover
	release_mem_region
Date: Wed, 22 May 2013 11:40:38 -0500
Message-ID: <20130522164038.GR1627@sirena.org.uk>
References: <1369228886-3527-1-git-send-email-wsa@the-dreams.de>
 <1369228886-3527-3-git-send-email-wsa@the-dreams.de>
 <20130522155628.GK1627@sirena.org.uk>
 <20130522160357.GA2917@katana>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8275226452580626035=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 74E792608B7
 for <alsa-devel@alsa-project.org>; Wed, 22 May 2013 18:40:51 +0200 (CEST)
In-Reply-To: <20130522160357.GA2917@katana>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8275226452580626035==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AXAqmCxJPvkQLT2P"
Content-Disposition: inline


--AXAqmCxJPvkQLT2P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 22, 2013 at 06:04:00PM +0200, Wolfram Sang wrote:
> On Wed, May 22, 2013 at 10:56:28AM -0500, Mark Brown wrote:

> > This doesn't apply against current code, can you please regenerate
> > against topic/fsl or mainline?

> ? Works fine against v3.10-rc2 here. Or is mainline v3.9 for you?

To be honest I didn't actually try mainline as I wasn't expecting any
conflicts from the branch and it didn't seem urgent as a bug fix.

--AXAqmCxJPvkQLT2P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRnPUDAAoJELSic+t+oim9rNkP/RsmFHXy0jfIOVWB2pCkgDhk
ow5HhbzqWYgbI7wdbvq20dzddtWPSJzmZEohJ/jwKTnxInuZfaQYZ+b1+FPsoCue
Nv8nk84pIwmgmpz8meCL1cAG0wHMOJrudZAkqsUYgBwu0I+IOIjbtG+i6IJbMAJT
twQmoRWQEOizBUWoYtf07+gnETjKrilfALSa5AigZbRmD9K6oR6irgwi/Y5luOYY
CSicTQcTWnJLmKkau0pzIUzILRItqn6meFMjcwTeMpTpXRYab7n4uDUmkoOrIbUL
vLlFLHoWYhrcPbjNxIOGfP/YIOJ01/1pR3ALDFfu1njBB8jHdquSPxOexMDSN+/g
8Lh9SpmBdR2sP4TUcRCp1wYw9gxKmKD3O5IL6nUH4oycFRnf9rC0Dv7kQoavvbex
FBAOdmCTLp5T6RmQdZMWjwsLIb6nsEVETM5VsnD0V4DsNrDTHpAophNjKG34ayaQ
OYCLAJGyuxQnnVHmOqIdT2adCqEO0BXip2wgqPejpGvVdP3CVkXfBQf4yBCUoXCt
MJx74jHzqqLbJLbhqAt0LAl6FX9Nv8mbIK1TxSv+/tqGZ6j+SApQBqah36MWXqt+
57oR+Xco/rhcHdrvpIf0zAr/TaCFF05OnhoV9DHxhrep3cGZW63sZOoBYvR3uQw6
5WbS3Udezdjn1g+rrDdb
=vaOs
-----END PGP SIGNATURE-----

--AXAqmCxJPvkQLT2P--

--===============8275226452580626035==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8275226452580626035==--
