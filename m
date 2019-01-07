From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 08/11] ASoC: Intel: atom: Make PCI
	dependency explicit
Date: Mon, 7 Jan 2019 15:41:04 +0000
Message-ID: <20190107154104.GH9570@sirena.org.uk>
References: <20190105100606.6673-1-okaya@kernel.org>
 <20190105100606.6673-9-okaya@kernel.org>
 <CAJZ5v0g2bjzjuiDPTbBN8QgvOG0KMC0Ew2QOQH4u2+y6KRo0wQ@mail.gmail.com>
 <20190107121919.GA9570@sirena.org.uk>
 <CAK9iUCPjMr0m+9HUXEbtUPrsvO84HpZV39CUYYkne=EpY_X+bQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5053967930311880098=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id F41892665E5
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2019 16:41:06 +0100 (CET)
In-Reply-To: <CAK9iUCPjMr0m+9HUXEbtUPrsvO84HpZV39CUYYkne=EpY_X+bQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sinan Kaya <Okaya@kernel.org>
Cc: "moderated list:INTEL ASoC DRIVERS" <alsa-devel@alsa-project.org>, "Rafael J. Wysocki" <rafael@kernel.org>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-Next Mailing List <linux-next@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--===============5053967930311880098==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TBNym+cBXeFsS4Vs"
Content-Disposition: inline


--TBNym+cBXeFsS4Vs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 07, 2019 at 10:16:53AM -0500, Sinan Kaya wrote:
> On Mon, Jan 7, 2019 at 7:19 AM Mark Brown <broonie@kernel.org> wrote:

> > Yes.  I've also applied it already and it's *still* being sent without
> > either a cover letter or the rest of the series :(

> There is a cover letter but it is being sent to Linux-acpi and Linux-next only.

> https://patchwork.kernel.org/cover/10749203/

> This means that you are not on either of these mailing lists.

No, it means that neither of those lists is going into my inbox
directly - the cover letters really need to go through the same route as
the patches to ensure that they're seen.  People often read the lists at
different times to their inbox, for example I prioritize reviewing
things that are in my inbox and look at list traffic less frequently
when my inbox is busy (as it tends to be most of the time).

> I apologize. I didn't realize that you applied this already. I'll drop
> this patch
> in case I need to submit a new revision.

You should have got this mail when it was applied:

http://mailman.alsa-project.org/pipermail/alsa-devel/2019-January/143687.html

--TBNym+cBXeFsS4Vs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwzcw8ACgkQJNaLcl1U
h9C6bAf/UcLxlzTCRDtcqBbYTaNDpsPQHDXWsqRODlqT15RDtF2y65YwskOLKZox
E6THXEVyFb/8gXoSlDXTZOR2SkLw8XtijSLgYwz4IhGO19ReRxVipR58hxOjb6Ma
ImuwYWqMkW37G6qFIf2w2y+jrDOe7Pj8NUCcVpyVHsLkDgWoBIoecb7Y8y3486Ja
f15LUJs+w9k8cpxmaC1xwJpPxPg9Onj58mLxYYc+zYwMG0kO4ZwI2EjtokrF39EW
IihDZrJeHyJPOW1HIZ2+3Rw/QqsWMmK9OQdbQoM4wWdRDzmsFIg6u/UlaLErXJ9f
rwghMtI8AYOy9EN0w/JEK7Aba8piTg==
=5HWq
-----END PGP SIGNATURE-----

--TBNym+cBXeFsS4Vs--

--===============5053967930311880098==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5053967930311880098==--
