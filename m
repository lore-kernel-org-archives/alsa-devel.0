From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 075/102] ASoC: wm9705: Use
	SOC_ENUM_SINGLE_DECL()
Date: Sun, 23 Feb 2014 12:05:02 +0900
Message-ID: <20140223030502.GP25940@sirena.org.uk>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
 <1392723517-12772-48-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1615848912674950868=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5365C26593F
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 04:05:13 +0100 (CET)
In-Reply-To: <1392723517-12772-48-git-send-email-tiwai@suse.de>
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


--===============1615848912674950868==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sVDvLV9WCSBfEyVB"
Content-Disposition: inline


--sVDvLV9WCSBfEyVB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:38:31PM +0100, Takashi Iwai wrote:
> Just replace with the helper macro.  No functional change at all.

Applied, thanks.

--sVDvLV9WCSBfEyVB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCWVaAAoJELSic+t+oim9upYQAI5kqwN0XTjUFs6j0csNa6DA
0mxPwKwnWTLr+m984JCV0Aic2WyPopRURDNxyUGuL7JN5n2NRu+Qo0TyLb2+rTUm
en0yP0fFJbX9lYXLhwP/4shE3Idp/EMXrvDAbXoReuxlgcWA/JXvAqDnVr4dl/u7
V9pxtUMj9qv48EoMmZaDe32gECa9KiJwbTbZpNmDllf7ix7yI6u3zFb/ausriF1q
umoo/pFO3M+pm5jPeOC9T7pd+hJrhIq9uoDUTM3S8uQ2LIXWuzHfRl13MtHpWq1B
gQihI+EmMFPTBuqO41uz6BozAxSyVI/2DXRW4Wzg5+9DYb6DaKYe9gkIX5Y1gP/R
aeOq3FNOr9v+5iQGRZjgdh3WZLlsdsW6WMPLMpgz1VOLV5rwe4DHtIYLXWePvNvZ
VRlemANbXOCyQNVKgRCoCidF4RQxDYT6nOBFEEzxwrQSP5PiygUw1WBfjXfzkAeI
HCTDLaNIgFxOBGj8tQCunqXNKjRMrziyDsHarp5fKGLGpUYYKfN13D9bAGQ/3zXd
GCmVWRBSTHArOyrzaPEBKlVFImUc4LFTJ1uZxbASUWTBfyiTBxt3ikFyB9kY/sly
Bz9nJJSaFkpR0WBC0k4tBjKXS3Z1CeV2faBTgLpW9bypJV+0fR9eWiJAq5ah9dDb
h/FZl95A7ldMXWm4T0sc
=uLHw
-----END PGP SIGNATURE-----

--sVDvLV9WCSBfEyVB--

--===============1615848912674950868==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1615848912674950868==--
