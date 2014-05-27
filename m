From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm_adsp: Use adsp_err/warn instead
	of dev_err/warn
Date: Tue, 27 May 2014 16:08:57 +0100
Message-ID: <20140527150857.GW12304@sirena.org.uk>
References: <1401192523-5750-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1868855126206011633=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 78D9E265804
 for <alsa-devel@alsa-project.org>; Tue, 27 May 2014 17:09:13 +0200 (CEST)
In-Reply-To: <1401192523-5750-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1868855126206011633==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KPrYzGMfVRt/FH5S"
Content-Disposition: inline


--KPrYzGMfVRt/FH5S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 27, 2014 at 01:08:43PM +0100, Charles Keepax wrote:
> We have defines for adsp messages best to consistently use them.

Applied, thanks.

--KPrYzGMfVRt/FH5S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJThKqGAAoJELSic+t+oim9ncsP/RBpciac2503JoYog2LANdbk
HowqG+lTk4Py1y38ywmC4VlW+cHpBwyQY3R4YsKtt7KpetZXbieP9L0V0nW2KT01
+oUUnosw/QEpr0xjy6WO6+Z9L0kTFQKte35XsnxQ2npHOOc+5Xl3q+SCSGqOixoT
chHWQgWN+G+UhXs2QWAzV8VNfBSCV0cQiSw0RJpVADcNi2+yfk8NmgeP9jdpYHPM
6HDgyR5EiglLW+jFjJoMyco//HjAPljSAVpD07hYtKtL+gTvyxC7iR19SpSHhg8H
jH/vHigRI9+95DM3TOrnc1+zfAOAbxJDjCHo442lcWu1l5OWiNoExc3BUZy7005Z
wHczymBLWwXMt4KIwc/04Z1p4mJjKIrOjsStmZiV5fQswFay71deEuuU1+2NplDu
/Xge3p6LkwL+6hKhX4v43zvYnn0tnql1RCfLDnhJjWuGUapjBySqCVfPFvbQEnbR
pJ+gY0CDmy8HCe20nLeAoKixvZJOKchqb3Eq39ehhbAskqD8Sqfhur/8gc+PmpLE
ShgU/0TXbybc/P1Hn9gGx6+sFg1nVtq0npajWcSjbjcKuF9qkRAkC5WU2hbLClet
+5/MSm6uhYWfhC+jvuwByoRs0IvkVYmgyZcFLeRyad4/8fJ6StG6Wn6T9AZZhTtb
qXmId3uAP+9J36C2hHmf
=u9kP
-----END PGP SIGNATURE-----

--KPrYzGMfVRt/FH5S--

--===============1868855126206011633==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1868855126206011633==--
