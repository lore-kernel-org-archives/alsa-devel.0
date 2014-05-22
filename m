From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 5/9] ASoC: simple-card: Support setting mclk via a
 fixed factor
Date: Thu, 22 May 2014 19:30:54 +0100
Message-ID: <20140522183054.GQ12304@sirena.org.uk>
References: <20140520221359.GF12304@sirena.org.uk>
 <1400772710-23523-1-git-send-email-andrew@lunn.ch>
 <20140522173919.GM12304@sirena.org.uk>
 <20140522175206.GA24500@lunn.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ubQMfBEnLCz74m3R"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140522175206.GA24500-g2DYL2Zd6BY@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--ubQMfBEnLCz74m3R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 22, 2014 at 07:52:06PM +0200, Andrew Lunn wrote:
> On Thu, May 22, 2014 at 06:39:19PM +0100, Mark Brown wrote:

> > I'm missing the rest of this series - what's the context, are there any
> > interdependencies?

> I threaded the patch to your request to respin this patch:

> http://patchwork.ozlabs.org/patch/345353/

Ugh, no - don't do this.  It's just confusing.  Patch series numbering
is used for ordering within a posting of a patch series, the fact that
a given patch might have previously been posted along with some others
isn't relevant if you send it out again in a different form.  People
will hopefully expect to see the rest of the series so they can check
for interdependencies and so on, if the subject says there are 9 patches
in what you're posting then there should be 9 patches.

Similarly threading individual modifications to patches into the middle
of prior postings makes it hard to track what's going on if things
aren't applied - "I want version 1 of this patch, version 2 of that one"
and so on gets hard to follow especially if there's a thread around them.
You get problems like some revisions getting missed in the middle of the
thread.

--ubQMfBEnLCz74m3R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTfkJbAAoJELSic+t+oim9VSUP/3OZWe7CmJI7fO747Ijc7+13
GHljntDS+uRHMQmUCuYE+a0XJW9vYkqwMvJLRm8qd9zPN4cbSNY/q/8FeH/X1T+R
xV8NevjckkJYS547aeTVPzC7Tu05g+RepMCgVLo4ahqijQZr4qRo/rHoZohRg+R0
13vf4xrnKtHSTdjmK7+RHXtq3V05Uw+fgl1Iyt62JChoVDDbMpSahkbpRjIsbEbq
S1x/PoAs91sLzZ9vTIdLc3RqmEcu4dgZk7Cx2AUQuYwafjUh60a7DEyG4VC0G9BC
WrfkpthwRR9UI8mdzGNFk89mHo8UifLciAgsoqfrdgXJBwlZG+SUCNHV53c+849d
FQhFgKVYe95dcfAJsIBJ3s5nvYbpNoslBpSb4lDLnNNTeYnw7DEe07xwIeDjsCoQ
chcw8TCMiMysjybjjqj9JHvqDSEnMT4oce4p/iZ6ABeivAPqUbaHlBypZd6CHECq
FTj9iqcnsk5vvs2MJi9ay+CxVwnZsxTCJW2lzJ+SEx6JXdkCnhAzL+rXax7PmgHk
PbOw2O/bwOOstzr987CUKqFm4YP1xFe5Wam/bs1X1/TlznC74nQ4/AeTN8WVR+zA
QyXOLHJH1XlwO4cvPggwOSEhuACzPAq1UM+MaoeSvBKuETKLm/17r3Q5tpvnlR1Z
AM+F1g8AQSVNHkDWL5Qo
=vI0r
-----END PGP SIGNATURE-----

--ubQMfBEnLCz74m3R--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
