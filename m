From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: add api to retrieve dmic array info
 from coreboot nhlt
Date: Mon, 23 May 2016 18:01:05 +0100
Message-ID: <20160523170105.GZ8206@sirena.org.uk>
References: <ac23a9ba3795ed50bea2d88dc90b419238ef1542.1463673471.git.yong.zhi@intel.com>
 <20160519160136.GE8206@sirena.org.uk>
 <C193D76D23A22742993887E6D207B54D03535BCA@ORSMSX106.amr.corp.intel.com>
 <20160523054733.GI2735@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0184004525022321109=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FDCF26043A
 for <alsa-devel@alsa-project.org>; Mon, 23 May 2016 19:01:11 +0200 (CEST)
In-Reply-To: <20160523054733.GI2735@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Sripathi,
 Srinivas" <srinivas.sripathi@intel.com>, "Fang,
 Yang A" <yang.a.fang@intel.com>, "M R,
 Sathya Prakash" <sathya.prakash.m.r@intel.com>, "Kp,
 Jeeja" <jeeja.kp@intel.com>, "Patel, Vedang" <vedang.patel@intel.com>, "Zhi,
 Yong" <yong.zhi@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============0184004525022321109==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mu4zWe6QekgCAJVd"
Content-Disposition: inline


--mu4zWe6QekgCAJVd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 23, 2016 at 11:17:33AM +0530, Vinod Koul wrote:

> > [YZ], Hi, Mark, the only function change is at line 143 below, found another product that also needs to get DMIC config info yesterday.

> The patches are doing two different things, so they should have different
> titles mentioning the work the patch is doing.

> Also you should consider posting them as a series.

> Please update this and post the updated v2.

Definitely, please - I misunderstood the above reply and discarded the
original patch.

--mu4zWe6QekgCAJVd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXQzdQAAoJECTWi3JdVIfQEFsH/0ui3j3L7DTSd2W117xtSsJO
mL6w8Nilskc+9jaTT/NIE64KDamYWqtFA++m0CNQI2ci57xIAO7E7c0jIpN5nZKl
M8xmyjRCUp+sO1PhuMIN+B84sqETgxoYmySzvtTFPDHAfv9K6GAHqXC6PBAxE/KE
24dB6ZWY+Gb+EwD1SA7G0x1h8v/ipg6kHCPQL3KtknI0skbVo8j8VnEShL8+f97H
iDzVbpol/QydmaJSu7CzzDnUGzM1RuuBtgy0iwks7R4hvX5Hvnn1l6W56zPjcur6
+uP8chDDDio5Hy3n7bYauNDItvfs/hwEcDIuPbGEpGKcn71wmHlngmXZDg+tYNI=
=JBKR
-----END PGP SIGNATURE-----

--mu4zWe6QekgCAJVd--

--===============0184004525022321109==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0184004525022321109==--
