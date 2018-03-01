From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 05/25] ASoC: qcom: qdsp6: Add support to
 Q6AFE
Date: Thu, 1 Mar 2018 20:42:00 +0000
Message-ID: <20180301204200.GQ12864@sirena.org.uk>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-6-srinivas.kandagatla@linaro.org>
 <2465335e-4d45-02d7-2e64-0a1c28a44ff1@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3891569993252846390=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id EBBD7267C2B
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 21:42:02 +0100 (CET)
In-Reply-To: <2465335e-4d45-02d7-2e64-0a1c28a44ff1@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rohit Kumar <rohitkr@codeaurora.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, rohkumar@qti.qualcomm.com, lgirdwood@gmail.com, linux-arm-msm@vger.kernel.org, plai@codeaurora.org, linux-kernel@vger.kernel.org, tiwai@suse.com, david.brown@linaro.org, robh+dt@kernel.org, srinivas.kandagatla@linaro.org, spatakok@qti.qualcomm.com, andy.gross@linaro.org, linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============3891569993252846390==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4T94Hejb80K+e1gX"
Content-Disposition: inline


--4T94Hejb80K+e1gX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2018 at 04:00:32PM +0530, Rohit Kumar wrote:
>=20
> On 2/13/2018 10:28 PM, srinivas.kandagatla@linaro.org wrote:
> > From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> >=20
> > This patch adds support to Q6AFE (Audio Front End) module on Q6DSP.
> >=20
> > AFE module sits right at the other end of cpu where the codec/audio
> > devices are connected.

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--4T94Hejb80K+e1gX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqYZZgACgkQJNaLcl1U
h9DtOAf+JOjxq69qku/Nea4t7d4rn53+qUcNeXlMiCV53Qv3E0blYecahZ6X6UIL
MeYtK2Z2mXMReoW7pvtjXawZv/FvKmGgtJZGP2Od1IkKXKls4fn/W7fOtFJZjbu9
9UsBBw+f95LMi/2BxnFVizw05UJllYTCpXbE1F7/eBQhSRiwD/huUNHKD83RRn0n
xtiLXxIESBpbsBh4zmpMb4HoDr4x+r1z3/jpT6ErMOOaIl3igVvIPff14jBUXjw4
5MpsmlQncXgFQtYuixB25bFQCCCdlMA3u5GZWgHg1gvZsRQO4mYErw6mmPEI+Gog
W6fNi7Cq2UpUd1EZoyaPD1GhqqVTig==
=k78j
-----END PGP SIGNATURE-----

--4T94Hejb80K+e1gX--

--===============3891569993252846390==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3891569993252846390==--
