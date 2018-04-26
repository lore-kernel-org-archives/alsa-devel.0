From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: add mt6351 codec driver
Date: Thu, 26 Apr 2018 12:40:11 +0100
Message-ID: <20180426114011.GC21755@sirena.org.uk>
References: <20180426024144.13974-1-kaichieh.chuang@mediatek.com>
 <1524711070.12322.23.camel@mtkswgap22>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4775134009062415266=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 497E82676AB
 for <alsa-devel@alsa-project.org>; Thu, 26 Apr 2018 13:40:18 +0200 (CEST)
In-Reply-To: <1524711070.12322.23.camel@mtkswgap22>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sean Wang <sean.wang@mediatek.com>
Cc: alsa-devel@alsa-project.org, wsd_upstream@mediatek.com, chipeng.chang@mediatek.com, garlic.tseng@mediatek.com, linux-mediatek@lists.infradead.org, KaiChieh Chuang <kaichieh.chuang@mediatek.com>
List-Id: alsa-devel@alsa-project.org


--===============4775134009062415266==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pAwQNkOnpTn9IO2O"
Content-Disposition: inline


--pAwQNkOnpTn9IO2O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 26, 2018 at 10:51:10AM +0800, Sean Wang wrote:
> On Thu, 2018-04-26 at 10:41 +0800, KaiChieh Chuang wrote:
> > This patch adds the MediaTek MT6351 codec driver.
> > MT6351 communicate with SoC through MediaTek PMIC wrapper.
> > MT6351 use MediaTek proprietary audio interface.

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--pAwQNkOnpTn9IO2O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrhupsACgkQJNaLcl1U
h9DKHQf/bdadkLrZtU8GGXgm5ZysCfwj3NT0G7NLk6kfX5KBiXas24HyNq0XGRYm
xieTL5mLIyeOkv04zmxhuHvUAwCU61L7ldNuiraFrfRhim5XLThIppLbFQ41+0eF
7JJbmAPq/Yxn9osxKFwCcmKDIHUiW3qAmLd/yxEoe4w74ElKV0+Owcqeewno28vZ
cPIq+9C6EftbYuKV+44CILuPAH67HFjTdCEK8czAhwNLB/oY6Fj+oYHSWu3B40ir
WGiro3oxE6JBRwgX8OjwedhWSr1TaEn0LsL/BBkhA4WUNBxI1eHCpgzctKBdmSUA
reexKo4QG6XSZXzGRXzET3RvfV6Mkw==
=1B+S
-----END PGP SIGNATURE-----

--pAwQNkOnpTn9IO2O--

--===============4775134009062415266==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4775134009062415266==--
