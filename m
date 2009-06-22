From: Tony Vroon <tony@linx.net>
Subject: Re: Regarding Sound on Acer Aspire 6935G
Date: Mon, 22 Jun 2009 22:58:59 +0100
Message-ID: <1245707939.441.5.camel@localhost>
References: <4b8c423b0905152051w7443e1b4u4080514a560fbb6c@mail.gmail.com>
	<d54969c50906131915x22c8f30el46ee51faf2fafe20@mail.gmail.com>
	<d54969c50906201723k66b7965and680ffcc798e61de@mail.gmail.com>
	<s5h63eq9cxp.wl%tiwai@suse.de>
	<d54969c50906211501l7c6ae730l1082f8ed3894d196@mail.gmail.com>
	<1245622318.21943.0.camel@localhost>
	<d54969c50906211624w1b701a92xbe1e396356c72a7c@mail.gmail.com>
	<1245628845.13319.10.camel@localhost>
	<d54969c50906221044x1f8070b0s1fe802f08c63e7@mail.gmail.com>
	<s5h3a9sm8oa.wl%tiwai@suse.de>
	<d54969c50906221451o6e92044cj3da24df67e55268b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0226835500096590428=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gold.linx.net (gold.linx.net [195.66.232.40])
	by alsa0.perex.cz (Postfix) with ESMTP id D09582468D
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Jun 2009 23:59:01 +0200 (CEST)
In-Reply-To: <d54969c50906221451o6e92044cj3da24df67e55268b@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Emilio =?ISO-8859-1?Q?L=F3pez?= <buhitoescolar@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Karthik Ramgopal <applefreakpeeps@gmail.com>, ALSA development ML <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============0226835500096590428==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-h87Kb7UM0fQEsZ8wnipn"


--=-h87Kb7UM0fQEsZ8wnipn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2009-06-22 at 18:51 -0300, Emilio L=C3=B3pez wrote:
> the internal microphone does not work.

That's the only problem I had left on that laptop. If anyone knows the
magic verb to wake that up I'm happy to oblige.
I know the ADCs are already reversed, so we are using the correct one
for capture (if you run codecgraph you'll see the internal mic is only
connected to the "bottom" aka secondary ADC)

I won't have my hands on that 6530G laptop again for a couple of weeks,
so if testing on actual hardware is to be done, I hope we can count on
Emilio.
>=20
> The file Tony requested, just in case, again:
> http://files.getdropbox.com/u/553461/codec0new.txt

Takashi, I would say that the 6530G model is a perfect match for this
layout.

> Emilio

Regards,
Tony V.

--=-h87Kb7UM0fQEsZ8wnipn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEABECAAYFAko//qMACgkQp5vW4rUFj5o08gCfSNistmJP9vIhmjan9vDV8kuA
hhYAnjwUjNS5eb5cy/APXy8yGfi1n7ud
=9KPD
-----END PGP SIGNATURE-----

--=-h87Kb7UM0fQEsZ8wnipn--


--===============0226835500096590428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0226835500096590428==--
