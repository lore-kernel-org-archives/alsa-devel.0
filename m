From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Patch subject line (was: Re: [PATCH] asoc: bfin:
 use dev_err to print error log instead of dev_dbg)
Date: Thu, 21 Jun 2012 16:22:44 +0100
Message-ID: <20120621152244.GW4037@opensource.wolfsonmicro.com>
References: <1340301118-3800-1-git-send-email-scott.jiang.linux@gmail.com>
	<20120621100841.GP4037@opensource.wolfsonmicro.com>
	<CAHG8p1ACFtV0p8c8MQFSVDuBUX0y-CTw_uXXXyPaZmHRYXZfBw@mail.gmail.com>
	<20120621104743.GT4037@opensource.wolfsonmicro.com>
	<4FE334CA.7090205@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8801331918074304825=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5520D243F5
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Jun 2012 16:01:33 +0200 (CEST)
In-Reply-To: <4FE334CA.7090205@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8801331918074304825==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y974o0GblB/Ae/yP"
Content-Disposition: inline


--Y974o0GblB/Ae/yP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 21, 2012 at 04:50:50PM +0200, David Henningsson wrote:

> While we're at it, how about switching to the a/b/c style used by
> several other subsystems?

Looking at the git logs that's *really* unusual.

> I personally think "alsa/hda/realtek" looks much prettier than the
> shoutier "ALSA: HDA: Realtek:" thing we have today.

I have to say I really don't like this, especially the lowercasing of
everything.  It doesn't read like normal text, it reads like a filename.

--Y974o0GblB/Ae/yP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP4zwNAAoJEBus8iNuMP3dEJYP/iIMtugaxM4csPwFVOrHhUbr
smMJYN3RgONHIxDXvMk1BIhUdpySRNfh296aXUGrWIxCJEHEPX3SNhDV5h3nlaE0
Z4RPRYDeTlX+Nb8nAV2ZtufcL0/kLiYy1Ome/Hml1v5oGQx547Noej/IklpgfWcd
sPtB04gN0nQbQIN7z9vt2/4basCHkftRf+Eep73NetJaI24SqjBelQywrTdy5ZEy
7seRgWBlcUZm6kLVQ/OUzFUMifklDxT+b5pXpMFsl7eKkptT9m3kEyjS1SdZvVp2
3VJhWaiBhsC1XoI0KyKgJqoDYjadMkH4dafeIsWfO0cB2dqu5eoUBgeVahYheVYi
O6mXryCUUjQFL+P8kNl03tZ1ed5CcwTDGbaAIX9PDyZul+dSwc9pQdl4IIPw3M9y
ftnSy1n/w75TGWs1VOCI/Y/lljcwAvr1AoSSJbTodXpzb0HOM1pkz4Q6H09JZdON
qEJlXD0aP+iSYWK7+pHsXGJirfPtvMzTJGvzHeySuYTbpfTKifJtZhd2FDKk8/4T
12WTTFL5z4MQg9DT+s2M56v8eanfSOwpemrK+IWH5tlgPQD9KEEXnWfnQf08IYaH
ciWVSZjERCNqd8JbMN4rQ//kiKGCwjlXm8ZreUAp5KdZkd9HfDmUEk1KnajTDmtK
6cXxzgQEoBQbi0NKaBH+
=CHKT
-----END PGP SIGNATURE-----

--Y974o0GblB/Ae/yP--

--===============8801331918074304825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8801331918074304825==--
