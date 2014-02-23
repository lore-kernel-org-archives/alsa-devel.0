From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 059/102] ASoC: wm8995: Use
	SOC_ENUM_SINGLE_DECL()
Date: Sun, 23 Feb 2014 11:44:05 +0900
Message-ID: <20140223024405.GZ25940@sirena.org.uk>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
 <1392723517-12772-32-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0690581505303842403=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 79353264F8F
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 03:44:28 +0100 (CET)
In-Reply-To: <1392723517-12772-32-git-send-email-tiwai@suse.de>
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


--===============0690581505303842403==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xp5T+jWXk9cMuWlh"
Content-Disposition: inline


--xp5T+jWXk9cMuWlh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:38:15PM +0100, Takashi Iwai wrote:
> Just replace with the helper macro.  No functional change at all.

Applied, thanks.

--xp5T+jWXk9cMuWlh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCWByAAoJELSic+t+oim9v0MP/RPQQEqmbYYsaCprY0BWL9aS
uM7gQm/FkYQCAfUUbohfH2KrGglekGbqvJzKTJ9LZ5BzyeTbFynsLxG0QQe3eD2N
u1zq0KBBBF+FSj7UWx+vr025r1onLNzK/X20ovTN7HnVgSxj2T8ZW3MBhZglCK8C
Is2dbtsPDf8qOtZrjmevXLfWgqMNhK2oMmdswN24SoB/vrQUh8n0V1YC96756qEX
M1236fiqmEZFa54V57JV90/my8O8XfIrWk8129XpA+1BYpmEq9mvedO7X/Mbs09d
zNh1oE68j9R7Awo5Ih3egJdCHqCnVMDL7BAZF9J/8C5AF7zP5M+T4bWPG3AgLy6O
7czzM08JzHQDvRA8LMAIHgpvnzS3MUBwmOEV7eE4X5aAGc58CU9NUj9gm6db0xWn
ITfd4Fi/ycfZWjQLclLimtIfl7jfK3W/pge35hau/C1neMyry/hKmL/fvKKbmKP9
ye8tuQwSDBHvOKBf7XxtP52UvIYI8gKZfPIpProAdCKhU7sJajb6HWMd5v8lnnoK
gg2Qg949IveQmI03I1RX2FG+xAxyKQga0gxV56giq4dIooKunn/3yzZwM4X2lv4D
mysAQ4ibRyqMYfnxNXG7GpWlp6MtVAuidpG5xjxxPk1zTdDAhk1n5OTQpfZUf6z7
ei9rT6gF+APy5l1+KFks
=I9ir
-----END PGP SIGNATURE-----

--xp5T+jWXk9cMuWlh--

--===============0690581505303842403==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0690581505303842403==--
