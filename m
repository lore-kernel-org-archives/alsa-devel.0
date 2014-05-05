From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: sta350: fix DT bindings document
Date: Mon, 5 May 2014 12:52:16 -0700
Message-ID: <20140505195216.GY22111@sirena.org.uk>
References: <1399283363-16441-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0433389024987217850=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AB4D0261ABF
 for <alsa-devel@alsa-project.org>; Tue,  6 May 2014 02:56:32 +0200 (CEST)
In-Reply-To: <1399283363-16441-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0433389024987217850==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8jEihaNHb65WmIJG"
Content-Disposition: inline


--8jEihaNHb65WmIJG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 05, 2014 at 11:49:22AM +0200, Daniel Mack wrote:
> Fix a misleading property description, and denote the fact that
> st,output-conf and st,ch*-output-mapping have to be passed as /bits/ 8.

Applied, thanks.

--8jEihaNHb65WmIJG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTZ+vtAAoJELSic+t+oim9dwUQAJazdVQskrUkiym8IapnrxSB
edFe89keejU1D9uKNjCCykZ+4xIOJ5qPmAZRMaSZtbN8T8CsTu5OdSXQP9nnJw4Z
dAS35hBEZTwWulkiUFtBIeeV8rGwMD59N+KahMqtkRB/hoe06iRz1Od8ztKmbsJ5
RmT7oHtVh64jYllz9lrVjkTtOapplMmmSYnp0A/jCAcaQwnYaVrev2xcKAlTRdoG
XV9+N+Qr//VMuAFWkduc2mt39rocEthBHdXWf7Oh6rmuPRqKRQkgwxvwVde6cDpC
OvINWEmBydVLlEWw6kk/Rs10H6dqYchx0z+d6lllgRq/g81VfGxRP8klm5tOBRji
XVhgl9Zq48h4vf2arzhTXBQZJKvyIew7wl6+Xote5ZPmD+sxangddqPKzzqqvWVr
UW6US/Ih28vokEeZR8H81sRSXCCJudBAv0hFB06V4Q2GGZsTmk9P6uwYSey8gfpP
kFWYJxbVPU+GjwZX3aEelzEgmnz7J2i/oWyNcf4dyIAx0utWkPNAL1LWNbEh36FS
/muBm8iDEoH5L1KrAtl8a2rAtc2jBIE/SpAjSxwhUfTotLGhK/hzhx2QQz73Vnwq
4Lrt3XX0rRJtmz0p9HQpPVEwk+jORUpSwD714xEfPCnmpMEORmfaQPAxuLmOTRm3
Xw3erQDP+sli0P5OZj3G
=NTqW
-----END PGP SIGNATURE-----

--8jEihaNHb65WmIJG--

--===============0433389024987217850==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0433389024987217850==--
