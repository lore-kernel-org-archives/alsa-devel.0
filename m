From: Rimas Kudelis <rq@akl.lt>
Subject: More detailed Acer (Intel HDA)
Date: Sun, 19 Mar 2006 14:47:47 +0200
Message-ID: <441D52F3.9010107@akl.lt>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDCFCD0802B1D968AF3CC65AB"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDCFCD0802B1D968AF3CC65AB
Content-Type: text/plain; charset=windows-1257
Content-Transfer-Encoding: quoted-printable

Hi Jonathan, Takashi, and others,

I asked a user on Ubuntu forums to test Acer jack modes more
extensively. The results are a bit surprising. You may want to check
out http://ubuntuforums.org/showthread.php?p=3D825101#post825101.

It's strange for me that it seems like Mic Preamplifier seems to be
always off for LINE1 channel.
It's also a bit strange that a jack connected to MIC1 always outputs
in mono when set as output, but maybe that's just how Acer engineers
decided it should be.
And the third interesting thing is that the user could not select Mic
modes at all for LINE-OUT channel. Did I skip this part in the
datasheet, or is it undocumented?

Also, is there really a difference between Mic 50% and Mic 80%? Maybe
it's enough to only make one of these modes available in the mixer if
there's no big difference between them? Same goes for
Headphone/Line=96Out modes. What airbuds did you mention previously (you
said Headphone mode might be useful for them)? Is it those small
headphones that one can put INTO their ear and then hear poor sound?
:) I don't have them handy ATM, so I can't test if there's any
difference between Line-Out and Headphones modes for them...

regards,
Rimas



--------------enigDCFCD0802B1D968AF3CC65AB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEHVL5AlYAh8azrv8RAg00AJ9b3k8z3sMw6GRdSh9dvYOty3yd3wCeLWO/
GheAQnCj/27abR8X7QFmRpc=
=EGpE
-----END PGP SIGNATURE-----

--------------enigDCFCD0802B1D968AF3CC65AB--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
