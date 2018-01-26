From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: use seq_file to dump the contents
 of dai_list, platform_list and codec_list
Date: Fri, 26 Jan 2018 11:28:38 +0000
Message-ID: <20180126112838.GA32674@sirena.org.uk>
References: <20180118053126.22082-1-dolinux.peng@gmail.com>
 <CAHp75VcefO1L-E8ymHX7MibLiOXkRZ3+3FbkF_L+ywMV-i3Mvw@mail.gmail.com>
 <20180123173732.GI7600@sirena.org.uk>
 <CAErzpmt5Z_bVkO-86yCNNWMNSYXWMzvABGtTEuYV1Y1qk=2LJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7984797905742731024=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 67425266C0E
 for <alsa-devel@alsa-project.org>; Fri, 26 Jan 2018 12:28:46 +0100 (CET)
In-Reply-To: <CAErzpmt5Z_bVkO-86yCNNWMNSYXWMzvABGtTEuYV1Y1qk=2LJQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7984797905742731024==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 26, 2018 at 03:16:00PM +0800, Donglin Peng wrote:
> On Wed, Jan 24, 2018 at 1:37 AM, Mark Brown <broonie@kernel.org> wrote:

> > Too late, I already applied this - a further conversion for the new
> > macro would be good.

> I can send another patch after the following patch is merged:
> https://patchwork.kernel.org/patch/10178813/

Yes, please - that'd be great!

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlprEOMACgkQJNaLcl1U
h9AScAf/Sf907o+P9/OADufbnMgqK4yiwpHTa5aqSAnqW7P+1Ilu8pbKrN1w8EJv
GnEWk8fcErilqodk8elf0ou7h5s7cPKisYIP3UQvVhlLTYXrHRh3Asekg+7zgh57
of2BSx5uHyWLJjQZLCLxX5/0vg5G4qy0osV/1jKoyMC8yh1/KLatcGgTD7s9wUp1
WaOu71QCN0aeEPDHGTftCfZiGOuxnEGAjf6acPh0BUCMnh6DHlWqV5sPqh5uqKY/
1EnMWs1ml+qtNdQbrlwnWIqc3IJJIPjyT/eHWR7isdX2uWwYghOoEVFJ0H84KjFG
92PTLLCcPmknXhyhce/2L9Lj2YDdrg==
=OmGn
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--

--===============7984797905742731024==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7984797905742731024==--
