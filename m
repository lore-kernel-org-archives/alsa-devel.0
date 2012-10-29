From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Store codec capabilites in alsa
Date: Mon, 29 Oct 2012 17:07:32 +0000
Message-ID: <20121029170732.GF4511@opensource.wolfsonmicro.com>
References: <000001cdb31e$9a76a530$cf63ef90$@codeaurora.org>
 <508A69DB.7030009@ti.com> <508DD824.3040600@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2578892049404829696=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E5B89265332
 for <alsa-devel@alsa-project.org>; Mon, 29 Oct 2012 18:07:33 +0100 (CET)
In-Reply-To: <508DD824.3040600@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Patrick Lai <plai@codeaurora.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============2578892049404829696==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MZf7D3rAEoQgPanC"
Content-Disposition: inline


--MZf7D3rAEoQgPanC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Oct 28, 2012 at 06:13:08PM -0700, Patrick Lai wrote:

> I doubt that ASoC has mechanism for vendor's own CODEC driver to
> advertise CODEC specific information. However, we would like to
> check ahead of time before coming up with something on our own.

Unless you tell us something about what's being advertised it's very
hard to comment; it's often the case that things are just new rather
than device specific.

--MZf7D3rAEoQgPanC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQjrfLAAoJELSic+t+oim9n38P/0MdDX/ZFfKK9W02jbkucPoe
dhvlWYsUoa1CiAuVyRUZdhBLTbAet+9xKZtkArhKKYsTIzdi1yGGWStu4Ffbr7YP
z7jbvE7tpAJy43ym8RJjzoImQsyYr7RsugkNfY+trfAiRyKQPF9ApP5wq/OPOnV/
fchnv2+oAVgxUcuFGm/2G+uI+wwFw1cSZxHYyv3cOrtoOG7UfEwpY6Sh26eLDl9h
ooOzx+d8WXvS4VuNzYMeEcbIT/rDOkd6yI4xpqAcouURZOZZPnAmzUuAIFiZOiVK
DSqBybx8pLhYvDVrHkgPAPSHiWnephC17VywzB+TsAdMruOhouaIgu3/GagBxWyR
6LFIOrSE7lGNbt8Ui53pPDuMdS92p5e7ZB8j3fgr5V/IX3PzwBQjRmct0VYrn8YN
t5CYpXy/nQGTLG8KTZjd3wQ9zxc505KuhYyOLXfxhI5rKOOvqcI4fay+6HmBUA5J
+Mn3pVx6EK59ybJxTeWgbMjbtVChMEF91U0NIRmeZRACdpb0k91EpjrdGfCFXVk0
FC3rVVV4C0+hfGqKM+QMgKUNn/VePjx52OIEYPKW+5+G5H0Vp0ePF8Rzu5GKeSrF
b/e+eCt7kNGH+/D3j5LdIHefktP1QYOP1NVgX+HaVWescg47MrXsmiEaeWs3f/0W
+z4HA1tc3jvjY4zTDATp
=ixdl
-----END PGP SIGNATURE-----

--MZf7D3rAEoQgPanC--

--===============2578892049404829696==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2578892049404829696==--
