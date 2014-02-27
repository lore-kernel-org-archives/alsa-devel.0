From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/19] ASoC: rsnd: new module path method
	and DT support
Date: Thu, 27 Feb 2014 14:08:04 +0900
Message-ID: <20140227050804.GS9383@sirena.org.uk>
References: <87d2ib90t9.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3520253910411174999=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 761F32657F0
 for <alsa-devel@alsa-project.org>; Thu, 27 Feb 2014 08:46:43 +0100 (CET)
In-Reply-To: <87d2ib90t9.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============3520253910411174999==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LwgCY5hL6Igino+O"
Content-Disposition: inline


--LwgCY5hL6Igino+O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 24, 2014 at 10:13:57PM -0800, Kuninori Morimoto wrote:

> Now, Mark's ALSA branch doesn't include SH-ARM platform branch.
> Thus, these patches are keeping compatible for it at this point.
> Compatible code will be removed after merge.

Would it make sense to do a cross tree merge of some of this code?

--LwgCY5hL6Igino+O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTDsgxAAoJELSic+t+oim9bYEQAJgRAflAcfLxpraxk2Ep07LH
EcJxMzs7XQ4EvOgQmWe6S7ec4cuQIpb4yqRUvwQ13PTI/xQh/CwwQlT2oIHQTXI4
Fv3ISshai332S7NRSpXUtwDSzlaPdKMs8L14NVwPK+cNqgDa1lGMxN6cT9KZrNp9
xcdZ8hp/rtc5AA+EtgQh9QXsxOZf+ZhK13z9iw8MUNkxR+5OEJvbPfZJci1kWXIm
A0677x71hhoJeKu11bKbnz0SPoXU6ykf+fADzPRaXJtXLtph+lX6DhXTBukPxL/W
4DWnOwrRFNGneoWQ1Or3NGLRtS6LluSoj+5bPq+59dWT5az/JYWLbLwX53pTWPdB
vAPDsBYAL01zLqHA9pBq/LMGdTzYC7IuLRA99P7LQVokP8FjvKDem+ADY9AxzEEE
UjNUwsUpf3vqhGS7PJ3jZ+XMQ79JZNsQFxd3sUGJcctOXtuJUfn3vXnz0WIEpTJC
Q3I0g28T0sduARLM5BXbs1GFzpNAXZ6vsEAeYQzOGMkqGzrR/OB6f8jv6wATGEpg
seTY6oIdbtS6NJKLWpor3O85p1wYDRGfMjG/Eglj3Hknx6TV7sHneACqmm2y7WBS
WRhGMaDVI7I8+zExKy2jwsUXC/Dc1xRwfPAdzn4Qj7Jo4KLbuHtKPVkj4jHZJiAg
h09KDFTZiyE+ojeb0dKb
=sBgt
-----END PGP SIGNATURE-----

--LwgCY5hL6Igino+O--

--===============3520253910411174999==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3520253910411174999==--
