From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: compress: Add suport for DPCM
 into compressed audio
Date: Thu, 16 Jan 2014 18:16:31 +0000
Message-ID: <20140116181631.GM17314@sirena.org.uk>
References: <1389804717-5985-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1389804717-5985-2-git-send-email-liam.r.girdwood@linux.intel.com>
 <20140116180115.GK17314@sirena.org.uk>
 <1389895928.2298.77.camel@loki>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4656795896778547907=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F165261A11
 for <alsa-devel@alsa-project.org>; Thu, 16 Jan 2014 19:16:40 +0100 (CET)
In-Reply-To: <1389895928.2298.77.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4656795896778547907==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Z/kiM2A+9acXa48/"
Content-Disposition: inline


--Z/kiM2A+9acXa48/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 16, 2014 at 06:12:08PM +0000, Liam Girdwood wrote:
> On Thu, 2014-01-16 at 18:01 +0000, Mark Brown wrote:

> > Applied both, thanks.

> I have a fix for this, I guess you want it incrementally ?

Yeah, or I can replace if you like - they're on a branch by themselves
so it's easy to update and start over.  Please carry Vinod's ack if
you resend or I'll forget.

--Z/kiM2A+9acXa48/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS2CH8AAoJELSic+t+oim9tycP/2Q5zaJPiXGwGsFuzkKAEX+Q
8rU+3JCd/Ycz00izwp5gKi+bvF1ZDlEdSmVuc34hYDF36VkYE2de4WY/85XJ8skK
K66+SgNzWG5wHTXDe4oz9Y0PTRalyapJQwV4CjOqIcrCY0iIJICO4jNIAT68I2x2
88zVOlAkhCmgTJ2P45/NRi7cyjQRGzg10N4rGc2VfCpgIVAT3LiW0NKUKPvGSyHu
9j3rgYFGEtg3N+9cVlxW+scykGpOWHrXqdBaxJxgrciGakcmVlVDRwdzm5kJTX+N
imd7sQqBL851UlRje46mMXZBf8dvOcU83HOWGC/PaNnEpJ6hTLzdB24T7MwGvfYv
d9J4naj3YinVrGdNnTTAoLb9PNOwK5DgHRx1FX/E8REEC7ZSZNUDLRzCN0n+RGAB
Z8pWoYyy0ArOWo1osvEziP3e3yM6SsCR3DRYvpcDKJq39McimZoZOOvhCHvy1joe
7kvyE4ovaexQ8UbPIC6fo9W3Qpvu770ttEHN6kkSet5+OMLLnDP1da38pKXv0Dko
RuTvdAcnsAfXktRNMTmekB+g/osvXiiB+ZEzWwc8/x3L1HfJnW4OEq9Qeu+CZC6V
eZkfthq3gq+NhQSGMvFUftxsJRf2ogNkwyCwrEgmRf18buiVrOH08UU+japrEDiW
sAVsUDaJM4L8TqlfS+mL
=h2/t
-----END PGP SIGNATURE-----

--Z/kiM2A+9acXa48/--

--===============4656795896778547907==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4656795896778547907==--
