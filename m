From: Mark Brown <broonie@kernel.org>
Subject: Re: ASoC fixes for v3.13
Date: Thu, 16 Jan 2014 14:09:05 +0000
Message-ID: <20140116140905.GG17314@sirena.org.uk>
References: <20140116123440.GQ15567@sirena.org.uk>
 <s5hy52grt7s.wl%tiwai@suse.de>
 <20140116133344.GS15567@sirena.org.uk>
 <s5hsisorpik.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7449119714565200964=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BEDBA2616F3
 for <alsa-devel@alsa-project.org>; Thu, 16 Jan 2014 15:09:10 +0100 (CET)
In-Reply-To: <s5hsisorpik.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7449119714565200964==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HKEL+t8MFpg/ASTE"
Content-Disposition: inline


--HKEL+t8MFpg/ASTE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 16, 2014 at 03:05:07PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > I can't remember when exactly the problems were introduced but given
> > that the driver itself only came in with v3.12...

> Then it'd need Cc to stable?

IIRC it was OK in v3.12 and broken in v3.13.  Could be wrong though, but
we didn't do anything interesting that'd be likely to break it in v3.12
that I remember.

--HKEL+t8MFpg/ASTE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS1+f+AAoJELSic+t+oim9nJgQAJ32bcrVxDT+5kHDK1xvx4wB
aLhdD5DyN8jmwAmThIYioMkOUN4hi9mXJRog/TmIUhIuEbt2WO5vpM4WlWHrjaxS
hR/rLsEK/IFjkRkWQ4eU66MTir7MRH/bMAVdYoCmhLSDMej74aWfs0iF6F5oSp4q
Rwn+t4ik7lDuByrYPp5+gUTdjtjeAABmuJjT4AOfpj0CPgt9Ps5aDXZ5+t8f70Cw
ZiUUSzFim8VJPn/C+JyYhIcVa4K0J2x/RKMAh1TGjiMoyN4wAXlKan5Rnx09z+qh
L0GsBlYx64tkjg1n9l9i5NAI2lBcxKpAwp0isa4TO+p0HB2+BWcEDHKbLWxoxGFj
sfF76c9qIyIATMyt/rO/xEIeyFIyAKwvTlZIt6Z8SnC1lNBpdijGMNyTPHdCte03
R3QqmKW7532tZ4pPY0Hd+0BI8o4C1+3/dO86XjiowbsB89LEqzxvldpUd/6ZB5S2
LgEp0wFw0PnQonbt8rnSoRtagwXvSGY7BK5ZvwjlVQIOFyhKxaYRirgw2Oe1lqQ4
u/PgCvO8yO/OixpMJsOs73hPn9ST5lIr/pDG+8IK49RM5+tAqafDzDJkr1TWq1hM
P70lQe/z71LLiMrMyVxLpPhHKRtSEa8lq5lCSmSEGTp22ZH/X9MdnVmTwFcjK9vm
2Y/kpOktiOikit9lvSYi
=FhQU
-----END PGP SIGNATURE-----

--HKEL+t8MFpg/ASTE--

--===============7449119714565200964==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7449119714565200964==--
