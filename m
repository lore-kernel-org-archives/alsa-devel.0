From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v7 0/6] ASoC: Intel: Skylake: Add a clk
 driver to enable ssp clks early
Date: Tue, 16 Jan 2018 15:00:34 +0000
Message-ID: <20180116150034.GA8392@sirena.org.uk>
References: <1515065119-1683-1-git-send-email-sriramx.periyasamy@intel.com>
 <20180116112407.GA4786@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6860329804703938994=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 43D50266E70
 for <alsa-devel@alsa-project.org>; Tue, 16 Jan 2018 16:00:47 +0100 (CET)
In-Reply-To: <20180116112407.GA4786@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Cc: ALSA ML <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, mturquette@baylibre.com, sboyd@codeaurora.org, Patches Audio <patches.audio@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, linux-clk@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============6860329804703938994==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2018 at 04:54:07PM +0530, Sriram Periyasamy wrote:

> Is this in your review queue? Stephen has given his "Reviewed-by", in case
> you are waiting for his ack.

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, though there are some other maintainers who like them - if in
doubt look at how patches for the subsystem are normally handled.

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpeE5IACgkQJNaLcl1U
h9DusAf/dipt4EWS1it393+k4iUJrEwvQv5USRufXq0TMipBQu1wyx/ixSuunIJ3
87skXguT1Q+ToWgiEHGBsWGNMFIhKUx9/nBoea6r+o2AP77PDp/EU+f8jxIPo4OO
phXUI9hr7ZMS0tCygjrCXZP8xfUeM/4uiDmszrZc7oXQuET9LGW35vanxCcIMBJP
QB0fQ4s8qAkzugn5AabliMnI6eJ50QowC/tVYQ0nZjzEPiwxJOeShNBKXeRKwTo1
+W1BDNxhNf7V5KCLt/Z/Pno6O2YoaLCCq4l7/JmGNt1QA2X+diSSY+VFOQ3+mQoz
DcuQZ9g9mkZ5bpEmiOXHF4NviQbypA==
=Hp82
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--

--===============6860329804703938994==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6860329804703938994==--
