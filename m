From: Frank Becker <fb@alien8.de>
Subject: Re: commit 7b2bfdb broke sound card detection on my
	Lenovo T400s
Date: Tue, 7 Sep 2010 11:02:20 +0200
Message-ID: <20100907090220.GA3204__24943.822323303$1283934076$gmane$org@alien8.de>
References: <20100906170421.GA2957@alien8.de>
	<20100906224548.GA27279@taprogge.org>
	<s5hlj7ew0ph.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2181130410530664068=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <s5hlj7ew0ph.wl%tiwai@suse.de>
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
Cc: bp@alien8.de, Jens Taprogge <jens.taprogge@taprogge.org>, linux-kernel@vger.kernel.org, alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============2181130410530664068==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Takashi Iwai [2010-09-07, 08:17 +0200]:
> At Tue, 7 Sep 2010 00:45:48 +0200,
> Jens Taprogge wrote:
> >=20
> > On Mon, Sep 06, 2010 at 07:04:21PM +0200, Frank Becker wrote:

Hi,

> Also, it'd be helpful if alsa-info.sh output is given.
> Jens, Frank, could you guys run it with --no-upload option and attach
> the output for comparison?
Sorry, I wasn't aware of this fine tool.

Hope, it's OK to upload it as well. Don't want to fill up everyones mboxes
again

2.6.32: http://www.alsa-project.org/db/?f=3Df985e74bdda393213a29c6243012a7a=
8ea1dfe1f
2.6.35-broken: http://www.alsa-project.org/db/?f=3D827e4ef1a0d6c726a09fc580=
1853aa2ba58225ed
2.6.35-ideapad: http://www.alsa-project.org/db/?f=3D01e6a47003948f33aeb8ff1=
32b64d4bc4ecc73b8

Bye,

Frank

--=20
Frank Becker <fb@alien8.de> (jabber|mail) | http://twitter.com/41i3n8
GnuPG: 0xADC29ECD | F01B 5E9C 1D09 981B 5B40 50D3 C80F 7459 ADC2 9ECD
SILC-Net: a8 | Home: http://www.alien8.de | <<</>> http://www.c3d2.de
"> Freedom is just chaos, with better lighting. <"  Alan Dean  Foster

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkyF/5cACgkQyA90Wa3Cns2svACfTQXBbA2aJKULQ+m3/PkctAp0
hssAnj1XuVCDfZjDRO/nWaHhbrXmqqMS
=uCBd
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
--
To unsubscribe from this list: send the line "unsubscribe alsa-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


--===============2181130410530664068==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2181130410530664068==--
