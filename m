From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/9] ASoC: cygnus: Update bindings for audio clock changes
Date: Mon, 25 Sep 2017 17:28:39 +0100
Message-ID: <20170925162839.wvnxm5kbzsqpwwj6@sirena.org.uk>
References: <1502748417-26417-1-git-send-email-lori.hikichi@broadcom.com>
 <1502748417-26417-3-git-send-email-lori.hikichi@broadcom.com>
 <20170815171424.whcy4mftex6sgzgj@sirena.org.uk>
 <d7e7144b-26c7-b96a-663d-03744bb60c36@broadcom.com>
 <20170816105954.ve434zeeqinweo5a@sirena.org.uk>
 <8c2fc92d-5ea8-8163-a588-0a4cba55e0f8@broadcom.com>
 <20170822160703.nusf7sv6k4gj3pti@sirena.org.uk>
 <492cb202-f4cb-4f5d-5d32-3dee4f1226b5@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6387233675705899550=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <492cb202-f4cb-4f5d-5d32-3dee4f1226b5@broadcom.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lori Hikichi <lori.hikichi@broadcom.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Rob Herring <robh+dt@kernel.org>, bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============6387233675705899550==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cfkq5nj4dwnxwnsw"
Content-Disposition: inline


--cfkq5nj4dwnxwnsw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 06, 2017 at 06:45:22PM -0700, Lori Hikichi wrote:

> This will likely impact a couple of the other patches in the series, but
> most should be applicable. What would be the best way to have some of the
> other patches in this series reviewed?  Should I just drop this series and
> resubmit new individual patches for review.

Resubmit the ones that can be applied as is please, that'll avoid me
making a mistake about which ones have the dependency.

--cfkq5nj4dwnxwnsw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnJLrYACgkQJNaLcl1U
h9BU8Af+JvLz6Fku2pK0Ya2GrFTXbyc3N83SwYhAmHWm2XcSYRtk9XgKeA+ZviOP
pb6x03vyjoyDl8s126mZ/fs5lXzRyMW41rAMdXnBpj6vP5NhW4yvpazcRRxo+Lrw
xxhfENIVIw6pi56JJZtw10QFFkdVQSHkGBMsIqow1RdbHfr+6tPy37TKbBYzdUH1
cVKEe7PhUmZ78Ingj8BcSK/iIcpocOxa8/W9vwTBbH9LQ0JVGmaGb1lzun6L9l/a
drBeDHffP1VdO/Gn31EEAZwR0222d+Gy4UOz98lCyMD6JHhYY1M8p90L4sAcZEnv
VQfrBtjn1lCyomwxxDCiedkTCjFkxA==
=T7Tw
-----END PGP SIGNATURE-----

--cfkq5nj4dwnxwnsw--


--===============6387233675705899550==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6387233675705899550==--
