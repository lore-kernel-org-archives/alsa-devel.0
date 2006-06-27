From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC 01/12] snd-powermac: no longer handle
	anything with a	layout-id property
Date: Tue, 27 Jun 2006 19:30:13 +0200
Message-ID: <1151429413.597.10.camel@localhost>
References: <20060607130909.584205000@sipsolutions.net>
	<20060607130910.156412000@sipsolutions.net>
	<jey7vjiqwv.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2003363029=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6AFF222E
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Jun 2006 19:30:23 +0200 (MEST)
In-Reply-To: <jey7vjiqwv.fsf@sykes.suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Andreas Schwab <schwab@suse.de>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, netstar@gatheringofgray.com
List-Id: alsa-devel@alsa-project.org


--===============2003363029==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-ROmvXrXBix9ymppYOuul"


--=-ROmvXrXBix9ymppYOuul
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-06-26 at 22:49 +0200, Andreas Schwab wrote:

> Can we get snd-powermac back as long as snd-aoa is lacking all those
> features from snd-powermac?

I'll be fixing it next week after an exam on Friday, or if I don't go to
Nuremburg next week (4h hacking on train :) ) then the week after.

Until then, you can just revert that patch locally.

johannes

--=-ROmvXrXBix9ymppYOuul
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARKFrI6Vg1VMiehFYAQJxog/+Pr7qJ6PB6xahnCthT8ds+y+N1Qtdexro
GXoqgNcNUsXezbjl0sskH8Ch81s7PeAi4qogmhG8qAz0TDJ3Y5SVRhmNyPC4UCJa
lGvEDr6iDeviT0q1kF830rjKZA08BwKlyhpeJeZVFRoPitl9lCMjDYxIxpD8/GH0
ayceReiVU4PTmB7qKsBQelnwTRspetYAmnSxMZpwdaz1gcy0lpNs7JkyFvtY1zvi
it5nGv8/2HYCwyLSIwiPT9JXn62G6lQ1omT2mvfFm+k/RmMLTlIhM9DvumqE8Hm5
PRAouyzdxKdLyja1QeidS9g2tAAlrSCL6e5qVyFBP5sC6x6aFjUbgpnHwvMEZURQ
HqrAEP1y0QJY7Q7E5cXiFv945f3Syeyw5MlvfgX9XOrroOUhDS6K2wsiyjzcVSoi
YmMfcx0s68UsH0D/Nm6NC4iJ4vIBHhLp5SJ+lFcZMmd0vaRtXoAx1kWa2AITutTI
zWQOF73ffhOpL+k9oSTaOtD3uTnSPZNRXZ/Ac50ZcSsI7aNNo5MhDhJxHmGznOV3
ZxUDxIr1zWpt7a83gEawhg0T8PpbJDOxrcjl8pvQNDOLVzGa4AZdxn2JNkgvEUKg
YO1r2z4uQ3OPSaoaXPqv7AIWWqC3ikxmc9U9WjzJXA+fZLmyiVZIav0TpC2sm8rT
Nwc/tNZGRog=
=FxNC
-----END PGP SIGNATURE-----

--=-ROmvXrXBix9ymppYOuul--



--===============2003363029==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============2003363029==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============2003363029==--
