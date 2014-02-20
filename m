From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 037/102] ASoC: max98090: Use
	SOC_ENUM_SINGLE_DECL()
Date: Thu, 20 Feb 2014 11:27:00 +0900
Message-ID: <20140220022700.GP2669@sirena.org.uk>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
 <1392723517-12772-10-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5348352357743153018=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id E8BB1265719
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 03:29:49 +0100 (CET)
In-Reply-To: <1392723517-12772-10-git-send-email-tiwai@suse.de>
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


--===============5348352357743153018==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FJljVmEXxPquppt1"
Content-Disposition: inline


--FJljVmEXxPquppt1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:37:53PM +0100, Takashi Iwai wrote:
> Just replace with the helper macro.  No functional change at all.

Applied, thanks.

--FJljVmEXxPquppt1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBWfxAAoJELSic+t+oim9zNcP/jwVz+qqo5nBhFgrPfXIDM5P
y5kS/m813DN+WOUOKs/+MSLvV9KYz3fLTKav4XYSNFjMYSMrudwg7Cbfz/G1uPWF
tdUpVw8zfkvWhIfyedmDIFZ+eq8ITmZBepzpsZD91qhVB3KYyHL79ujvDkG4SJP2
9yBP6rOPQX8yCVKM8riDznQs1OHOkkg1jfoDSxJnuJmxIKXeA3fupKSibIyLXnKw
+0LW4vj/fxfas9X0HxX1r2cJKB/Yff/doBXDnu3MvePyEN7TdY+mFAfoIm5IMyl2
VwHFdW73Zf24WlHYnZ0WTiXqqCephwD6KGDY25V3aBHFwdkxNYHxsRjB/VB+W00k
WwCoQOsm8nKfKVMVIaQGzfuCymQj1UwKbtGTkJ67ubKjxtg4DqU8nFzNU1fvhNk4
cuOAt59Nrbn4Djmr0/vJOF4OKNU4lCE68qTdq11kZenVCfGmfzou5NbqzKQhY55j
h54uiDb8U2KWGBvSoOqpjCRDJaCDheByrO/nBvGKXi0zyfvRyatWBJRfhyf+x96s
JoL08p5LVDqNh6HSmnyLc3S+/vQSZKeYMcrC1EweHpveGGPH8X73CoIULWRVZK7o
iYnGkUc5QdHxjJOiaV0BvZfyM8enOBC40SuOshY0iQkFMgCXe+qtSnKsn6jvIecx
igRYJE7K/VrtSdNbLOTn
=gwSd
-----END PGP SIGNATURE-----

--FJljVmEXxPquppt1--

--===============5348352357743153018==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5348352357743153018==--
