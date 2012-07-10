From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: tlv320aic3x: add AGC settings
Date: Tue, 10 Jul 2012 14:42:11 +0100
Message-ID: <20120710134211.GB9409@opensource.wolfsonmicro.com>
References: <1341923712-8361-1-git-send-email-jiri.prchal@aksignal.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3427547380389695573=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 67A782432E
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Jul 2012 15:42:13 +0200 (CEST)
In-Reply-To: <1341923712-8361-1-git-send-email-jiri.prchal@aksignal.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jiri Prchal <jiri.prchal@aksignal.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3427547380389695573==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V0207lvV8h4k8FAm"
Content-Disposition: inline


--V0207lvV8h4k8FAm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 10, 2012 at 02:35:11PM +0200, Jiri Prchal wrote:
> This patch adds AGC target level and times settings for TLV320AIC3x.
> Enums uses small arrays of two channels left and right since it uses different registers.

Applied, thanks.

--V0207lvV8h4k8FAm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP/DEsAAoJEBus8iNuMP3deBEP/RKyBOx6d/CCa714Cho0s8ji
fXItOXr6KQvo7wvigmuq1K5vB2aTiTYfiXwkTgwuP/2GHs9xtgry7nbi3HdbnBWq
MjGTqHi/XCMlnfPKnMqf3E9pM65Uc2VS0cOVG+Rofpqoyo5Sw7KYu8FpbydcOe/m
wydKw/hmJreI9j3XW3XRr4F7PIz8LVC2gtNJmzqY5egiL/17Er+DLeZh/YqmfOqa
0VyCygP511bI2dAbcnHdAWqubgyWQfZvVhg7iboJevLitdzSYllv4oWujceKHT40
Az/ehIjH4GsJJs7QDig/HHrsh/9cUWzdHoch528Z2lPBoe4x/3vbVw0xRhQlWud0
mnfVSmWaf7+oFLChbQ99xGCiypYNuDEPjtS8CcnPVOHSGhythLH9xAS05LinyJ6K
Ctxnz5Y0ybQyqgvIS/bP3OPIw3G3UMjsnEPIJvSao7UDcKz3Fk9adoHb8ssXP/Ld
LuW6ElJ9819osMArx/EBltqvz+wHv2AGDOgdRyRhDVP4XZ94DyrQmE06NjvybxIH
sX+GvUFuSmiPVS6hx5yGEBnuaboR4S/tSfFNhwqIdYskp2EizpwfoSwyG3VG3daY
ARQ+ZIvu/Hta/r+4SEMrmXGTaP+9dJgsr7HfxuYkcX1n/srJCVqSi4xx6wBd/OW4
aoDom9zUidDkPKfgH3L2
=Pdju
-----END PGP SIGNATURE-----

--V0207lvV8h4k8FAm--

--===============3427547380389695573==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3427547380389695573==--
