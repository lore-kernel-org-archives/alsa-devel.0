From: Tony Vroon <tony@vroon.org>
Subject: Re: HP tx2100er headphone jack problem
Date: Mon, 13 Apr 2009 11:12:54 +0100
Message-ID: <20090413111254.064d079f@vroon.org>
References: <c9b2ed1b0904120844p7949b1edqa536c43dc2fc9401@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganymede.vroon.org (ganymede.vroon.org [195.66.242.11])
	by alsa0.perex.cz (Postfix) with ESMTP id 62D861037F2
	for <alsa-devel@alsa-project.org>;
	Mon, 13 Apr 2009 12:13:06 +0200 (CEST)
In-Reply-To: <c9b2ed1b0904120844p7949b1edqa536c43dc2fc9401@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Alexander Beregalov <a.beregalov@gmail.com>
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

So it's a Realtek ALC861-VD attached to an nForce southbridge,
subvendor 0x103c device 0x30e5. The vendor is known but the device ID
is all new, which gives us the flexibility to write a new model for it
if the need arises.
To know what the model should look like, could you emerge codecgraph,
run it and send the resulting .svg to the list please.

Regards,
Tony V.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEARECAAYFAknjECwACgkQp5vW4rUFj5o58wCgr4NtGLcbc9v2DzbI1jtldbjX
1DQAoKdTggeIhmXDTLCTNBruxoURiLaw
=6aXG
-----END PGP SIGNATURE-----
