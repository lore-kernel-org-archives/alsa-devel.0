From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 032/102] ASoC: da7210: Use
	SOC_ENUM_SINGLE_DECL()
Date: Thu, 20 Feb 2014 11:15:46 +0900
Message-ID: <20140220021545.GK2669@sirena.org.uk>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
 <1392723517-12772-5-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4446310691588963104=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id F2E3926537D
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 03:20:48 +0100 (CET)
In-Reply-To: <1392723517-12772-5-git-send-email-tiwai@suse.de>
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


--===============4446310691588963104==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0x7AiijBCkgCCF1X"
Content-Disposition: inline


--0x7AiijBCkgCCF1X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:37:48PM +0100, Takashi Iwai wrote:
> Just replace with the helper macro.  No functional change at all.

Applied, thanks.

--0x7AiijBCkgCCF1X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBWVOAAoJELSic+t+oim9dBMP/1f6iH8ZjrmV5R7SseeilNbt
fwDUndjONnlofDt3NBAvKXUBohr1V+KdZqAOintLXyIZGt2xP+Yraes16z3x8gKm
zbp9zg4Mv1AkuSq+WIQGODr3I3AUOkdUdV5dIW4/Vfu6v/f/kPSreJgbeVS7oFbF
oGGraZ0jBtTMNZgTATJ5yE1zvv4XCGz2z5QNTIWLUwx5KPat7Xxuk34yrsFrG/xU
m7S4YP3lFEwRpUC6VaGgZdYviUJ4ZdpzvXv8H5yVSrVA2AEMrqA4Zp5tfXrHoiwk
gj4YdURZcAzbj5hv7QzrVKhPIs6RCiv1a1TuTzTm3dSRXdJVjUrKQCSk6l5hAhXJ
C9YIliABYap216RYC6HJSYtXHVAJg9+TqAftHwFDzfKDcvUhqZdy4641tAupcrc0
2SZzs3fUAM2nv5v0TX6TjhK++tVyqfcHzufFw2gdIqb59oAL5sIOBnRhxa0am6t4
rINfXMGYHjJQf5py7j1yl3f3nZKHMyj8UerOL+L/AIrb5TMM+4Mmrc1KWTOQ/h5O
vDi9/4ShTCie2yetFKleRcL452Tq8pDmXpcTSnY/qE7dufWMucDN7Y2VIxh8CjsQ
6gKP/3kZvZ7RF7JeLuf4/1o9aJjyO0BRP5neXG7HRSAMReIlZTrPWlD0MtvxDeM2
p/07OGNztjtCiI86Y0RK
=c1X9
-----END PGP SIGNATURE-----

--0x7AiijBCkgCCF1X--

--===============4446310691588963104==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4446310691588963104==--
