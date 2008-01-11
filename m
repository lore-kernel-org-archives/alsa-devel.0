From: Pierre Ossman <drzeus@drzeus.cx>
Subject: Re: [alsa-devel] PNP_DRIVER_RES_DISABLE breaks swsusp at least with
 snd_cs4236
Date: Fri, 11 Jan 2008 08:01:41 +0100
Message-ID: <20080111080141.75aaad5f@poseidon.drzeus.cx>
References: <200801092343.48726.linux@rainbow-software.org>
	<47857A82.4050005@keyaccess.nl>
	<Pine.LNX.4.61.0801100849290.30240@tm8103.perex-int.cz>
	<4786C40B.8050005@keyaccess.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=PGP-SHA1; boundary="=_hera.drzeus.cx-13687-1200034907-0001-2"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759852AbYAKHCE@vger.kernel.org>
In-Reply-To: <4786C40B.8050005@keyaccess.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Jaroslav Kysela <perex@perex.cz>, ALSA development <alsa-devel@alsa-project.org>, Ondrej Zary <linux@rainbow-software.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Andrew Morton <akpm@osdl.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hera.drzeus.cx-13687-1200034907-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 11 Jan 2008 02:19:07 +0100
Rene Herman <rene.herman@keyaccess.nl> wrote:

>=20
> I see a PnP resume _consists_ of setting the resources so I can see the t=
est=20
> implementation wise, but yes, conceptually it seems this test shouldn't b=
e=20
> present. So just like the attached then?
>=20
> Pierre, what was the idea here? Added the other SOBs to the CC as well...
>=20

You assume there was an idea? ;)

I don't remember why things were done the way they were. And I can't find a=
ny clues in the correspondence around the issue. So your guess is as good a=
s mine.

Rgds
Pierre

--=_hera.drzeus.cx-13687-1200034907-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)

iEYEARECAAYFAkeHFFYACgkQ7b8eESbyJLgVNQCePY6usjQfRnWUqynmf9bqgiVo
EWAAoN3lc0L3CCUxDMAlIdPcd8yya2x+
=hBmM
-----END PGP SIGNATURE-----

--=_hera.drzeus.cx-13687-1200034907-0001-2--
