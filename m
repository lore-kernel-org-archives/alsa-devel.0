From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/8] ARM: at91: sama5d3: enable sound
	support
Date: Fri, 18 Apr 2014 21:38:17 +0100
Message-ID: <20140418203817.GA3479@sirena.org.uk>
References: <1395049541-28128-1-git-send-email-voice.shen@atmel.com>
 <53518C76.2020005@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7652774525258962109=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5FD762617AA
 for <alsa-devel@alsa-project.org>; Fri, 18 Apr 2014 22:38:48 +0200 (CEST)
In-Reply-To: <53518C76.2020005@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Bo Shen <voice.shen@atmel.com>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Boris BREZILLON <b.brezillon@overkiz.com>, Rob Landley <rob@landley.net>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============7652774525258962109==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 18, 2014 at 10:35:02PM +0200, Nicolas Ferre wrote:

> For this series I am a little bit puzzled: should I take the ASoC part
> of it? I see no acknowledgement from Mark and I also read some messages
> still discussing about CCF and wm8904 afterwards.

I've not seen these patches, judging by where this message went they
weren't sent to the address in MAINTAINERS (broonie@kernel.org) but to
my work address instead.

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTUY02AAoJELSic+t+oim9N08P/A9BcAybl0fKUBUjU66UeF9u
YL0gUySKSiF94XQw9CwD6Y4fX58BEDu6r1IdMXL0i8lAiopFwFffuLRyFN1viph1
+kc2drdyw5N6VJOXNuxAXE76yrOA4SLenfX8HL4lojjEITujXbneRzgHYkBLawym
3rZgIFjD9/tzYcSiO5Z2fJ6Bynr5I8DF648oDjeM8rSy+cjbHWGiYvreVCNObgfu
4R9O6XvOmn60vFon91PJmMzdIIjGkVZ3QMdeYgeQRDANaTSYizlmjZ/gUTnrHW1o
COSp+fpheFojVvojB3UUXmpPbaTg9s5LIrJS9eXVkONVYjkVy8T6mL3j/G6NHJaY
hvg1FGXwRq0XO5YQ0UTSw6idAskVwzgP+g3t4v083vSxlHa8xr7vtQvliL3ZTEpt
/pWvnIR8tPIuKyjc2lLfqRV7ccrmiqZKWe/IZ/fN6A/91p9smOz5Hi+fyHKFZTxS
WlL/kI0AyDSDaStvq4qPGtUVRTJDYXOmN2BD6GvE3+qeoBijvhJ+z0zjlHRECN9R
EJkOeAbTaMbOM+9ezRcwyS+YvVgwtV72eXOAy3Dag/uBMfHt4ufUDWbiaOHbFofN
ndYZbnxQESnYNXufLnHWnRwXQP/jrZzdeB7CkqlPrfaAT5oatlXmUN+FToqrEQpd
mtfLxnF1aCc5xpMbu8Pl
=t7N5
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--

--===============7652774525258962109==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7652774525258962109==--
