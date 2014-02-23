From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 060/102] ASoC: wm8996: Use
	SOC_ENUM_SINGLE_DECL()
Date: Sun, 23 Feb 2014 11:44:45 +0900
Message-ID: <20140223024445.GA25940@sirena.org.uk>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
 <1392723517-12772-33-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7831338852257164165=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E82F264F28
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 03:44:58 +0100 (CET)
In-Reply-To: <1392723517-12772-33-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7831338852257164165==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Cg7YnprW40CakFnK"
Content-Disposition: inline


--Cg7YnprW40CakFnK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:38:16PM +0100, Takashi Iwai wrote:
> Just replace with the helper macro.  No functional change at all.

Applied, thanks.

--Cg7YnprW40CakFnK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCWCaAAoJELSic+t+oim9RMoP/0rw6BVK+3gSbT9z/xbXwCIN
aEOPsBlUfihBlIJQKnlcCMv+147ZD9ZnFfbaDkq3tz8Yg9gjRTv87eCSTvEkfdaV
Iwp2w0dIIgWeLfp49NQNUstmem2lo7SalVUZta/Lfb3vWt7LckiUDSdaTg9NIx7H
TaURipmCTy2qqLMH+ks1aFUKAf4637D0BmMRYwBXiDfe4sIrbsOPsuRabwywK/N4
yQAbCLOzCtDhF8h1Wu9hv4aIpJOc1Jl0w7EaWW9dU2gleFQ+MYGiYPFPPJCJNhUz
CnGmMMhlb8uqJOsVbb4BiNm7pnv3jIeDhrz5N/I4G3QaPLlgCk0DvZE6FzOrKIf/
K/Cr5HTs8erV9BTJ+/KxyHFR2FOdfVRykqAROeBbkpTlwr7BkF+/7Oi7tOLNcpll
ni4ksWX/awYKsEzLJ0FoTIxfCe9fRSkCzDXtX9vm7hWi1yv3jatrIkmX1Tl6OjWL
aWvm/XH1ltofx5gd0O1qjkTcwuCocGFzcLe78tanWraAYFHrVJMtp3UKoPZoVJok
UqjFiREw3TB7glWhwO4GdKld1HPgNp4ZmsR1lWvq6+g3D87vZtrvNlmC3OsMrBvR
BJcjJtWt9vQm5WIsLFPUKEXmuG863BZJjkCMSX6vmJE8gxUj82iWURodzoq6WdQw
P3evTdaMppFSJKB2Hyu/
=foFJ
-----END PGP SIGNATURE-----

--Cg7YnprW40CakFnK--

--===============7831338852257164165==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7831338852257164165==--
