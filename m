From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/8] Add ASoC support for AMD APUs [v4]
Date: Thu, 22 Oct 2015 15:53:20 +0100
Message-ID: <20151022145320.GP8232@sirena.org.uk>
References: <1444320760-21936-1-git-send-email-alexander.deucher@amd.com>
 <CADnq5_OwjyjL+Xn3-f==Z3qPCD03kM-+8f5fwvKxvwRwXyyMJQ@mail.gmail.com>
 <20151020001422.GV32054@sirena.org.uk>
 <CAPM=9txzacA+04MA5VOjF3V3EuQguuF244PSvQ3pXKkhKNV__Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0898772108=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CAPM=9txzacA+04MA5VOjF3V3EuQguuF244PSvQ3pXKkhKNV__Q@mail.gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Dave Airlie <airlied@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Bayyavarapu,
 Maruthi" <maruthi.bayyavarapu@amd.com>, Liam Girdwood <lgirdwood@gmail.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, rajeev kumar <rajeevkumar.linux@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, perex@perex.cz
List-Id: alsa-devel@alsa-project.org


--===============0898772108==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qSHHer9gQ0dtepKr"
Content-Disposition: inline


--qSHHer9gQ0dtepKr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 20, 2015 at 10:19:38AM +1000, Dave Airlie wrote:
> On 20 October 2015 at 10:14, Mark Brown <broonie@kernel.org> wrote:

> > Please don't send content free pings and please allow a reasonable time
> > for review.  People get busy, go on holiday, attend conferences and so
> > on so unless there is some reason for urgency (like critical bug fixes)
> > please allow at least a couple of weeks for review.  Sending content
> > free pings just adds to the mail volume (if they are seen at all) and if
> > something has gone wrong you'll have to resend the patches anyway.

> To be honest, maintainers also forget, get busy doing other things,
> get diverted down rabbit holes,
> get tasked to do something else. We also don't know when maintainers
> are at conferences,
> or on holidays.

This is why I'm saying leave a reasonable amount of time, for relatively
short delays on non-critical stuff the most likely explanation is that
something like the above has happened and there is no problem.

> I don't think repinging patches after 11 days is that unreasonable if
> you've gotten replies quicker
> than that previously.

It's a waste of time, if it's just a delay then at best what's going to
happen is that the mail is going to get threaded in with the original
posting and make handling the series take longer when it does get looked
at (something made worse by the tendency for content free pings to do
things like not bother trimming context or top post).  If things have
been dropped then all it does is require that the maintainer ask that
the patch be resent again which just makes things take even longer.
Either way a content free ping, especially a rapid one, is at best
slowing things down.

When people chase me to review their patches ahead of other people's
without some reason for it my standard response is to defer reviewing
those changes, I don't want to create the impression that this is a good
way for people to get their work prioritised.

If people are taking the fact that sometimes responses come faster as a
sign that content free pings are a good idea then I begin to see why
some maintainers are just generally unresponsive. :(

> I'd prefer a content free ping, rather than another round of the
> patches with two spelling mistakes
> fixed etc.

It's very easy to just discard old serieses and never even look at them,
we have to do that all the time anyway when other people help out with
review and identify issues.

--qSHHer9gQ0dtepKr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWKPhdAAoJECTWi3JdVIfQZLYIAIOuU75JRDoHH2M5MzKvgLlQ
Xvqyc9pENO5yXo8ZxnPfVRGpA2Nkgd2faeBLzLkl2bozyL2hMpi83R1NMXUXLwOO
rPoJRzS36dlhgWWyCBK4Tw4z8jUGIOQ8qr1Phrv1lcOU9CGkwhc1ZrVgusnVA7B6
kh90SxOxLiOWwCG3p/3wIs2YQGJyPKENpQ1NONs42bjhqOlzo6WmfIBwH65ae7j0
m4CEIvi8jKp9M6KZrUDbHR8o2CXLOFd+b8rsMk+nXaARcpHN9znmkK7yR8EpeV8P
m/EptNKPI4u5rVTxF3tVFhiNxJ2tRD18pxnkR6UebyVxfMwSIvj6ZFz3MHvf5pk=
=kTX2
-----END PGP SIGNATURE-----

--qSHHer9gQ0dtepKr--

--===============0898772108==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK

--===============0898772108==--
