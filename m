From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tlv320aic31xx: Enable support for
	S24_LE format
Date: Thu, 4 Sep 2014 12:05:38 +0100
Message-ID: <20140904110538.GJ29327@sirena.org.uk>
References: <1409817581-29496-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6394209623086568729=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 32D2F260864
 for <alsa-devel@alsa-project.org>; Thu,  4 Sep 2014 13:05:54 +0200 (CEST)
In-Reply-To: <1409817581-29496-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, jsarha@ti.com
List-Id: alsa-devel@alsa-project.org


--===============6394209623086568729==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4cXE7lVpOAUQvDc2"
Content-Disposition: inline


--4cXE7lVpOAUQvDc2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 04, 2014 at 10:59:41AM +0300, Peter Ujfalusi wrote:
> S24_LE is the same on the bus as S24_3LE, which means the codec can support
> it.

Applied, thanks.

--4cXE7lVpOAUQvDc2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUCEd/AAoJELSic+t+oim9QlQP/1/PXGYP8gqhgisYbMGf17ai
biRRJz8G/7IDxlBoRCSOrSjgU+NMOW+HwUBWNHD0Urs6bBTSHPGLDoFnp19HzF/j
zNqdgSfULXN6sfc7S9XJj2YGegT5kpPoWOCH8TUsm6ykyxxMy2KOYY2iO1FyeHXK
FdPLwa5KpCd10tp2CY20HehjmdH7f6XXs2XHjw9GpX1IzaWxPmlmPmFMSee53V7w
ld9pXh5HDGbE9XH0swnwxDohseNXldtzkUBt6uomELcoH6rS8nUU2K+cHWIZgjxz
qJ0o7cWkEoxUNf8Moh3Fz0Mv5OTPOk9pYahFV/CtnqYBIfDXfptBinXJq1rjBiET
5sfWNfwRTQaacpabwiWk6TgzqK8sX0TbFjJ5FdksNvqOd8wg08B6y7ySK7w+myrD
fQJHvDEjvppzCZLzCqYA3hSPB7+NpFwXhFDMw95KRfCQ7ZwyrGKQSgFnE5jB8NIZ
h2XPpyi54tdvfDxB3e4pmvKC9F862+YQApvYJxgpqigX9NWAB90Is/qoRICerKuz
ySyAQsb5ITVnY6COert/coUIy1mzajzGxEKAsoTheTWk13nNKb+dg3VAtJduOLLi
tk5Q/T+Crape0UTER37P8FIcuaH43DRDXsXzeSdEPLe+i0m4EDQ8aCLBBRmN7SYG
w2igFdc8/CWlZYOggQxw
=Eaol
-----END PGP SIGNATURE-----

--4cXE7lVpOAUQvDc2--

--===============6394209623086568729==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6394209623086568729==--
