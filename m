From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5645: Constify ACPI device ids
Date: Wed, 6 Jan 2016 10:38:08 +0000
Message-ID: <20160106103808.GU6588@sirena.org.uk>
References: <1451773436-25518-1-git-send-email-minipli@googlemail.com>
 <20160104013210.GI16023@sirena.org.uk>
 <CA+rthh-LWKOh+JrKVZU3kZnxnkFWXz+tu-P6NMUcYhPy=xyWWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8591948708527522585=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E96A9260417
 for <alsa-devel@alsa-project.org>; Wed,  6 Jan 2016 11:38:14 +0100 (CET)
In-Reply-To: <CA+rthh-LWKOh+JrKVZU3kZnxnkFWXz+tu-P6NMUcYhPy=xyWWg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mathias Krause <minipli@googlemail.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, John Lin <john.lin@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============8591948708527522585==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZsW/usBbx2ObC9TW"
Content-Disposition: inline


--ZsW/usBbx2ObC9TW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 06, 2016 at 09:01:28AM +0100, Mathias Krause wrote:
> On 4 January 2016 at 02:32, Mark Brown <broonie@kernel.org> wrote:

> > Please don't mix multiple unrelated changes in a single patch,
> > especially when there's no content overlap at all :(

> I've seen you've applied the patch nonetheless. So I guess you don't
> want me to split the patch any more?

No need to split this patch but in future don't do this.

--ZsW/usBbx2ObC9TW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWjO6PAAoJECTWi3JdVIfQeNEH/i89nMKuGLq98gU9f9R/pvF7
LZVlrUjR+SRUx8Vkx9+OVYLJclTq1aPeXvVjDqqapx8M+3/iXR4XxmWbsLchO4Dv
G67Ne3p+yKqWrcp8v9o3aPxKb+dDWXM8/NNyepwzZejQXdDweSfl6bCJceHUwLBJ
mHya7u1zh2BeSxeYMYB1Gaox7P2mKJKyV7IQc/DypaCPaAeNWG/xweC3MqJlx2N6
BDUpWLRbajJBPK/DYIBvcfIFqlrmIIxAkMEzg75sTioDI+Tl0S/tHoqxZ60BuDKr
ZcOjpxK0/D6q5jmH4KSBUq6qHTfg91JuBYkdT/pz929bqYGqRjccb/LOrN2kU/8=
=9OOR
-----END PGP SIGNATURE-----

--ZsW/usBbx2ObC9TW--

--===============8591948708527522585==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8591948708527522585==--
