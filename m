From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC 02/11] sound: ASoC: kirkwood: Remove
	unused drivers
Date: Mon, 26 May 2014 16:59:01 +0100
Message-ID: <20140526155901.GF22111@sirena.org.uk>
References: <1400163836-9831-1-git-send-email-andrew@lunn.ch>
 <1400163836-9831-5-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8728756319576190679=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E5AB0261A2F
 for <alsa-devel@alsa-project.org>; Mon, 26 May 2014 17:59:32 +0200 (CEST)
In-Reply-To: <1400163836-9831-5-git-send-email-andrew@lunn.ch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============8728756319576190679==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="j/teX0pIMV/okkLZ"
Content-Disposition: inline


--j/teX0pIMV/okkLZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 15, 2014 at 04:23:45PM +0200, Andrew Lunn wrote:
> Both kirkwood-openrd and kirkwood-t5325 drivers have been replaced
> with DT based simple-card equivelents.

Applied, thanks.  Please do try to use subject lines matching the style
for the subsystem.

--j/teX0pIMV/okkLZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTg2TCAAoJELSic+t+oim94ScP+gNCioGaZTEx74gDjP4IqrDE
QklxdrHqG/7b7TejWwUAAIUMej+0isSywkSevO5NVoRKSqFh1VnFJXBlDD2yUi4c
xM6WO+AdHmtBwJKktDbK7B4Iq+hz87m5S1foI3QORZ5VQtuu+qgAW8MirsMYpYYh
AAdrnCA/LmSqqa3dTRqUkjOej9RC+5aFVu+FOgF9TJ0rxpPd1vfforPPbgty7vR9
umwd8tOgI3xfx0xNTKxshLbHVusAmQM6RS65tD2wr5fNr7tf6jWpVaG1RPo595mA
z9GuKafL3nCajHiE0bTz3JrLpMqL/+TuOR9ekJlH7BZuv3VaBnEQUd9Qbodhu0l+
3kQ1UoIHslt6axtH3a7LLDApxgbeXEUjPMD8yIZxCar/cv2fReAihmN7/yY6lDgX
sg7h+t4B+bnKbwW5RXzR9KrDtnUSjPJ7/C+0nfZh9u5IbHZiEhYnYW7T3if66aKB
yCdN+2jxfCcGBPWwRfpRGjtpJ4Na832ZRYOYT08eH+R4q/F81T/0da3NW2akGItf
E04JoqY45xioLEmtokE+lDEOhkudVx86sc3xtGKH1ZRwUlk+HLSOQTNauGSSPTGE
PFqKmMHBKMalNLgy15EGJ09uxoBB30Ttz6WYQ/H28u3gCDjt5eETi5FN1JQ+715P
/GWECUnsaU1y7VKWN5ru
=LBL+
-----END PGP SIGNATURE-----

--j/teX0pIMV/okkLZ--

--===============8728756319576190679==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8728756319576190679==--
