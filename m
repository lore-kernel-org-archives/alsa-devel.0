From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/3] ASoC: Intel: Skylake: fix pointer
 scaling
Date: Mon, 22 Feb 2016 09:03:39 +0530
Message-ID: <20160222033339.GV19598@localhost>
References: <1455862354-6455-1-git-send-email-vinod.koul@intel.com>
 <20160219153345.GO18327@sirena.org.uk>
 <20160221030456.GO19598@localhost>
 <20160222031656.GS18327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3748558730646096072=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 632E426057F
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2016 04:29:46 +0100 (CET)
In-Reply-To: <20160222031656.GS18327@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, Alan <gnomes@lxorguk.ukuu.org.uk>, Alan Cox <alan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============3748558730646096072==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kswDJesP0akhmDn8"
Content-Disposition: inline


--kswDJesP0akhmDn8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 22, 2016 at 12:16:56PM +0900, Mark Brown wrote:
> On Sun, Feb 21, 2016 at 08:34:57AM +0530, Vinod Koul wrote:
> > On Sat, Feb 20, 2016 at 12:33:45AM +0900, Mark Brown wrote:
>=20
> > > Please ensure that the name and signoff match up.  I'm fairly sure th=
at
> > > both are for the same person here but it's not something I should have
> > > to think about and it is important to ensure that we have signoffs for
> > > everything.
>=20
> > Ah, sure will do. I think Alan wanted the SOB from his empyer ID. Alan =
how
> > do you want me to fix this :) I will send this
>=20
> Well, I already applied this one anyway since it was a fix (though I did
> skip patch 2).

So travelling again :)

Yes I noticed that, will send the patch 2 in a short while

--=20
~Vinod

--kswDJesP0akhmDn8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWyoGTAAoJEHwUBw8lI4NHyJMQAIFJG/1wi8btj+OIxgMMVZDH
ePx5VLOgjyq4d2CH40bdhcp0PnpHoz+rAGkHZHzjMrMitiH3I2DEcG2UMXQa4DvD
qtAXG62+93VGCrgHcfYrodbBGAJkBbe41cHScmdhGJF6KrEEkeuiQmoyfnj2ai1x
OpOp1JgEH8o6kL2q8T4C9NpXf4LnP1zb9m7PWv2VPHZUS+SbPiiSMVpALfWQkSvV
URS7KvMdOHtqIX8UoRx8koSCO79DHvhgQXnU5Opz8QXhs70a4OrR5stgI8tfqq0d
q1vx3fFaIhROgPd96FLZm08ixHcdSwM3UznWSPqqxG9SWwVkKwLJ3DIuLH8jWFzd
TVn03kL68RUKeL+6f3kFDtIjnCl09wACZ96uz1/Xp3sPh5t13DQOn+H0X3sITF4Q
W408vAew5y3FHpm5VSTyR7EOFBElt/ufIUmB2uOdb2kSv3xMLw6WFZwxreIx5Rdw
kybrm7Vdtp+Sgh/W4zJUNb0G1ytpGZebZ1eNPD0v0LgupsrXMfcyXKdV7I0sl0Zj
h8Z666UdverVnwyqUy/x+SYGR7Dr8QUU4+raXL+o0iwM8odSJ9OL+cHNziry3U5h
5DwCoMpGyfTxlBdwsO76QHkqEuUkfw0Hde3dM+HgnR0q1uLDfARahyVBg1+mq71G
7zvSd9Kny6HzzxJNrO5y
=U29S
-----END PGP SIGNATURE-----

--kswDJesP0akhmDn8--

--===============3748558730646096072==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3748558730646096072==--
