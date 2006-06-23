From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: all-modular snd-aoa
Date: Fri, 23 Jun 2006 16:54:52 +0200
Message-ID: <1151074492.7608.41.camel@localhost>
References: <87hd2cz116.fsf@briny.internal.ondioline.org>
	<1151072095.7608.29.camel@localhost> <s5h7j389c7d.wl%tiwai@suse.de>
	<1151073390.7608.38.camel@localhost>  <s5h3bdw9b92.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1189075946=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F1AC1222
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Jun 2006 16:55:00 +0200 (MEST)
In-Reply-To: <s5h3bdw9b92.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Paul Collins <paul@briny.ondioline.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============1189075946==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-bwNey68v96dPc9G4lTwb"


--=-bwNey68v96dPc9G4lTwb
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-06-23 at 16:50 +0200, Takashi Iwai wrote:

> Then it's eaiser to fix sound/Makefile.

Ah, I should get out of fast-mail mode and think about things a bit
more. Sorry. Yeah that should work, Paul, could you verify?

> Post patches to alsa-devel (and Cc to me).  Will be pushed together
> with other fixes.

Ok, but then should I assume you already committed these (your own)
patches or not?

johannes

--=-bwNey68v96dPc9G4lTwb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARJwAuKVg1VMiehFYAQIP7A/8D7wwmcrkfOckN4Pe2oowVFxsB3aIaRCu
j20V/8dzBbvpi91LnLqydlR9Hpb5VGZikL4aOSp7fPxiT3ww3AeFsICv/CrHPlJt
CKeAMMBeCyyiQgMu3ySBmXntqRw398aQf63x1rXiGpx0SPez8eL3AnWT13caDn3M
0ttkioG+B1eyAfNkSmkemaE6WfZ3MpTYF5VUNoByMB/IV3Z3boabRBTltj8m+vMd
bt+Jd3LtXvucaZ1RMQUQ1EA9lqN0xF5NkcMaU0gge2lZoFzW6UTHp0SFkmvrACFo
85XjHqVFj6CGAOp/XnCtbl8VAdVVGlhVcnxfEcFuGufcY7719kaZgipLrh5DFM+9
edvKcFYCvNF2OAXXsYP/ZyyemDz8CqJdsZVJ5H4vauUiM+RBfsBrYM2zdZSGUL0B
5VtXUngUK+JqUinW2y+KAx0ev1EGiO/apXdICkHEIrnthnVZWeNyTqtjOtHaPW7/
FtJfBRx0nTfBf0qyrqjVEJcY4qb0+zq99F1Bm1vTqwjJIabWX2jmIEATH+VMSIIJ
ScoURDZvsi/eF2p8wLR5ZPeNKK0CkB1gJmUxTC1KNMPQ3leiCEZ0Pugm73IIY9yR
qxe6Z6D1qJ5Swg4va+h0QU1aygpMEovyomxrVJQ5pyGMNzRMifxUty9y8yYQUjkp
1wO52wO2mnI=
=Ec/U
-----END PGP SIGNATURE-----

--=-bwNey68v96dPc9G4lTwb--



--===============1189075946==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1189075946==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1189075946==--
