From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: rt5677: Modify the behavior that
 updates the PLL parameter.
Date: Fri, 9 Jan 2015 17:18:37 +0000
Message-ID: <20150109171837.GK2634@sirena.org.uk>
References: <1420684267-19211-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3189989731643819701=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F437260714
 for <alsa-devel@alsa-project.org>; Fri,  9 Jan 2015 18:18:42 +0100 (CET)
In-Reply-To: <1420684267-19211-1-git-send-email-oder_chiou@realtek.com>
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
Cc: alsa-devel@alsa-project.org, yang.a.fang@intel.com, lgirdwood@gmail.com, john.lin@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============3189989731643819701==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jzfGCzLqwOj4IpJK"
Content-Disposition: inline


--jzfGCzLqwOj4IpJK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 08, 2015 at 10:31:05AM +0800, Oder Chiou wrote:
> The patch modified the behavior that updates the PLL parameter. It set the
> update bit before the PLL power up.

Applied, thanks.

--jzfGCzLqwOj4IpJK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUsA1sAAoJECTWi3JdVIfQRRUH/0hm+1fwDN2h2QzHMFrjF4e6
yIyvYUPDPFyJjVLQVy+9wUUAWS4cFDuPpCCMfFkNlkVicqocvl3aLYSqIMhy+Eoc
gTsubfbk059uk2ga6JJ5AR5YLRdIej17xJwbFGzoSu+bPb3H9RDT4biCc2KeDGTb
Pl9XTVrL3xYf0PwtHXgxPz5elZJBdwG+v+ILO+agg42mU0od7CJCiBsy8vQHlrlU
mhs1pe049uWION2Yw2TZmTOXW1eajXx87Y7pGI76wQ5cAqcbJ8DUY1tqymSAPl0J
ur6OR4Q46RD99YLqrdFFkGQrlyimPlsKJsrJuxeaVhG3Hqd93Ifn5ezqSypHj7g=
=gUxq
-----END PGP SIGNATURE-----

--jzfGCzLqwOj4IpJK--

--===============3189989731643819701==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3189989731643819701==--
