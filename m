From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 06/18] ASoC: wm8737: Use IS_ENABLED() macro
Date: Wed, 27 Nov 2013 18:14:42 +0000
Message-ID: <20131127181442.GV14725@sirena.org.uk>
References: <1385044736-14911-1-git-send-email-fabio.estevam@freescale.com>
 <1385044736-14911-8-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3808021524754505452=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id C3718264F23
 for <alsa-devel@alsa-project.org>; Wed, 27 Nov 2013 19:14:44 +0100 (CET)
In-Reply-To: <1385044736-14911-8-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3808021524754505452==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hK5WMeVMNp/FmgOI"
Content-Disposition: inline


--hK5WMeVMNp/FmgOI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 21, 2013 at 12:38:44PM -0200, Fabio Estevam wrote:
> Using the IS_ENABLED() macro can make the code shorter and simpler.

Applied, thanks.

--hK5WMeVMNp/FmgOI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSljaPAAoJELSic+t+oim9p44P/R+j9fIbvHvZQcNbN3Qmsy6Y
Kj0BCGYur9rrcXQh606eIU+c9W1V2bviSwFyS/hmn8J9/gcTT4aYNSnYYWUDI5f1
RHHmkeB+/5lhYXMLiFFvp3zIvNCnxn2P3wOzA40OH3ZLf0vbMP84pdhuGsOWWIUg
CqCJxNtQ96Sbd0l2dhYKZh5ADtuCZ2MvEB3Rj4leFRckF7NfGoECZ8Xa/obPKoai
SVLg+kAUsMDyt758Vf2ignLvvgxqvifSGnx2Vz7NuZ1WPMbTHEbNtJ/3jE8OHUcZ
uKTzGFAIEEA3wYSqkT+eNoRoJP1P/ecdw7MqA4765FKDx56jpSi292TbQtCTJFxH
7rdFwTthBgTlVM+tcUFUIRJR2/Z+zLud1KVdFNHkR0ekEXoc6zcU09Wk9vl+Z/7K
BLU8G6O4Fj5vhS31G5BwIdQhwVKNupDmmil1Tf24GnsjkKyFnzs7epl021fJzSSI
4jt3drDowUV+yZn4733NngoHhgLVWDybd2L4d4wVeMmwOCQtit2iFI+UaGagIBKN
ucahRLT3G2lY6JGbCRVL4sMYP+Ah1gRzyH5e6Iyp+3kWHVp3EHFWPV6DoHpLoy9G
F/Kud8EreRf6xEgPXIKDli3MwGej097OhlSnTrG+NzHJJYXC/MEpkGEDKVi4H+Nk
6n+h3VEZOqZEG0IO/A7z
=z9kK
-----END PGP SIGNATURE-----

--hK5WMeVMNp/FmgOI--

--===============3808021524754505452==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3808021524754505452==--
