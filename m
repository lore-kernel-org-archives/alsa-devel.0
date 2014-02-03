From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: arizona: Improve ultrasonic
	frequency response
Date: Mon, 3 Feb 2014 18:43:48 +0000
Message-ID: <20140203184348.GN22609@sirena.org.uk>
References: <1391183234-13943-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1391183234-13943-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20140203083730.GB13529@lee--X1>
 <20140203161014.GE22609@sirena.org.uk>
 <20140203164846.GX13529@lee--X1>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3747517652592404440=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C41E62610A6
 for <alsa-devel@alsa-project.org>; Mon,  3 Feb 2014 19:43:59 +0100 (CET)
In-Reply-To: <20140203164846.GX13529@lee--X1>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, sameo@linux.intel.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3747517652592404440==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8Nc+Tfv1AudcG31Y"
Content-Disposition: inline


--8Nc+Tfv1AudcG31Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 03, 2014 at 04:48:46PM +0000, Lee Jones wrote:
> > > For the MFD change:
> > >   Acked-by: Lee Jones <lee.jones@linaro.org>

> > There's no actual dependency between the two patches AFAICT so I expect
> > the register patch can go straight into the MFD tree?

> That's fine by me. Are you okay with the patch? Can I apply your Ack?

It looked fine to me - just undocumented numbers!  Feel free to add an
ack from me if you like.

--8Nc+Tfv1AudcG31Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS7+NhAAoJELSic+t+oim9OJ4P/2tV1NNDoaJT4PufSBF4+cDD
yoOZXuJvxHHuy9z/vvlyVpEJM3H7KhdMag315w8T6P8x2Q8+nizeoBMx/O7WHoD3
nT0RL4SZOZDOyG6Hyc++ekUhchdgbSOTPhCyo1DB8w3EoEhTSlVYBmkDtI5aMOMq
Nw9wLm/h5qqw3H9ZL1DFj1rYZKf6L1p52y0uQFOUch8TuK0EjUXhBnwoMjPEWIHf
Cy+gre/vdsG8ALHUvvMUYjjilXh4An25QI8HsDdFDjQl5SpV58aeIhTC7BXeJf6k
ZUsUPCvm6lrN/LXBYAsmCNOhm2sfPzb6wfDM+aC1BZzjapZMfrzAC3pvSpH1fDQ+
YRUS3IT7CggNC0Mx0eUKXyBtaTx0J4zOB0zcckAUZRc96AWtyWGJ6FqqtRMngfvB
CU1sKrXdwsCVAtO8PbrAvemqJeUpJb5/1hTBDBJCQWTmPqWnpQhpj5fPGlamigQu
+PKK66nXbnaAjUS+szINXhlPoulOSWAArpMGc6NLy/0sD5NGXwoL2oLXdf0XnhJ9
9ibaO5izu64vT2iklD51L31uFqJsdHM+gBPB+VnqeXSltvpVWXpo8bu3F3ZGTcrJ
2RcZr9YDqultfoYwjK4TsDZYUwyG30gql1GOQj/oUyElpFM5sevxZfCoQEO8lDNW
ZXVXQe0/nDNXBTkJsiPE
=Oax+
-----END PGP SIGNATURE-----

--8Nc+Tfv1AudcG31Y--

--===============3747517652592404440==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3747517652592404440==--
