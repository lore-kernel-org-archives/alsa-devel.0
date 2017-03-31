From: Pascal Wichmann <pascal.wichmann@pa-w.de>
Subject: Re: Problems with the DP MST audio support patchset
Date: Fri, 31 Mar 2017 08:11:52 +0200
Message-ID: <49ff23f3-7c58-abf1-f1ff-87822f0b0585@pa-w.de>
References: <6800ee6e-31c2-b5eb-fbb2-6826d8c66dc9@pa-w.de>
 <bceb4859-6dc9-b7a8-4d3a-81ac2a1fa907@pa-w.de>
 <96A12704CE18D347B625EE2D4A099D19524850F3@SHSMSX103.ccr.corp.intel.com>
 <63a71394-1cd4-e3e3-7364-37c2da90c791@pa-w.de>
 <96A12704CE18D347B625EE2D4A099D19524854BD@SHSMSX103.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web02.pwsrv.de (web02.pwsrv.de [188.68.38.65])
 by alsa0.perex.cz (Postfix) with ESMTP id D1AE2266BCE
 for <alsa-devel@alsa-project.org>; Fri, 31 Mar 2017 08:11:55 +0200 (CEST)
In-Reply-To: <96A12704CE18D347B625EE2D4A099D19524854BD@SHSMSX103.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Yang, Libin" <libin.yang@intel.com>, Libin Yang <libin.yang@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi,

> Get it. Basically, 5.1 audio should work. What format are you using
>  for testing the 5.1 audio?
I do not use a specific format for testing; the issue occurs using
speaker-test as well as using any application with audio output as for
example vlc, rhythmbox or a browser like chromium or firefox.

As mentioned, when configuring the output as digital stereo or 7.1
surround, except for the second issue explained in my first mail
(which actually is more annoying) the audio works.

Regards,
Pascal
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE/gJ8Tpn0OtJz8hxD6+YIa34W/zYFAljd8yIACgkQ6+YIa34W
/zY3Bw/+MW4ziQgRwY8/ElLytL9ewBQaft4DZLZoVaJomIwhgpr1y135rpJRnmMB
XkQk9Qr7qMTmE8/wTssEwJwZ38HFcrn5sSGlhIPIcqy3J3D4EM3ANTo0xzl2yoYc
zLxPuu+t+hPBeWOZgK34IjhQzuRZLXx5lsPFNpCAzJKbP8RTExw1Zu+OvbZQAieU
YM7T6nf3s98BF2/1DLdXjl62PDxVQ08olPM/euEhi3DzsZs60hIkI6ebNsXy6xnN
Os+bHh5Mgc5vdjjDEQ9+or8aPFd9FeOo1qSZemNPe3h8OLCtuUt53SkmJwqpW3qH
L8Wa/xjOxPFDVw9Ehyp+jD51s4lY+xk0h4+De+lL1pq0srNM1NdDEh0+x5kjCBf9
l2XaXN0sxmDmJkIRzdPYrQ1NB3ieNAhqHGcj+Zb4x/gzH8WJ8Z/+VQZVu4sntorj
4JcIzmw7U8LdU2t3ytqZ6JTlrr1t+V31gIDQuB1M5G336Qj7F5XVJxVc989uEOkP
qWIMLXrWXUhKqMSBfpQkTAFKGbD4xR6A9Em/efRdXFkZH+AXiZxTSfZt1dSFqOZ6
OtVhL3Ew4RW7xSXTwILB1eh4uoFnztLm9VCB9JGoge2OQII8QcNMUbdoNtoNjLxh
XkMkWCnd8iPYH0ix0dMKdaTI0c8JUCWZKjun2Tx9jePLoMuqE60=
=JrNV
-----END PGP SIGNATURE-----
