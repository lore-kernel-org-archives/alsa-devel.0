From: Mark Brown <broonie@kernel.org>
Subject: Re: linux-next: manual merge of the sound-asoc tree with the
 drm-misc tree
Date: Wed, 18 Oct 2017 17:26:31 +0100
Message-ID: <20171018162631.qceuluxqpv3xu2xb@sirena.co.uk>
References: <20171018095733.2ffvg6ty6kn2lfdf@sirena.co.uk>
 <20171018100802.4eiin6bhsj6wir75@sirena.co.uk>
 <BN6PR12MB165283F1E4A670659E6C0C89F74D0@BN6PR12MB1652.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2xf3hjck6by2gymk"
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <BN6PR12MB165283F1E4A670659E6C0C89F74D0@BN6PR12MB1652.namprd12.prod.outlook.com>
Sender: linux-next-owner@vger.kernel.org
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>, "Zhu, Rex" <Rex.Zhu@amd.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Intel Graphics <intel-gfx@lists.freedesktop.org>, DRI <dri-devel@lists.freedesktop.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--2xf3hjck6by2gymk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2017 at 02:33:37PM +0000, Deucher, Alexander wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> Your conflict change affectively reverted 1e4448648333a which is what
> caused the problem.  It looks like Dave did not yet pull the request I
> made.  I can send another pull request, but you may run into the same
> issue if you resolve the conflict the same way again. =20

OK...  I really wasn't expecting to see any conflicts at all TBH.  I'll
have a look tomorrow.

--2xf3hjck6by2gymk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnngLYACgkQJNaLcl1U
h9Bbcwf/Qe4ssY96ep1Urm3ao8tYBJosR/MPLvYnU1bDidbuF8guM7CXgVYSuPAI
Z+I6/HkAlABDMuGXGEL34T7ZL1B8Znpvr9CP3Gqmdvf4nbTvcNLLC53ZQlP01Gcu
Geuj7AcYHh8+Fq2uBEj46z19oRslTWTzE842U1PZoE7fJGpWojyTS8O66771KLhR
PxQ3cxhWERHHEQq7LwZgYzJHSwq07Ay1rc46VgNfITV+kRgwGFsbsnBBHZrlxX0b
WHJ1bmPtyBnxpXMt88O82L49euY/Zst4+6WuMnnNyaSsmeMd3KsHnNIadr6j5QS5
NC+et1gSU/gMtd+83do1XZ1xwosNWQ==
=r8/H
-----END PGP SIGNATURE-----

--2xf3hjck6by2gymk--
