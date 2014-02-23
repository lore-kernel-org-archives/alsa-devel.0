From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 056/102] ASoC: wm8962: Use
	SOC_ENUM_SINGLE_DECL()
Date: Sun, 23 Feb 2014 11:40:34 +0900
Message-ID: <20140223024034.GV25940@sirena.org.uk>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
 <1392723517-12772-29-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1168314688495805598=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BF9AD26512D
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 03:41:07 +0100 (CET)
In-Reply-To: <1392723517-12772-29-git-send-email-tiwai@suse.de>
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


--===============1168314688495805598==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="S+p9DbwVuimCDe+R"
Content-Disposition: inline


--S+p9DbwVuimCDe+R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:38:12PM +0100, Takashi Iwai wrote:
> Just replace with the helper macro.  No functional change at all.

Applied, thanks.

--S+p9DbwVuimCDe+R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCV+fAAoJELSic+t+oim9AXkP/juZE1PsJPoADkU6ZGfu+Lfq
Uh3OL3jrf2PV9KEYmRBa+19MpMDl4igBWE4I7f57/ssddzFABGmRa6QHqM+ExNnn
jRmnO8+fo2nibKobXf3QFx0n//FcvTOlpl7fXl/6BFq+m9/cFwYDkxjWX6uSjIvZ
5lpPGOMS665++dLj/K4dUiO5hynKcTSV+Ym3E6bEhTe986qNRRq4U2E4PIShxswb
Z9bImD31Ys5oNMZpgnFcIfT8djqxVwxPg0YgRiXSeA1LR2PpbZn/grzvdU88sinT
jsLmOt3ORpZHhhuySuOLfgs4ELWgPOsr2xOeusfNOoQCj0aW2X5mZ1NJQOPlJHte
9LJJzNlnK67S2HtzRqXGF+KePJ2c2V3EEPBXejhfKV+L3zHzAQp5NL7tIdH6kDvO
JxaXoRcX0WfqZMYZ61paT+5Bup4f59xSVB7XYMVVY9M3/40SdYYdR3TpuIIg3sD4
8v8XgqgZLZQjxR9e3epgKD8MXIH5cE3NUluHHh9c2+pqd3xroatELzlQvnD3yW8L
+Kq87JlWFVog4+Rc9kgqLPul7pUGQVdEGAeC2dAnMynnwK1XIzBOaJr0/3CFgiu1
zDEJibQOfZdkIT6Q5WvAun4IxNXi75Fh7gn3kFnDX/Rpn5k8k/oypoezi9jxCmOh
IZOf79omR3tZjodm2Y5q
=SuRX
-----END PGP SIGNATURE-----

--S+p9DbwVuimCDe+R--

--===============1168314688495805598==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1168314688495805598==--
