From: Mark Brown <broonie@kernel.org>
Subject: Re: [asoc:topic/intel 53/55]
 sound/soc/codecs/hdac_hdmi.c:1028:5: warning: passing argument 4 of
 'snd_hdac_acomp_get_eld' from incompatible pointer type
Date: Mon, 26 Sep 2016 09:02:17 -0700
Message-ID: <20160926160217.cxlnzgs4o34pxbll@sirena.org.uk>
References: <201609251657.PliXFIzK%fengguang.wu@intel.com>
 <20160926083843.GA21213@kpjeeja-desk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3446038561931069981=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B890C2606F7
 for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2016 18:02:32 +0200 (CEST)
In-Reply-To: <20160926083843.GA21213@kpjeeja-desk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>
Cc: Sandeep Tayal <sandeepx.tayal@intel.com>, kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3446038561931069981==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sjehjytospoulpgo"
Content-Disposition: inline


--sjehjytospoulpgo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 26, 2016 at 02:09:51PM +0530, Jeeja KP wrote:

> Can this patch be reverted or staged until the i915 API changes are
> merged?

I'll revert.

> Sorry I should have explicitly mention this in cover letter

No problem.

--sjehjytospoulpgo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJX6UaJAAoJECTWi3JdVIfQrEYH/RFbcYrjpawzw05K3pf0xffw
TH6LvsNBttg8Vuvrg1KQPaKcVnNFiXdW15P8X47IbuxXlDPSX4NYA458cWBcq5gA
jnvOYd+tdWMyCUfYG4mCRI36uQxWTeNezHWNHMpruiPO6Zk3NL9I+tJlBXPWWOjf
opoOWC2ed54F+4RlGtvUrTjulFzcKQoB7NRoT+3DivH9HGH2sZJ/PzXRJhnFZbNK
ugyjSm4vqnW0HBgcJY0i+Ohdz3l3ieXeSIwgGIVu8cO00MYJuqhu6plwncIOej6R
4ckQWBsz7GdeYl1ZG0NdxOgggCx2Sprk02npyVUtYOW3o+dfuBZ+CEd2v7sN8Dw=
=Um2h
-----END PGP SIGNATURE-----

--sjehjytospoulpgo--

--===============3446038561931069981==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3446038561931069981==--
