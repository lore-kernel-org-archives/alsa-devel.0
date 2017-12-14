From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v10 08/13] regmap: add SLIMbus support
Date: Thu, 14 Dec 2017 17:27:28 +0000
Message-ID: <20171214172728.GK9788@sirena.org.uk>
References: <20171211234307.14465-1-srinivas.kandagatla@linaro.org>
 <20171211234307.14465-9-srinivas.kandagatla@linaro.org>
 <20171213092537.GB12631@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2241766681244838237=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 54E6626732A
 for <alsa-devel@alsa-project.org>; Thu, 14 Dec 2017 18:27:30 +0100 (CET)
In-Reply-To: <20171213092537.GB12631@kroah.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Jonathan Corbet <corbet@lwn.net>, tiwai@suse.de, linux-arm-msm@vger.kernel.org, linux-doc@vger.kernel.org, j.neuschaefer@gmx.net, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, srinivas.kandagatla@linaro.org, pombredanne@nexb.com, sdharia@codeaurora.org
List-Id: alsa-devel@alsa-project.org


--===============2241766681244838237==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T4Djgzn3z2HSNnx0"
Content-Disposition: inline


--T4Djgzn3z2HSNnx0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 13, 2017 at 10:25:37AM +0100, Greg Kroah-Hartman wrote:

> Mark, can I get an Ack for this patch so I can take it through my tree
> with the other patches in this series?

I just gave a reviewed-by to the whole series.  Might still make sense
for me to do this one patch, let me know if you (or Takashi) doesn't
take this and I can apply.

--T4Djgzn3z2HSNnx0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloytH8ACgkQJNaLcl1U
h9AEWAf/WvsYtRARKmKQakGE/Fj7lwl0UiYI8Ff3HKAkhplZbqrw/SAanjGtG//g
BOJp1ulgznLUsMwuFn66m89etgineyimjweVANgdRRqDNZ9iqo6jUcC+dYQc5hAQ
SUmh9AbPOTq9bzCubjtP8un4h/A7ylcCZSftX+juhVXaieGmiRUG7xPqLFzHL77I
2Tt2veoHKhqSn7gRhSj5NCTwiXMImjSrKBpQtybReroHnfOLnyM21R2vyA4dXiSM
ruYfsrhYKrQb6ScYGgSHaxKveLCy/KfaNf+zWxnp0CxDbQ8WC3TJufP/Cd7Tf6O2
sGERivKudj3duZx3iS3si7cFqILqhA==
=8Pwd
-----END PGP SIGNATURE-----

--T4Djgzn3z2HSNnx0--

--===============2241766681244838237==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2241766681244838237==--
