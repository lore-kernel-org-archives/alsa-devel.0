From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 2/3] ASoC: rt5645: change gpio to gpiod
	APIs
Date: Wed, 10 Jun 2015 18:32:23 +0100
Message-ID: <20150610173223.GL14071@sirena.org.uk>
References: <1433917678-13166-1-git-send-email-oder_chiou@realtek.com>
 <1433917678-13166-2-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0053890884985626857=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BD8BC265E10
 for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2015 19:32:27 +0200 (CEST)
In-Reply-To: <1433917678-13166-2-git-send-email-oder_chiou@realtek.com>
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
Cc: Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, lgirdwood@gmail.com, flove@realtek.com, john.lin@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============0053890884985626857==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hyrpr+DJ/h10HsVE"
Content-Disposition: inline


--hyrpr+DJ/h10HsVE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 10, 2015 at 02:27:57PM +0800, Oder Chiou wrote:
> Move gpio to gpio_desc and use gpiod APIs in codec driver.

Applied, thanks.

--hyrpr+DJ/h10HsVE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVeHSmAAoJECTWi3JdVIfQgw8H/1aWuHawgiWMmfkLxGjuVoQN
inidzuC4SBojMC6cMsFUdNcgj0ZM3Dabqcc2X2IdQt2JdqyhwO6rRKwSlI698aob
SL8Xs+GViMJAWNbE3T2RvB3H83nYmJL2VCr4rD+gDiKlDmcnAYIktP/sjujrocPn
dJmH2kjav7vlUXJFmgLsNkSC8+W22gCi3hHr0HgiVTTIV/rjCd1BE2VpESDOA99O
x2ix4ADK2lNNPbvJHDgvUerbGPlZn0bkGc6GT80wG8O8/WhaKKZ6eJ12bhZnvpo9
saztTiApkRt4mv4iBvfhHgBxUEAsFAPrx8hDmBnRsS+JpMFm7eUhlAUbHYtja7w=
=fhjG
-----END PGP SIGNATURE-----

--hyrpr+DJ/h10HsVE--

--===============0053890884985626857==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0053890884985626857==--
