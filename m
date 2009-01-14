From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: hda-intel on macbook5,
	1 (was: lockdep warning	on	2.6.29-rc1	with	pulseaudio)
Date: Wed, 14 Jan 2009 17:33:04 +0100
Message-ID: <1231950785.3789.4.camel@johannes>
References: <1231866121.3847.6.camel@johannes>
	<s5hiqoj870o.wl%tiwai@suse.de> <1231868779.3840.11.camel@johannes>
	<s5hk58yfko5.wl%tiwai@suse.de> <1231928348.3730.7.camel@johannes>
	<s5h4p0288sb.wl%tiwai@suse.de> <1231949930.3789.1.camel@johannes>
	<s5hk58x7t74.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0646895202495732982=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	by alsa0.perex.cz (Postfix) with ESMTP id B9710103802
	for <alsa-devel@alsa-project.org>; Wed, 14 Jan 2009 17:32:56 +0100 (CET)
In-Reply-To: <s5hk58x7t74.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============0646895202495732982==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-64U3IhqckeRL11jlOpQk"


--=-64U3IhqckeRL11jlOpQk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-01-14 at 17:23 +0100, Takashi Iwai wrote:

> > I played with the volumes before, didn't help. Should I try to look int=
o
> > the Apple driver binary?
>=20
> Maybe better to play with HD-audio verbs.

Any idea what to try?

> Or do they have any external information file like on Windows *.ini?

Yes, Info.plist files, but none seem to contain any useful information,
what sort of information would you be looking for?

johannes

--=-64U3IhqckeRL11jlOpQk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJbhO9AAoJEKVg1VMiehFYiZAP+wfNO/lpuDvKXS9vLR8OSvOI
5RHZh9Sg5hdmUETU8SOAaosqg+ztagQ+t38PN4ICkRHtEoPAdRgDTRm4LNmIkvui
CysIYkk0Gw/VY1TTd13DLmzI8N6VhfTDt5Bte2QgIXZEMBkV5JCHwDuxlLMXeA1K
b309rKFhM2CTyqrxGvrL5jCIkIX5CyKNPEsDy8hICet54B5YaHT/dmebCjEKKF48
KupOygzndhylHs2JB2AQh3krnCmZMGQ8BpsBtPDXBYga1YqA5KmMjNveLhVYGvSi
WG0PyDllLZiFFFFASUwZJJ3Vg+scbbvuHqYsOuPTdRjwAiBnoCSgIxA5vx8zdP9A
MOrDCAkd1Qo3kevdAgcdfVUmnBVA/XHlfgvcjn/00fDBL4DyZBf1bysZh+XZfftN
r079WdRs7ilRrXcMLlnxC5kEYFvNfJO5oNsL2rxCBEN3ov3YUQ4RKt9fquY85OKn
mwiJPNbHrjikMjwEaVfcvJqFp0Vrv5WjKjeqDwTlKO8TXRjxmh/pOGkdAdY0Sypr
9wLl4gAuH7dtS5xql1yMRK3TpnpIHGNC5TzbH6r8TYxxclS/99de5i6Z4ZhXlAju
c0C8J9HlaxPLTZZkdLaCdT6kEODFE5Wk/Pb225B1IwPqhSQXNNuhiQo/o5wJ6nr2
0vlg6IIIrBK2ujRPTJ5b
=JvaB
-----END PGP SIGNATURE-----

--=-64U3IhqckeRL11jlOpQk--


--===============0646895202495732982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0646895202495732982==--
