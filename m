From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2 v2] ASoC: nau8825: non-clock jack
 detection for power saving at standby
Date: Fri, 13 May 2016 11:48:41 +0100
Message-ID: <20160513104841.GA22038@sirena.org.uk>
References: <1463131037-19220-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7646027548889001996=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B14AC260447
 for <alsa-devel@alsa-project.org>; Fri, 13 May 2016 12:48:54 +0200 (CEST)
In-Reply-To: <1463131037-19220-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, lgirdwood@gmail.com, benzh@chromium.org, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org


--===============7646027548889001996==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 13, 2016 at 05:17:17PM +0800, John Hsu wrote:
> The driver changes jack type detection interruption to non-clock archi-
> tecture for less 1mW power saving. The architecture is called manual mode

I'm missing patch 2/2 here?

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXNbEDAAoJECTWi3JdVIfQaRgH/2BMhrtVWPWOBcld7UEVyNie
zYjgv7A1YuOMfe305757+JgzYDrQURME2vdoWnM+qdHbukWXulJLXkPEaXqtQECY
RUleI3lo9wfjYILEg8m62Db78JGE2Gaxg8inJ6K1fpHvWolrSUWL6CWzBkPiYzLn
++bVZYZswIqgcMLYLFZbE5P/GT2ANP+diE3TWxSgqS4PgBPXomMTEUVPGPwu/WKD
IVy/QyCztGwyEfa4hpznoF6mH/f8Obar2VyzGuGvntx1jcPKgA+ykJ4FBDZxVGMR
QxrLPMzWnC5VsA6dpq0TFL65OmuPDVujOs+d24KOcJUYU+fUfCZFjibX57fV2ZU=
=AY4E
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--

--===============7646027548889001996==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7646027548889001996==--
