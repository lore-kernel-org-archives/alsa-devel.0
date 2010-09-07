From: Frank Becker <fb@alien8.de>
Subject: Re: commit 7b2bfdb broke sound card detection on my Lenovo T400s
Date: Tue, 7 Sep 2010 22:30:46 +0200
Message-ID: <20100907203046.GA3047@alien8.de>
References: <20100906170421.GA2957@alien8.de>
 <20100906224548.GA27279@taprogge.org>
 <s5hlj7ew0ph.wl%tiwai@suse.de>
 <20100907090220.GA3204@alien8.de>
 <s5h7hixap1c.wl%tiwai@suse.de>
 <20100907094041.GA2815@alien8.de>
 <s5h1v95anxg.wl%tiwai@suse.de>
 <20100907095300.GB2815@alien8.de>
 <s5hy6bd98bq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hy6bd98bq.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jens Taprogge <jens.taprogge@taprogge.org>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, bp@alien8.de
List-Id: alsa-devel@alsa-project.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Takashi Iwai [2010-09-07, 12:06 +0200]:
> At Tue, 7 Sep 2010 11:53:00 +0200,
> Frank Becker wrote:

Hi,

> OK, fixed now in sound git tree.
It's my pleasure to confirm that commit 4d15564 of this repo did resolve
the reported issue on my T400s. Awesome! Took just one day.

It would be appreciated if someone having access to a docking station would
test if the external microphone works as well.

Thank you a lot Takashi!

    Frank

--=20
Frank Becker <fb@alien8.de> (jabber|mail) | http://twitter.com/41i3n8
GnuPG: 0xADC29ECD | F01B 5E9C 1D09 981B 5B40 50D3 C80F 7459 ADC2 9ECD
SILC-Net: a8 | Home: http://www.alien8.de | <<</>> http://www.c3d2.de
"> Freedom is just chaos, with better lighting. <"  Alan Dean  Foster

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkyGoOoACgkQyA90Wa3Cns0VmACeLy6twCiU4KNzR5+0RDVX1yqI
uQoAn2X39u9eDlFlH8dERS+AsstMHO/7
=OAQF
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
