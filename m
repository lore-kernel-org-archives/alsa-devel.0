From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6/6] ASoC: rt5640: Change the setting
 method of idle_bias_off
Date: Fri, 28 Mar 2014 12:54:00 +0000
Message-ID: <20140328125400.GO30768@sirena.org.uk>
References: <1396009710-21324-1-git-send-email-oder_chiou@realtek.com>
 <1396009710-21324-6-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1543227685987108801=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C5AEE2654ED
 for <alsa-devel@alsa-project.org>; Fri, 28 Mar 2014 13:54:12 +0100 (CET)
In-Reply-To: <1396009710-21324-6-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: bardliao@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============1543227685987108801==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BVqADUpb46OwFRC+"
Content-Disposition: inline


--BVqADUpb46OwFRC+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 28, 2014 at 08:28:30PM +0800, Oder Chiou wrote:
> The patch moves the idle_bias_off setting to struct "soc_codec_dev_rt5640".

This doesn't seem to apply against current code, can you please check
and resend?

--BVqADUpb46OwFRC+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTNXDkAAoJELSic+t+oim9JJgP/iLVQixOkMVpfv1/SsGEjckW
Wo23xtvXI9gUxBmGP1NMPmpgmnH+vcDzhx2nSjG38bdvaSMN7paA9iShEA5Ieck9
BSabPJ7Vd40f2R8lBSIi38cUfDW5qprxnXYnbnBu9HVAs6aY/oY8BohA1ydxKV7T
/X7bd0GF9oT04JZKemSDEt/jET0IfiYHKTQreG0B3aT9xpVM1ibuY3CiO115AY3Y
aEoNWWN1rJzFf5efqpx+FfnmrCYtARcWd/8/FgZY4PufxxrayOf0O+FmiD/nz8wi
RRsKaDbK3sWiroV74Sv74Z56Pp9/xuQqbp5uXiUSttDnDVcrvmJnyEbTu7c7f6fw
lqlL8N2/aeSQBxXvFpWxoq+NNumnBTs7lHyxdL1wFMKsFKD9BELUFKYvjX0vkmF1
vdRpfgbgaEJmiFVWg94OvYc4JvRRw8NsIaTKjAxJKALjOoYMxlDwx0xTcPoOsCM2
xPMXX4K5WcltHITFwuNS8LUkRiHmh7depImNZqTwDNZSupgTg/2Mja0Du6pJ0Gvr
be8FOlrcJRnVMoR9+1iH4e68JGMmxN4KHBWXR+eUa9zwYT/NFKQblO3gAX74aaHi
4TmZ+mMY8x22JpiFJEs2X5/DAs8n0iMAOpAtoFXtFMQUh3LEB1yqIezhMgX41HSN
PwmxvLnKNb2Gr9/bFJVU
=l8KF
-----END PGP SIGNATURE-----

--BVqADUpb46OwFRC+--

--===============1543227685987108801==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1543227685987108801==--
