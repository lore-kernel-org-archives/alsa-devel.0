From: Mark Brown <broonie@kernel.org>
Subject: Re: Audio Mini Conference Minutes - Edinburgh 21st
 October 2013
Date: Thu, 21 Nov 2013 18:22:11 +0000
Message-ID: <20131121182211.GD8120@sirena.org.uk>
References: <1382985876.2334.64.camel@loki>
 <CA+v+29hOBcuH-teW+5si8qj9QD7o3bsMYFj8v-YfKJRM0XVn8w@mail.gmail.com>
 <1384796142.2319.12.camel@loki>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1237226643039629516=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F87926109C
 for <alsa-devel@alsa-project.org>; Thu, 21 Nov 2013 19:22:18 +0100 (CET)
In-Reply-To: <1384796142.2319.12.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Eric Laurent <elaurent@google.com>, Wang Xingchao <wangxingchao2011@gmail.com>, ruyi@xiaomi.com, wangxingchao@xiaomi.com
List-Id: alsa-devel@alsa-project.org


--===============1237226643039629516==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xB0nW4MQa6jZONgY"
Content-Disposition: inline


--xB0nW4MQa6jZONgY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 18, 2013 at 05:35:42PM +0000, Liam Girdwood wrote:
> On Sat, 2013-11-16 at 17:01 +0800, Wang Xingchao wrote:

> > > We could use offload, on roadmap for Hires audio on android PCM,
> > > maybe float instead of 24 bit. Need for 192kHz, Probably not use effects.

> > Does android support HBR audio now? As i know from Dolby guys, no
> > customers in Android area are buying Dolby TrueHD license, so i guess
> > the answer is NO. Most of the customers are from AV receivers and
> > BlueRay players.

> Afaik, no one is using high Bit rate audio atm, but there is increasing
> interest amongst Android OEMs.

There's a few things shipped doing 192kHz/24 bit - the LG G2 was one of
the first IIRC.

> Most of the x86 and ARM HW will support HBR audio over ASoC PCM DAIs and
> HDA, but I'm not sure about which HDMI audio devices support HBR in HW
> atm...

It should be relatively common I suppose given that video sources have
tended to use HBR for a long time (even DVDs do it as standard), though
it's possible the mobile
chipsets are limited in some way.

--xB0nW4MQa6jZONgY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSjk9QAAoJELSic+t+oim9+gMP/jnVrx3BUXs4KdztjUJ3zkXS
j78/MLXHeu+3wvi2V11+MI+o2WRM2OpxkjrDG1scDS/9xY/zYS+FGsYdqwHwlwm4
mfxrEh9aUik+FxdYQhKcb+IXF+BnLtD2jqfPtfYODM3fgm3xt/bD4L5mMDxjFphA
81srtJxltysPvHCwjrSHXjbayAEwHtsxOkmC+izOX6IZRiHy2JHYNAw+8Wsk+CYJ
59z+Gug/y4175g273mAMD/EuSSjvwcuN+E1W9n6OgS8w81M/ImcxZvpVgeXUIzfU
mZwLkO+GgM44OsUKWiHeniAVAkyWGAUX02pls4hr+p9Wux/TGPyGiIn40p2SKciS
ki4qV7SaKEQHqOE1qz9jHdFuJyFbpGAAAGHEynU51bGZnE5G++ex6aaNCo0yqNkN
hZnj/ke0y+oboYT9PU9+Uc7QRbKfElZ0jwVoKzSETZe+6nka3aE4htCZjzAujIZP
UBgHswW1FTzmYPw48S+I569B4SUBIi+r+My14BuyKz0cFeeRuF826+h/dhyJA6Dq
WlP7g639uTFw5q8e30RtE5w2yvFCPj7Prz0QUGqMhrovQfzLDj4drojXrfeB9qu0
fmX0bfE5h006aUhst5JDJdZ5jWYXARwSGqim7ZkvR19szuJemLXO13SAQ0b71g1u
qKe5d5M1B2mcRqmVAECB
=FVxn
-----END PGP SIGNATURE-----

--xB0nW4MQa6jZONgY--

--===============1237226643039629516==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1237226643039629516==--
