From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 0/7] ASoC: Intel: sst - add the
	merrifield IPC driver
Date: Fri, 17 Oct 2014 14:15:39 +0200
Message-ID: <20141017121539.GI1820@sirena.org.uk>
References: <1413469819-18775-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0054950817549438114=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C86326063B
 for <alsa-devel@alsa-project.org>; Fri, 17 Oct 2014 14:15:59 +0200 (CEST)
In-Reply-To: <1413469819-18775-1-git-send-email-vinod.koul@intel.com>
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
Cc: alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0054950817549438114==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v2/QI0iRXglpx0hK"
Content-Disposition: inline


--v2/QI0iRXglpx0hK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 16, 2014 at 08:00:12PM +0530, Vinod Koul wrote:

> This path series adds the Merrifield IPC driver which is used to load and
> manage the DSP along with sending and receiving IPCs for PCM and compressed
> audio.

I had some concerns that I replied to the individual patches with but
they're all pretty minor so I've applied everything - please send
followup patches dealing with these things.

--v2/QI0iRXglpx0hK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUQQhqAAoJECTWi3JdVIfQ8oYH/1Iy2iOQ3MCEhEb0ST0lkNca
FjnxQhwRrCPkNoBzQm9z+p9ODriXc4GWYNEdAmp2zcXkSnHy8mVVvzsCGNj7O/rk
eV01A01i1m6yikSNyv7I63NZyfz8PPV8zRLgvrvGM5inYF9IapG+L1qmXbqQyTmC
8vWJzBzds1iI08q3ePFJZOleQeEhk+Dp/eWMIfzskP2rMiYlWJZ+mHZRI5Yx43NN
yZCnE9z/sBHJ3yoJGsjYxOEQD4tm6TTDEswLhmqOXqhclPWEtK8ZE9sjd/xb4idu
oSZfBXC1UBTt90GPswuPzSA9D1iIAF9vrAZXPmZyyG5ybySprhVVXzcushBBIJQ=
=1TtJ
-----END PGP SIGNATURE-----

--v2/QI0iRXglpx0hK--

--===============0054950817549438114==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0054950817549438114==--
