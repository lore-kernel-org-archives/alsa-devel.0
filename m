From: Tony Vroon <tony@vroon.org>
Subject: Re: Microphone bias
Date: Mon, 13 Jul 2009 11:55:42 +0100
Message-ID: <1247482542.5461.1.camel@localhost>
References: <1247475045.1759.5.camel@polyethylene>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3011780108746358976=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganymede.vroon.org (ganymede.vroon.org [195.66.242.11])
	by alsa0.perex.cz (Postfix) with ESMTP id CF39224452
	for <alsa-devel@alsa-project.org>;
	Mon, 13 Jul 2009 12:55:49 +0200 (CEST)
In-Reply-To: <1247475045.1759.5.camel@polyethylene>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Drake <dsd@laptop.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3011780108746358976==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-VxIlK2vSTXYiUkGzGk5s"


--=-VxIlK2vSTXYiUkGzGk5s
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2009-07-13 at 09:50 +0100, Daniel Drake wrote:
> We have a choice of 50% or 80% microphone bias on the 2 microphone ports
> (one inbuilt, one socket for external devices). Any suggestions on which
> one we should pick or how to decide?

For the external devices, it tends to depend on the headset. I would
suggest going to eBay or a random computer shop and getting a few
different ones. Some may require 80% to produce a usable signal,
particularly the cheaper ones.

> We can't hear any difference between the 2 settings..should we choose
> 50% for potential power savings?

If your internal mic works fine on 50% bias I would keep it there, yes.

> Daniel

Regards,
Tony V.

--=-VxIlK2vSTXYiUkGzGk5s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEABECAAYFAkpbEq4ACgkQp5vW4rUFj5pf0wCffl3ZjPCJDsfYyVr6MinwBLR5
GPkAoJSrb8tBk7G3nSQoSXC5kiNWLsC7
=F/Rc
-----END PGP SIGNATURE-----

--=-VxIlK2vSTXYiUkGzGk5s--


--===============3011780108746358976==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3011780108746358976==--
