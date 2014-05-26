From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: dapm: Add a helper to get the
 platform for DAPM kcontrol
Date: Mon, 26 May 2014 15:29:44 +0100
Message-ID: <20140526142944.GJ22111@sirena.org.uk>
References: <1401106136-3745-1-git-send-email-vinod.koul@intel.com>
 <1401106136-3745-2-git-send-email-vinod.koul@intel.com>
 <53833726.9050007@linux.intel.com>
 <20140526125146.GE21128@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1549329157245404378=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 71B9C264F74
 for <alsa-devel@alsa-project.org>; Mon, 26 May 2014 16:30:05 +0200 (CEST)
In-Reply-To: <20140526125146.GE21128@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Kp Jeeja <jeeja.kp@intel.com>, alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@linux.jf.intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1549329157245404378==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SWXyBy1zHAaCX+aB"
Content-Disposition: inline


--SWXyBy1zHAaCX+aB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 26, 2014 at 06:21:46PM +0530, Vinod Koul wrote:

> Mark, do you want a patch or can edit the commit with title "ASoC: dapm: Add a
> helper to get the CODEC for DAPM kcontrol" before applying, if no further
> comments

It's fine, I can edit.

--SWXyBy1zHAaCX+aB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTg0/VAAoJELSic+t+oim97ggP/3YHwP/RWi2x5H76Vdgnkdjh
0gAQGOFGiGnxCpqD51Kd3YICEtJh2E1UVPjC2DSr754HN3/YoMhs/gmkmhjnurbY
iSDNo/QZ7PG6YlrLdi1ZhQ5nF3xLLljbM0RGefz6YoqfnZwxSBZYePZwqehah8VR
/62pJQrJwp15le/+1yDwR+/Nz67Rws+njI1/dubo8a4tymCVd0Zgq+Sr1I+99Ft3
ojm8mZBjYW1LPaLXGzdkyrVhGjuxniFWEvpNEhm+mTaVUXQNyBCqkOU5L6iekbZ/
P8kRj7hQdPhcJsfWmvtNc4Yiqn+GWzvw0yqJll/MTLkj8CYpMmBpyQ/HcIgdJ4W0
eWpI55jYn1AcCKM9zgtDHp2UqKa9iCaPKg1h1yQuQ/O1tDn1ZOITUehD8oXvpiHX
xM8KbMRWlzY1rNvNBrk8DhTl1uqUZFkU0Wevze0XXF0mX5woCjknO7IKkn1HeNuC
nTw5YeTORWavYgVcyE60QzFCoRUo16fni42ge4+O/9KKsRyycT3BYznGNye2+zhu
n5bVruMEZ/ors6qCQIlHrXCqhE8xY25tPR6QZ2x4bzyhFYiZAmWYaqcwn6ZtZ5po
GxeHg5vRAeCIAECyhxtTJfX3s+hrYWxnzvVIQohUWICUe7u3nfTXIg+mcMUAo3Be
FswVYD4hD1E2COv1W46q
=9fAP
-----END PGP SIGNATURE-----

--SWXyBy1zHAaCX+aB--

--===============1549329157245404378==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1549329157245404378==--
