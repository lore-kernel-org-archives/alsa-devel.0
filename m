From: Mark Brown <broonie@kernel.org>
Subject: Re: [GIT PULL] ASoC: DMA deferred probe dependencies
Date: Wed, 11 Dec 2013 11:13:15 +0000
Message-ID: <20131211111315.GP11468@sirena.org.uk>
References: <1386695920-1447-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8219283625409755658=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 74A2A261A06
 for <alsa-devel@alsa-project.org>; Wed, 11 Dec 2013 12:13:26 +0100 (CET)
In-Reply-To: <1386695920-1447-1-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8219283625409755658==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2uzDqHpccQJpqF2n"
Content-Disposition: inline


--2uzDqHpccQJpqF2n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2013 at 10:18:40AM -0700, Stephen Warren wrote:

> are available in the git repository at:

>   git://git.infradead.org/users/vkoul/slave-dma.git topic/defer_probe
>=20
> for you to fetch changes up to 0ad7c00057dc1640647c1dc81ccbd009de17a767:
>=20
>   dma: add channel request API that supports deferred probe

Pulled, thanks.

--2uzDqHpccQJpqF2n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSqEjIAAoJELSic+t+oim9LBoQAIKMyrUZDfAN5wf8bEHXe4ca
rdYyxEI3NNx6PlTkndcXjyzSt99WP2bIHfumBghb3KDN3W1piQutTVVtPgRlCBGX
1QqGj8xlPUeyGl19x8ThNbJWgl9BIk2VBsJIz/fp2s/VXbLSMtjgU+dyRW81UvuJ
YdON09DA14GAr8lt2MGKDdkVWEmcCU21UuZiKLdfo/4bI3CoS8QcCe6otvriBqBB
KxdRKE6xDkccY/GWy0clX5WmFzyPnRZM1bcz2CWzEwfX8Qr81giM0i+GWw27p7pp
1AfBltyafPHyS1177daiPz9CjaJxSERCezqkQvBTDWOgoMeVG/FjlR7RVMihhrkZ
jLNRSgzE2xRukAv7fifTqfZKTpx3L8KLV/NHUQNeWazovc6/UN9m1pjzTV1WAe8g
4qgqSZUaNx9RyiYUQoRx8j4ycUZIxb8DCTDObj0BB9fGrkFb8SGVvEP3qfsPbPss
wPE/36CdX7A3aXzRf6F7Ns5GFDusDkltFv7NKGGyHEjgWAtiJAbS70VvJ6KSHF0A
H1pvO2M+Ty7ilMoazzunW8trTjWEd/HuVqX9WoPCUBrjYDZDm2ccNuXpCxBn46d5
JOvOKh2+UAtLlGXddjsgHUysxI9NUsmaTo77vmbouNac0scR6w576hijUCJjaWK2
6aNLfS+WN9ZnSsLREXke
=/cq8
-----END PGP SIGNATURE-----

--2uzDqHpccQJpqF2n--

--===============8219283625409755658==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8219283625409755658==--
