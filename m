From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 025/102] ASoC: wm8990: Fix the wrong number
	of enum items
Date: Thu, 20 Feb 2014 10:30:19 +0900
Message-ID: <20140220013019.GK2669@sirena.org.uk>
References: <1392723422-12689-1-git-send-email-tiwai@suse.de>
 <1392723422-12689-10-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1238064445875585071=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id E409626538A
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 02:30:24 +0100 (CET)
In-Reply-To: <1392723422-12689-10-git-send-email-tiwai@suse.de>
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


--===============1238064445875585071==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zs32KGgguTW8DKq/"
Content-Disposition: inline


--zs32KGgguTW8DKq/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:37:00PM +0100, Takashi Iwai wrote:
> wm8990 codec driver has a few places wrongly defining the number of
> enum items.

Applied, thanks.

--zs32KGgguTW8DKq/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBVqoAAoJELSic+t+oim9Fn8P/2qBsZcpJx6AMcteEiW4EBYK
NgRY6vEtnyTMI/I/QZVwhv6p/QuyMFOWvsDKJiM5Q0gPQyZjopFlzU7G9ibQgWQn
E4/HDcIXcehucXk/CJ2+1aH93YlSg0vfeKX+eIEy/IpSTtU2pMbPRbM7BmgDdyy6
XwoHxbJvSmX2iEzFY9PBQWcNGk+4b+TRT1BRhxNQBUGpF3c70OsM2yPHyM+X2O8s
j7++T6wOzqr4zAlCSjAjarkimaGy9rYWVYIG5yD2KXKNYKFJNjtYwzWAmpApbR0h
I7nflQxpeGLmvk2ezhSj2QAGj2BXjLplknSYgY+3Oo8OfMIKtnopHFBUDRi+DfJ9
0vnobWnFqk0mOHSfPY6XJdFQEetUtANYJUWzTIC/T8RY1PoZY2ywJ15NlWB8hwrZ
4spYg2afp6cytQqpNm6vPWDHu7jfGboUvecHW60ugrBF557raLhHaA1vnx7br2oH
hq4Aw9qLek41HlawAyfb5zHlrPwarjObH43j4rtDnclYNyiwD05zEpCiVXEHwCWJ
EDzK8dbq50sjL98mXyEMKsi5A2NzbS3dUt0E0syzt5MeR874/uX0w5lvm0vm3dFW
3MRvAHFbAZlj765OwsUyxln8DYEI5eFAnVT2lCp5mpeVOecuqI/0WNBGAwr0494y
MDpKdnM1Ld++2HhUBb7D
=m8EP
-----END PGP SIGNATURE-----

--zs32KGgguTW8DKq/--

--===============1238064445875585071==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1238064445875585071==--
