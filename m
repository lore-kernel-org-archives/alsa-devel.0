From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 067/102] ASoC: wm2200: Use
	SOC_ENUM_SINGLE_*_DECL()
Date: Sun, 23 Feb 2014 11:57:06 +0900
Message-ID: <20140223025706.GH25940@sirena.org.uk>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
 <1392723517-12772-40-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0415592719478878211=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 17EB3261606
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 03:57:29 +0100 (CET)
In-Reply-To: <1392723517-12772-40-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0415592719478878211==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VfjHX4a4S/LzE4mr"
Content-Disposition: inline


--VfjHX4a4S/LzE4mr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:38:23PM +0100, Takashi Iwai wrote:
> Just replace with the helper macros.  No functional change at all.

Applied, thanks.

--VfjHX4a4S/LzE4mr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCWN/AAoJELSic+t+oim9iWgP/1+urJS6z5VYSm19p3vZWXZP
lVx/GVkjsKok73aP3dky79f9iZvdI/YGWrXrwwUfMC1nG9TK1f4TmtGPsmku2mms
jd/APrfSLWDPiBYWYMIC8mgP1lfTzHEFtfniRbEtQbDBV4Pvlq27G+idVe9XL6FG
7dNL20G9HQt+v691QNkBGQDBGE5Y5003ejqrCe9itQx1fthnPeNCnPPIjny+c02h
5orjFWqmK75vWJC8DkDmSy6+Th6fJ8+dgTbtw5Enk7B0qew0O96NJzMAsLwvgk6A
fzUVEggwIXxHV22L8Sf5G59UwRWkdOR6J7iofPL1jYPamLUWzXaS+f4lT+3RHrRx
QEF9DH8RGZ63UV6ni21p1QGNv6HXuazDU2sNypfqXUSSmjDlDOTQU+ffjhXclSvy
VxlQCqubuMoG2bi79D0Dw2xEQNV9a0oMhijc9V2hTTpnGeVvEhVaZSqLcxtU5g4+
qrv0ru6yG8z/yq/fsadIYMlkBEX6r9/E2fSVv6b+TxWj4IvT+xqtiPA6dGEF4Anz
GmCHjqrhbqYtSwji2o1OGkjFaSveCaKFANbby8W41I0H6mpcZ4G70mv4QcJgNILQ
ork1O303RJISxYURyfKBANvoeK7wmuic8CnXmpWyK0nhjdm4neVpHebALd6qet9A
SlaYL9fcCKBKM5FbdgFH
=Rt7p
-----END PGP SIGNATURE-----

--VfjHX4a4S/LzE4mr--

--===============0415592719478878211==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0415592719478878211==--
