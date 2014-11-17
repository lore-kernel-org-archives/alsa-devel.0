From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5677: Modify the default value of
 the MX-8E[4] for ASRC function
Date: Mon, 17 Nov 2014 23:29:39 +0000
Message-ID: <20141117232939.GB22111@sirena.org.uk>
References: <1416190691-26634-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8281486842051580415=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 62F1F2605F8
 for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2014 00:29:57 +0100 (CET)
In-Reply-To: <1416190691-26634-1-git-send-email-oder_chiou@realtek.com>
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
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, benzh@google.com, anatol@google.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============8281486842051580415==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
Content-Disposition: inline


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 17, 2014 at 10:18:11AM +0800, Oder Chiou wrote:
> Modify the default value of the MX-8E[4] to 1 for ASRC function. It could
> prevent the pop noise with ASRC function.

Applied, thanks.

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUaoTiAAoJECTWi3JdVIfQlUcH+wTyrbN/weLFq5E/6UAO3+90
o2nAXCEjKY1lwed/4pWpYwR6uOHzTH9ksbc100xYvOi9WUO3Dj0z6Rs2+f5BsVMK
k+3uin48l0qrz9cP3O+zk16uwbO7MZXVW7fqFc+U8CTml1JCd3baI3iSuv326eZH
FHtQdPesGeQBbIr2fCF431pBvqPW1v9IAKgPw1c1ElVktY3/Yc99BLeZZmOvqo07
8Oa3HpOkc+tUX5aj2fFXwqlXsLiwJCgaKGUhcYT+bPZBfZEAfCpSkvncf0MJzu8K
FmvqWnLv6I2vu8JrRVydt/LF9MK9N7ncO38/tOHUsGI7AFpHOqJpJKqcitIDEx0=
=FoiH
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--

--===============8281486842051580415==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8281486842051580415==--
