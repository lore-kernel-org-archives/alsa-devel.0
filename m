From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/6] ASoC: a few cleanups on sound/soc/fsl
Date: Sat, 25 Feb 2012 13:58:43 +0000
Message-ID: <20120225135842.GB3412@opensource.wolfsonmicro.com>
References: <20120224140200.GH5450@opensource.wolfsonmicro.com>
	<20120224142342.GA16659@S2101-09.ap.freescale.net>
	<20120224141705.GJ5450@opensource.wolfsonmicro.com>
	<20120224232148.GA24268@S2101-09.ap.freescale.net>
	<4F4819C4.5040709@freescale.com>
	<20120225000319.GC24268@S2101-09.ap.freescale.net>
	<4F483BB8.7030706@freescale.com>
	<20120225101758.GJ22562@n2100.arm.linux.org.uk>
	<20120225114414.GC3167@opensource.wolfsonmicro.com>
	<20120225121217.GK22562@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0790791387978364515=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4F382103CEC
	for <alsa-devel@alsa-project.org>; Sat, 25 Feb 2012 14:58:48 +0100 (CET)
In-Reply-To: <20120225121217.GK22562@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shawn Guo <shawn.guo@linaro.org>, Tabi Timur-B04825 <B04825@freescale.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============0790791387978364515==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Content-Disposition: inline


--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 25, 2012 at 12:12:17PM +0000, Russell King - ARM Linux wrote:

> Take a look at the diffstat, and you'll see that there's no way that it's
> a "new version of the same patch set".  Tell me, how can the set of six

Yeah, sorry - I misremembered the specific reason they were related when
I replied to you.

> And if you bother to read Shawn's reply to your question, you'll see that
> the whole reason he grouped the two together is because they follow on
> from each other.

No, I understand that the patch sets are related, like I say I had
misremembered the relation when replying to you.

> So my point that you're not listening stands.

I am, what I'm asking is that people don't send new patch sets in reply
to old ones even if they are related as while the thought is good in
that case the software tends not to do a great job with it.  Either just
mentioning things in the cover letter or resending the previous stuff as
part of a new, combined series tends to work better.

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPSOkMAAoJEBus8iNuMP3dheoP/j0pLZABgTgyT2VFK+fuC2uQ
IDRXUXbUEeT4P5auzGx7Qd1CySEVbmxBEtQsPOz9P24Wq1McV0bzsTh/zl8LRdVa
MPtdvXpZfDk/7RKfQgMraTeHkRUWoqGG7rlKkuDVsLEbs7+NGDGqFmkN1tf0fltJ
BrF8ZggFJxXzWMCGK6Zmr6k+X6Lbc4gVy5BMjuuMp3RHuY1OxEsyIFsHDAhZCBxM
qYAcyMmWmVjB5Ac4v7GLlG2z4d4MGd5/bm8MM9WGTjMjGmIJZ16oq21jtDPBqIu+
55kz55OcIBpijtr0Nb3URE4mMSv4xBYROl81vFFSykpvgB9ootq10oFXQb96bLzK
YtcOGbc2EYlDizPPHRY4e8Qu8BptQJ1tu7vkGBdEWuIaHCOSJlQN11H90oJ7NbN0
+DUy+IKaCsLBOotuWHWvUxWRA1miBXy+bCBrdwYVa9yvtDL2mR3cVHRsws/B2Jdi
fBiv8EdCdl71YqPimoUBjNmSN2/ZmG81OBMgtLKGi4m7hww6wZcT8kOIWdJJj9rg
Jj2y9YagqEFL5DM3VJTBLiFRS8yjiIsdVxShJzHn5uJkFiRz+getSAqEZyzbl3N9
uS6kI8tKpP4ShO2YBQakRDA3gjBk5nP3SxbvxuNdX/AakttQahXXQja/UftzPKnq
bFEdIiptCkOYH62/3KFG
=oQqK
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--

--===============0790791387978364515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0790791387978364515==--
