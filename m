From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4] ASoC: rt5645: Check if codec is
 initialized in workqueue handler
Date: Fri, 17 Jul 2015 12:12:08 +0100
Message-ID: <20150717111208.GK11162@sirena.org.uk>
References: <1437100617-37845-1-git-send-email-drinkcat@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3874806397773999051=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E3ACF2606E0
 for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2015 13:12:20 +0200 (CEST)
In-Reply-To: <1437100617-37845-1-git-send-email-drinkcat@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolas Boichat <drinkcat@chromium.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============3874806397773999051==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IrYWVTOpV5r4MFme"
Content-Disposition: inline


--IrYWVTOpV5r4MFme
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 17, 2015 at 10:36:57AM +0800, Nicolas Boichat wrote:

> This replaces 3c2234569cfff83718792f810a9bb855b78c2473, and applies on top of
> Linux 4.2-rc1, so that this patch can be applied in its own branch, without
> triggering a compile warning.

Please provide human readable descriptions of commits so your mails are
directly readable.

--IrYWVTOpV5r4MFme
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVqOMHAAoJECTWi3JdVIfQxT4H/2Ispnh4X2dHmO581O7BcSRY
/pWcKAdB6jK/zubmM8erQFKot+K0NuSEMvP8F9qNKBAKGyw10TTWp2enqJvUAyZ0
7KJkxxmprcUmYQ1GggxDTrvksFoFjxbGTa67jZixqMOXYNyFm8syi6jWM3cNIulT
ohJdVd/cK+PBf69YPFzDw3czYoonG3n6TwIIbXdORFqVG1eBvixKScCMiZSEByIf
5LJPXdN3c8xF3yILnAtA100ujD3ig1JSLw+ynvc/lY3BOCR6qo5WvZZc9AVV8/X2
Xkp2+CJwpSK51CAHaVGcQcOvm3loBwaN3b9EGx+jGXaHEYwwsAHt+fjW9xVNXTM=
=EvKa
-----END PGP SIGNATURE-----

--IrYWVTOpV5r4MFme--

--===============3874806397773999051==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3874806397773999051==--
