From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/2] mfd: arizona: Add GPIO control
 register bit definitions
Date: Thu, 4 Jul 2013 11:23:17 +0100
Message-ID: <20130704102317.GR27646@sirena.org.uk>
References: <1372924588-14666-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20130704084959.GI27646@sirena.org.uk>
 <20130704101124.GC1302@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2140128654670051557=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 7621A261A92
 for <alsa-devel@alsa-project.org>; Thu,  4 Jul 2013 12:23:21 +0200 (CEST)
In-Reply-To: <20130704101124.GC1302@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, sameo@linux.intel.com, tiwai@suse.de, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2140128654670051557==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BahA2oRLnmLPbGSK"
Content-Disposition: inline


--BahA2oRLnmLPbGSK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 04, 2013 at 11:11:24AM +0100, Charles Keepax wrote:
> On Thu, Jul 04, 2013 at 09:49:59AM +0100, Mark Brown wrote:
> > but what was the change from the last time?

> Apologies no change from last time for patch one, just adding in
> your feedback for patch two probably should have added in a
> comment to that effect.

> Thought it would be best to resend both patches though to save
> people digging them out of two seperate threads.

Since I'd already reviewed it you should've included the Reviewed-by I'd
provided in the resend - this saves people having to re-read the same
code they've previously reviewed, ensures people who provide review and
testing get credit and also saves maintainers the effort of collecting
all the acks and so on manually.

--BahA2oRLnmLPbGSK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR1U0RAAoJELSic+t+oim9HxUP/3BFi9J7isN4ycqvYP3n6DvL
s8j+bSEWQOByLm6XG7vc9SWcyWBFeuiU8pf4aPfHR95RhNM1MY59SPyMRAR5YZAO
qgNxOZgD9Bjqzq9VLGtFZmeDqieUHd9KO93oqI62eQSrhKRguXYGGfbHxca0Ydm4
e1zD7uJ6jhQgiZ3D/AICOrG5mbp1AW4FJTP9WS/4sSbjT1+ewiLq3R0w2bi6BBbB
19EKh7edxx/XKvb1qkukRGd58bVKcFOo5m8MvjCCKd+Z0vn13Mm3/EAs2jqXbQU9
oN+TD7hxFGWZRmpk73IfyCfAgwKzPcdDSpGpDxbSTHoQXEFiCb+vuretccqhWRfj
4EtBYrHI4GZAyBjNYi4bWlQ1rgZiaFEx90xJHE7y5EMmkYR2hGtS+oIo5p6hn9kY
RjfFL5K5qfT1bX3VZ2nIKyIScMBIkvkt/5kGperQh6MM8HrR507ksgjcoFj2hGcp
EeYxFQr6aWV3EXTE3mNwykAtrARFEAw8NGW/9nJXT3WaU3VRRvTfFw8x8cZVlRIb
rvfEIRSWy68sS54RJjAzbGg2mL/bRuXOVbdV7Xi61mSjtj7tlyTu/HSGiLvo3Hvx
vJoTcOPk8aq+BDjrkSdEP83qQAstpYJbvvhcEe+d0xNV8qAyfa0u+iONrc3KOEGk
ezCIqHL399DzT91ePJPq
=CNUW
-----END PGP SIGNATURE-----

--BahA2oRLnmLPbGSK--

--===============2140128654670051557==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2140128654670051557==--
