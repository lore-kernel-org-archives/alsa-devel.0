From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 044/102] ASoC: twl4030: Use
	SOC_ENUM_SINGLE_DECL()
Date: Sun, 23 Feb 2014 11:29:42 +0900
Message-ID: <20140223022942.GJ25940@sirena.org.uk>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
 <1392723517-12772-17-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7742822616452841977=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B858264F03
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 03:31:16 +0100 (CET)
In-Reply-To: <1392723517-12772-17-git-send-email-tiwai@suse.de>
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


--===============7742822616452841977==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A/JKaSqKPqQLCbw0"
Content-Disposition: inline


--A/JKaSqKPqQLCbw0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:38:00PM +0100, Takashi Iwai wrote:
> Just replace with the helper macro.  No functional change at all.

Applied, thanks.

--A/JKaSqKPqQLCbw0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCV0SAAoJELSic+t+oim9jNUP/Am1LJGLHmhPs5Mtd6FTr0Yz
p8oONAfhZpbVo4dbD8wyniCdQfg84t3nDPJC04wfIWqAVPxwd8aQvT6sZN87Pbew
Y2dIxol1jhLolGEpHc1IkI8QrbP4A52AszpZLKzcZ8lq+/XzEeKaDdFoE+JoCmTH
6UVj6P1QA8kM2RRVHUJE8x5GKLbUnJGsucsW7OgmzsrwKpEqf36oRL3NuJJ6AyJq
MBFAWYg7/blRj2lSfFjE2amYylbuuO8/wd2XK18W1+18kQHLsNUcrqfiWigWemlT
v3TPf/ezHIMQMG8/vrzgnrlYqgg7hfUgGrOOFgmaAc3dZaWgz/6LrXF2N7giVvTd
IQKVfnZ4yPrXh6R7stZ4i86GInnOSh7M7WJcQHh+akTGgGYwgFcfz62efli3DVtu
WM3/gB5fxKvP9KTZwnU81SmlmR7MpcaZd+Bj7QN818LAykTZNmZFDmdI85sbDMQT
vjxDIdi9rwBT7zlAc0/uzQ+Me6chQNwc7B+35NKvi0jPklgpZSPDh9HfEf9aihcj
2v8apq4oySTrNOw1qRrUERAe2O76MBk4oswnPi4yv+A9UkMrE2wUG2kwmlIoVwSh
SOIDJa8uGCYVC5uUa1RD+DzovRvu+XobA4sy+7goNdM/1GOqojyO7Ghp19CNlx+n
Dw6qdga22lWlvqIiL4am
=BhE7
-----END PGP SIGNATURE-----

--A/JKaSqKPqQLCbw0--

--===============7742822616452841977==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7742822616452841977==--
