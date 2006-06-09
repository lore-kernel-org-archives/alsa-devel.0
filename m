From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC 11/12] snd-aoa: add Kconfig and Makefile
Date: Fri, 09 Jun 2006 14:10:50 +0200
Message-ID: <1149855050.3864.16.camel@johannes.berg>
References: <20060607130909.584205000@sipsolutions.net>
	<20060607130917.996988000@sipsolutions.net>
	<s5hejy04x7k.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1232359642=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 28601175
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Jun 2006 14:11:01 +0200 (MEST)
In-Reply-To: <s5hejy04x7k.wl%tiwai@suse.de>
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
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, netstar@gatheringofgray.com
List-Id: alsa-devel@alsa-project.org


--===============1232359642==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-fO7VAIgWLkOkb9lsHipc"


--=-fO7VAIgWLkOkb9lsHipc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-06-07 at 20:50 +0200, Takashi Iwai wrote:

> Let's remove EXPERIMENTAL.  Or keep snd-powermac untouched.

Good point. It's been working for lots of people and I'm almost done
verifying that it works for all that snd-powermac handled, so I'll
remove the EXPERIMENTAL.

johannes

--=-fO7VAIgWLkOkb9lsHipc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARIllSKVg1VMiehFYAQIBRw//TZbAyEAtac7OgGzoPUgMJQtjahV+AbJC
IbefrY/zSNm9JP6jStqOQUJ7hxqql/rr1YS4SzuDrzTy/whHSuf1DMUv71e67o61
0bwPqZwvSFcatK0H2rDAKsNJym3y7PFV7A5S06uaOJkUeZaf8qklGZwzretDsCQ1
Q0HVjIWpZT0J+W2G+2xbxZ0gYc5gPtFpaU7yAoudq/vhtqthDhlfG9rx/QyAy2EO
iQs6BzgDEcGUCO8sug6x4FPcTeI4LPhcytnOAqMHnFezI62ZAin0tDBDK98YpFD0
O03/5T1CxInC1+vBIHcWtR9oNYkB306Bn4Yi95zEHwSjwlGVoV2ZDK9TXSIuZMCq
wsewLhjut+QXt3y6UZ0IuleRaidXNS+Ey8/sA+xSQgtOc3y6revqWFJ3Nql7jJxL
3j6cQQXLbyDlCPsrHs8yf+TI34IqEyRfPRjX+mBT8rHVH7FxqhpgU2IZucfYFHUw
ayTU7urAxqt8/oKhl4a8pCX2xI17Z7qziwSbXpOCoV7LTjo+/QSQmXs/+fGCLWeY
L2pBzgbeFT1Fem2smGvxzEOI1wv2CgbJZblHQ2m9ye0ECQz6ptV3rf+zdEEqmTBQ
HFaIemvQ8su98JOBh92qV9g7oNwCxwxX4CyiWS1CwAdyu++97ubQ0nvqZJ8FKNo5
0qtMFg//E8w=
=yNf6
-----END PGP SIGNATURE-----

--=-fO7VAIgWLkOkb9lsHipc--



--===============1232359642==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1232359642==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1232359642==--
