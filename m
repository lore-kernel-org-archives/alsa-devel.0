From: Christian Trefzer <ctrefzer@gmx.de>
Subject: Re: snd-nm256: hard lockup on every second module load after powerup
Date: Wed, 29 Mar 2006 16:43:03 +0200
Message-ID: <20060329144303.GA24146@hermes.uziel.local>
References: <20060326054542.GA11961@hermes.uziel.local> <s5hveu0chvy.wl%tiwai@suse.de> <1143500400.1792.314.camel@mindpipe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1143500400.1792.314.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>, Takashi Iwai <tiwai@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Takashi, Lee,


On Mon, Mar 27, 2006 at 05:59:59PM -0500, Lee Revell wrote:
> On Mon, 2006-03-27 at 12:16 +0200, Takashi Iwai wrote:
> >=20
> > Try 2.6.16-git tree.  Some patches for this problem are there.=20
>=20
> If this does not fix the problem then alsa-devel (cc'ed) is the best
> list to discuss the issue.

Actually, the changes in Linus' current git have fixed the hang for me.
Good job - thanks a lot, guys!


Kind regards,
Chris

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iQIVAwUBRCqc9l2m8MprmeOlAQKU1BAAkYibdE03Fukjl2F344jnsQAY6t3cPeym
gsWIMkKbVwy9iXl3qdS+0IEKRmwo26dUUNDZfvbww1hQhmAhFFB3d4sG4jHUV2cR
lI+scSarVECUtZ9B42oPbJOLTkm3jy7YtHgk7QnVlxujJtacGDbbMZ6RmGCOegsc
5vJ7nmoCdf7Kd0HI/1purtpDUbp7cjOTwK+hCt65qH6LaSxs3e++551uVks00ZuD
Dn7z8pBwLRuCwuQYbgM+/h9zgmdnGeEbZ/HhcP6DMTTU+9bSC3+L/c/dB9EPcZPB
zWxhwojIJLym9OSZf+pVaKDaaV0+IPFg7U4KmKa3GiAumhQxZoZ7CyF9WXw0mJYl
WlGYRjyAHvYHe9BzJEAyBshUps9vX2T+dTTI0W3P6aMjKfRNKFLTn3rBU+CG+T4X
XAOIKnHgFappDBVjJ4eDDQAZ7ixi4YR1XOCRFTThX6h62AcHGGXf9Fp23sr7EUzq
ev+BAvFlHb+Cwcc7sn3MqTVHXmlCEONFVkZtD5clrg43po/g0RqQgw+odkIUcdtb
NzUF+HuTEG/xBr4zgUzxr6poUWJMwd5csH/6UD4X4jBaxloPQ9xEclWVyZYP22Hg
3+oTKciehU895x03GSwAwStblLb4mNUgyBuP3DNhCVU0Le2nXj9WkwCTsfz9T5YB
7PTUR2aV9h8=
=ok0H
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
