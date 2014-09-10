From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: mmp-pcm: add NO_PERIOD_WAKEUP
	for PCM INFO
Date: Wed, 10 Sep 2014 10:41:35 +0100
Message-ID: <20140910094135.GN2601@sirena.org.uk>
References: <1410338449-13961-1-git-send-email-zhouqiao@marvell.com>
 <1410338449-13961-2-git-send-email-zhouqiao@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1983910493536036268=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 43C31265119
 for <alsa-devel@alsa-project.org>; Wed, 10 Sep 2014 11:42:08 +0200 (CEST)
In-Reply-To: <1410338449-13961-2-git-send-email-zhouqiao@marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Qiao Zhou <zhouqiao@marvell.com>
Cc: alsa-devel@alsa-project.org, eric.y.miao@gmail.com, vinod.koul@intel.com, lgirdwood@gmail.com, haojian.zhuang@gmail.com, tiwai@suse.de, zhangfei.gao@gmail.com, dmaengine@vger.kernel.org, linux@arm.linux.org.uk, dan.j.williams@intel.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============1983910493536036268==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dLENbN/5wCAsF6b/"
Content-Disposition: inline


--dLENbN/5wCAsF6b/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 10, 2014 at 04:40:49PM +0800, Qiao Zhou wrote:
> add NO_PERIOD_WAKEUP to PCM INFO, which supports audio no IRQ mode

Acked-by: Mark Brown <broonie@linaro.org>

--dLENbN/5wCAsF6b/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUEBzOAAoJECTWi3JdVIfQzwEH/3RoI0oVMkM5xX+ro0b8j0uh
gLSKQ/ZMDQg54BT7Wk/6R8aM9TNodvLJvOXvWIDdDagqqnf/TH6rJA9fDQM/z8jV
8vwwW07JROe9BFdNknndEdHMKT2CVNX57cjAT//hhXZJ+hS8SG+mmFCSsKvh/MFq
fQWsUeK5/nVVq0NBKro+ozQI0rfIKcWeQhGvCqp/NLYrqRJdQUFp0sBdNhu2IdBa
eDr+slqP6V9F3QzKjoI9gTf/A3ibSX6foRrwliQ3yoaJW1v/0zyLZcfwoFd6822U
6k03+oRzwsYDINKCJZgDKjinX//bbrRa1fto13IUpdivKFzwGujlxRKj83bQeQk=
=Is81
-----END PGP SIGNATURE-----

--dLENbN/5wCAsF6b/--

--===============1983910493536036268==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1983910493536036268==--
