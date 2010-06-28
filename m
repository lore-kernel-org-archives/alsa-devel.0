From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH RFC 1/3] ASoC: uda1380: use callbacks
	instead of gpiolib
Date: Mon, 28 Jun 2010 17:05:51 +0300
Message-ID: <201006281705.57779.anarsoul@gmail.com>
References: <1277565285-11563-1-git-send-email-anarsoul@gmail.com>
	<201006281649.39572.anarsoul@gmail.com>
	<20100628135046.GB7403@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2580416048184604469=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id DE2EC244B2
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Jun 2010 16:06:07 +0200 (CEST)
Received: by fxm15 with SMTP id 15so1123095fxm.38
	for <alsa-devel@alsa-project.org>; Mon, 28 Jun 2010 07:06:07 -0700 (PDT)
In-Reply-To: <20100628135046.GB7403@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Philipp Zabel <philipp.zabel@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

--===============2580416048184604469==
Content-Type: multipart/signed;
  boundary="nextPart2560545.ECrqUgR1cs";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2560545.ECrqUgR1cs
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: base64

0JIg0YHQvtC+0LHRidC10L3QuNC4INC+0YIgMjgg0LjRjtC90Y8gMjAxMCAxNjo1MDo0NiDQsNCy
0YLQvtGAIE1hcmsgQnJvd24g0L3QsNC/0LjRgdCw0Ls6Cj4gU28gdGhpcyBpcyBhbiBvbi1ib2Fy
ZCBwb3dlciBzb3VyY2UgdGhhdCdzIGJlaW5nIGNvbnRyb2xsZWQgYnkgdGhlIEdQSU8KPiByYXRo
ZXIgdGhhbiBhbiBleHRlcm5hbCBkZXZpY2U/CgpUaGF0J3MganVzdCBncGlvLWJhc2VkIHBvd2Vy
IGNvbnRyb2wgZm9yIHVkYTEzODAgKG5vdCBzdXJlIGFib3V0IHNjaGVtYXRpY3MsIAppdCdzIG5v
dCBhdmFpbGFibGUpLiBTYW1lIGFwcHJvYWNoIGlzIHVzZWQgaW4gaDE5NDAgYW5kIG1hZ2ljaWFu
LgoKUmVnYXJkcwpWYXNpbHkK

--nextPart2560545.ECrqUgR1cs
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)

iEYEABECAAYFAkworEUACgkQRM6pQpltKE6ynACeNsc+/dc84uI/52RfKOmhpGFz
ETwAoNQ8HloajXJza9dJpfXb/+oI/uF/
=gdAK
-----END PGP SIGNATURE-----

--nextPart2560545.ECrqUgR1cs--

--===============2580416048184604469==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2580416048184604469==--
