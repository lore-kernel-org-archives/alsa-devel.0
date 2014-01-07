From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 0/6] dma: Indicate residue granularity
 in dma_slave_caps
Date: Tue, 7 Jan 2014 17:36:18 +0000
Message-ID: <20140107173618.GE31886@sirena.org.uk>
References: <1389005162-5223-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7466806557851351583=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5CF412650F2
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2014 18:36:28 +0100 (CET)
In-Reply-To: <1389005162-5223-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============7466806557851351583==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pSFoCIXqj85S4zjL"
Content-Disposition: inline


--pSFoCIXqj85S4zjL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 06, 2014 at 11:45:56AM +0100, Lars-Peter Clausen wrote:
> Here is an updated version of the DMA residue granularity patchset. As
> discuessed last time it would be best if this could go through ASoC tree. It
> needs some feedback from the DMA folks first though.

I'm OK with the ASoC bits of this.

--pSFoCIXqj85S4zjL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzDsPAAoJELSic+t+oim9640P/jfjacf87mzuG/h8mu+Z2VdR
LIfZP0Pedp6O5S9Su1p/pvuc5X9ZivpVoIbnAHno8y279Y/bbOcupyJcZNe80GCh
H3rt1i9m3t9o6E2GFk70rjMQ46gjtlVqzFjPmwVfNNV6jH11/pqQbuaSI3D5PJIu
UrJ7dRpG9ZZxTPH09Wu4OGrByNHnCaNJFrUlhKgXW3BuHQACok0z4ObOTtjlMN1U
GTW+IV/I/Qexbz77hyXRhKeKH33AsHu1ZjSjs3ERwPBsPWT1vE8WibKiRP6fnCGb
ARW5hMuYWS2E6Ssi1DLP1r3HPzmh6OQVYmWc0pu6CDXuWZFNVfYiHwboybgHxUy4
L2xs3tDCjTmDYs05qMNKsEJAX3s+XznEU82Zjx3y6aZfboYnMEdZbGSnsINovOoP
j+jNvvUnrEn+8wv8BgzB2aCL3jrIwpSeeE38EUKTKgAJEvObUFLhCLu7iyXAR/zE
DZ0FyZ4Fbx4VPzjMYAqTPi9m1tWIenb3jlHiIM57H74q70Mx5VonPrzRH9nB18vO
IwAEY9ualW9OrwH+v5JOHm9VNk+XFjhRVQVGm+BTIEDbRKfvVsCezLawErP9rcZr
BJ0DIW/tuQzlheHegn+Ogfa3nbAUXkdnT6vBMhAAKDeTC2jTNwauwDSVaY7aYt/0
VpZ9XVb9guAKWN7e1KEv
=rmQ8
-----END PGP SIGNATURE-----

--pSFoCIXqj85S4zjL--

--===============7466806557851351583==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7466806557851351583==--
