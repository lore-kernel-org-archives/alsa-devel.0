From: Tony Vroon <tony@linx.net>
Subject: Re: Regarding Sound on Acer Aspire 6935G
Date: Mon, 22 Jun 2009 23:18:17 +0100
Message-ID: <1245709097.441.7.camel@localhost>
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
	<1245707939.441.5.camel@localhost>  <s5hfxdrex0w.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1985603189878389794=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gold.linx.net (gold.linx.net [195.66.232.40])
	by alsa0.perex.cz (Postfix) with ESMTP id ECC1E24692
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Jun 2009 00:18:18 +0200 (CEST)
In-Reply-To: <s5hfxdrex0w.wl%tiwai@suse.de>
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
Cc: Karthik Ramgopal <applefreakpeeps@gmail.com>, ALSA development ML <alsa-devel@alsa-project.org>, Emilio =?ISO-8859-1?Q?L=F3pez?= <buhitoescolar@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1985603189878389794==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-Assua3GYS5Omfjlj81Lw"


--=-Assua3GYS5Omfjlj81Lw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2009-06-23 at 00:14 +0200, Takashi Iwai wrote:
> Maybe just a missing initialization of NID 0x12?

It quite likely is, I got tired of 4930g not working right and cleared
it all out. I've been granted remote access to the 6530g in question,
and hope to submit a patch to you in the next 20 minutes.
Sorry for missing that.

> Takashi

Regards,
Tony V.

--=-Assua3GYS5Omfjlj81Lw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEABECAAYFAkpAAykACgkQp5vW4rUFj5rYwACdEneNbhojNNteJmfe8yB+FM+B
xEwAoKpYfcsB7LISlIZnUrVpGwmywP1n
=stRG
-----END PGP SIGNATURE-----

--=-Assua3GYS5Omfjlj81Lw--


--===============1985603189878389794==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1985603189878389794==--
