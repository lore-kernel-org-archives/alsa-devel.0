From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RESEND] ASoC: wm8741: Fix setting BCLK and
 LRCLK polarity
Date: Fri, 3 Nov 2017 18:37:29 +0000
Message-ID: <20171103183729.xhngptij3qgarf5o@sirena.co.uk>
References: <1509734068-9693-1-git-send-email-sergej@taudac.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4569526346690843360=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 038F1266CFB
 for <alsa-devel@alsa-project.org>; Fri,  3 Nov 2017 19:37:31 +0100 (CET)
In-Reply-To: <1509734068-9693-1-git-send-email-sergej@taudac.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sergej Sawazki <sergej@taudac.com>
Cc: ce3a@gmx.de, patches@opensource.cirrus.com, alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4569526346690843360==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="efwayt6yhcjp37h7"
Content-Disposition: inline


--efwayt6yhcjp37h7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 03, 2017 at 07:34:28PM +0100, Sergej Sawazki wrote:
>   (3) 11 =3D  inverted BCLK, inverted LRCLK <-- Fix this
>=20
> Signed-off-by: Sergej Sawazki <sergej@taudac.com>
> ---

Is this a straight resend - you dropped Charles' ack?

--efwayt6yhcjp37h7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAln8t2gACgkQJNaLcl1U
h9AqHAf/VLQxNAbxW7LfhuCa7zGKN1BfdAGRwAB00+Cl7QYz0ZeBxD3Py+CxTZwT
xemiwyDuCCi+lxxxya0TKVrjB8aaTirgljQhnPDagSvoWPSUtR2Ds+7MW1K8aUP7
8cfSaWIWM+3oQ23KpT1etEAmQjOJGyiKhKzZxKC8NswRn54DZ/bHgnirgs//c5sQ
CdK0F6YialHaAsechpPL5LkcRle0bEydPhf+SzwRspvUxrn8zO33Z56OsMbPqwqN
p82fol4A3gVEu+rgWVGMKalpNXDmumVTfXcyUR77tpUB2eXQ+DwE82QM7MAj+5lo
I0E6W6DrOTBKGQFYkqI+5UOW/IRq0Q==
=LRny
-----END PGP SIGNATURE-----

--efwayt6yhcjp37h7--

--===============4569526346690843360==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4569526346690843360==--
