From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dapm: Fix input list to use source
	widgets.
Date: Fri, 8 Jun 2012 06:57:35 +0800
Message-ID: <20120607225734.GF14525@opensource.wolfsonmicro.com>
References: <1338920835-5281-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1982634253591970243=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 419A610B9E3
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Jun 2012 02:58:34 +0200 (CEST)
Received: from [116.228.53.169] (helo=finisterre.wolfsonmicro.main)
	by cassiel.sirena.org.uk with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72) (envelope-from <broonie@opensource.wolfsonmicro.com>)
	id 1ScnX6-0006gB-4a
	for alsa-devel@alsa-project.org; Fri, 08 Jun 2012 01:58:34 +0100
In-Reply-To: <1338920835-5281-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1982634253591970243==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XIiC+We3v3zHqZ6Z"
Content-Disposition: inline


--XIiC+We3v3zHqZ6Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 05, 2012 at 07:27:15PM +0100, Liam Girdwood wrote:
> We should only add source widgets to the input list.

Applied, thanks.

--XIiC+We3v3zHqZ6Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP0THWAAoJEBus8iNuMP3dONMQAJRsVedOzUFLhbNBtZAfuNjl
PPQfHtJZ5o6NqMd50mjyj8BH5B7sQ+pZw2hqrXOkx40yCvnDq9U+hjRLsPIdcBKY
UF5JFIOjjTcP7jMz4ftTWOfTs1uMu9Q1rEW0VtzSJmTtHbPUm76STD24gdoItLeC
/mYgYWDSuoG0+crce18ZqtgEMzlq0vlcZ6hEj01kqim/Vtwr/v0NKlVC3tsIu7BQ
Keu/V08Rd0Kfd6mpxEbBHvO/91TTbC55HSvLxDCEPoB8WWo2wMUlAkgPuW91pvHP
Nnbbfqdy/qk75Qht6LI50LAq5tobl215bZJEClrhAFO3YZMpjMSPkPQNFTA9LAqf
rhPKq7nTfJVcpS098HZ/sCKOtq4ShGavciQYr9fzC+khF3M/O+WXTbv8+21F3JGl
U3csjZy8w3LttKGb0AY28rSKiPEFRxSTUrqL4uqguZTMNj7Y+IQeV+Kwd78ZNbnP
csaP3esDtOTr2np/oqJWgfOQGnFdIlZgkDG71PMGdNxck/kzKTETVH0EttJ6wJBD
Td1RT2TW0JIO4RulI4pnQyLyynbRPzcWuiFiscDOccbC71J2gOeZamCGf177JXb3
iAfHHDpb9M3xgT1/c7aUea5sDFfn0oueCv0xYDwdra+2xcLd90NQ4lTgTwCa4bCD
0OvPAVK7tgyeVYjME+1Z
=SoCC
-----END PGP SIGNATURE-----

--XIiC+We3v3zHqZ6Z--

--===============1982634253591970243==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1982634253591970243==--
