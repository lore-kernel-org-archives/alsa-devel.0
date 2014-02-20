From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 030/102] ASoC: alc5623: Use
	SOC_ENUM_SINGLE_DECL()
Date: Thu, 20 Feb 2014 11:14:03 +0900
Message-ID: <20140220021403.GI2669@sirena.org.uk>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
 <1392723517-12772-3-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0054027791401753023=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 01FBE26546B
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 03:23:27 +0100 (CET)
In-Reply-To: <1392723517-12772-3-git-send-email-tiwai@suse.de>
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


--===============0054027791401753023==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OAu8edmdpnwHuCY+"
Content-Disposition: inline


--OAu8edmdpnwHuCY+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:37:46PM +0100, Takashi Iwai wrote:
> Just replace with the helper macro.  No functional change at all.

Applied, thanks.

--OAu8edmdpnwHuCY+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBWTnAAoJELSic+t+oim9WZUQAISN7eX5OHoLihla4zkxrncx
92+zR3wMJEUs1YBwfl5nUCJOW6v84vLgDUFn9p6ED1pdv4ckj+iZ9xe+bbt8e6Gp
m1Z1QYISbJ0zasZZs0N73iMajJ5vjf+AfpOo+ANWiwBBB0BNEN99kDqjlgA5VdIw
xA4oYOCd0ubGTnmEW8GYAtJNeIoNMBF7FmUVgzZdQQoHZBOgqh4EDYItLkP5Wmih
Ok7zG0ErbNudEaL1jG14j0nquQmraw7Q3I1zoRpG4wUpT146VLYQKJ9d41qMesFz
tRJKDhqL8J7eclMu97HW+SWaZDcUB5ooyMxrPgEMEF3DH1v7UJFjRbAtQ2YuOOCM
h/o5cZnwTYmIo833YEmiAweREfhzRthh1ETqgGlQNk+BXxoAds62gUcJIsXvVI8L
EKQ69RdhfA0LPXqy0PYLBmwmZ5Ainbdso5Bhq3KekRTra5EKjM4BkW2pU72mxztR
weUgxItlLey39WKyaMgUSx9SaTIGYHBdugx8YKzQDVJ+GCzCCrsEPbLdt/4fRx0U
90fWaiNn16lJkSJJL9q0irK0uTNCCUZ41nSi7RC5iEqiEqMMwdQPYxhZZW6C/vKH
h8KAK19VOx3j79D1J/U7QdkhHNmVcvpmefrKo3XU4AjknMUzMZfVll68qkmQJ2gX
rAHn4pyqzo4VCp9iGxnO
=GIF9
-----END PGP SIGNATURE-----

--OAu8edmdpnwHuCY+--

--===============0054027791401753023==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0054027791401753023==--
