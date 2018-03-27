From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/1] ASoC: davinci-mcasp: Only disable
	inactive serializer
Date: Tue, 27 Mar 2018 19:58:57 +0800
Message-ID: <20180327115857.GF29239@sirena.org.uk>
References: <20180227145104.5868-1-vishalthanki@gmail.com>
 <20180227145104.5868-2-vishalthanki@gmail.com>
 <e74a7b15-8971-6f58-ba10-21f3f0546afc@ti.com>
 <CAC3a_SDgNjxGLZu72zuecJV7e=0STWH8fUafK1h-7jFdGpM-vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1586760376754467560=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4234D267140
 for <alsa-devel@alsa-project.org>; Tue, 27 Mar 2018 13:59:11 +0200 (CEST)
In-Reply-To: <CAC3a_SDgNjxGLZu72zuecJV7e=0STWH8fUafK1h-7jFdGpM-vw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vishal Thanki <vishalthanki@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>, alsa-devel@alsa-project.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, elfring@users.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--===============1586760376754467560==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l+goss899txtYvYf"
Content-Disposition: inline


--l+goss899txtYvYf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 27, 2018 at 01:34:55PM +0200, Vishal Thanki wrote:
> On Mon, Mar 5, 2018 at 1:42 PM, Peter Ujfalusi <peter.ujfalusi@ti.com> wr=
ote:

> > Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> >> Signed-off-by: Vishal Thanki <vishalthanki@gmail.com>

> Just a gentle reminder, can this patch be accepted for the next release?

Oh, and it was just pointed out to me:

As documented in SubmittingPatches please send patches to the=20
maintainers for the code you would like to change.  The normal kernel
workflow is that people apply patches from their inboxes, if they aren't
copied they are likely to not see the patch at all and it is much more
difficult to apply patches.

--l+goss899txtYvYf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlq6MgAACgkQJNaLcl1U
h9A+lQf9F/0kYl3HhvhzOCQwIMcuGUyo6gRXrfF7xV/EibcXRTCFdDVze8XCuhhu
702/vZIitoiIDQkcsc0rvcKVFcaHJzwnnmWZpAKiXb9JLInhLKsU8UdmGwy7qJ7K
e5SaMYOP7d1zj5GwUprAjKzFO3f1KOdUwe2MsUCLUUTIoPbRgPu9rqWrHkSpuJG1
AG/t0MdcLXiHaCFEbf9MUc0TfCoNtSg+RSR60h/woBi/OmzJitvu4fz09EGZBGxJ
FLA63cOYWLxfZw8qs8+NHR3guVpYSrj5WJTcjeItBttbeLTYSsW6r1wd/ZfcFJo9
nrnwg/maDP+SeICb53QuhpNwfyTJZg==
=8qUO
-----END PGP SIGNATURE-----

--l+goss899txtYvYf--

--===============1586760376754467560==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1586760376754467560==--
