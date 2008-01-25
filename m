From: Martin Egge <mailinglists@martin.egge.info>
Subject: Re: Digital-Out (Toslink) on HDA-Intal (AD1986A)?
Date: Fri, 25 Jan 2008 16:27:28 +0100
Message-ID: <200801251627.29104.mailinglists@martin.egge.info>
References: <200801222121.05757.mailinglists@martin.egge.info>
	<200801251558.02569.mailinglists@martin.egge.info>
	<s5habmuj5w6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7739142592068306412=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186])
	by alsa0.perex.cz (Postfix) with ESMTP id 5B6CC1038C0
	for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2008 16:27:35 +0100 (CET)
In-Reply-To: <s5habmuj5w6.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============7739142592068306412==
Content-Type: multipart/signed;
  boundary="nextPart2781799.lHcVDiJLVh";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2781799.lHcVDiJLVh
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

Am Freitag, 25. Januar 2008 schrieb Takashi Iwai:
> Is it an optical SPDIF out shared with the headphone jack?

Yes it is.

> Then you can see the red light when the SPDIF is turned on. Make sure that
> you turned on "IEC958 Playback Switch".

The red light is never turned on.

> > P.S.: There is also the not so demanding problem that the internal mic
> > has never been working
>
> Details please?

There are two sliders and switches for mics:
  1. Mic
  2. Internal Mic
There is on MicBoost slider.

An external microphone (connect to the pink microphone jack) works complete=
ly=20
and can be controlled via the Mic slider and switch. The internal mic is=20
unusable, I can neither hear (playback) nor capture it. The Intenal Mic=20
slider and switch don't change anything.


Regards
Martin

--nextPart2781799.lHcVDiJLVh
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHmf/hVG/GfU56d2wRAjyCAJ4rw76gtSyLy8DceG+4lougCi3RogCfQkHr
7tnWnc/XU4WSeSAWaGy9s/w=
=zLj+
-----END PGP SIGNATURE-----

--nextPart2781799.lHcVDiJLVh--

--===============7739142592068306412==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============7739142592068306412==--
