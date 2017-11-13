From: Mark Brown <broonie@kernel.org>
Subject: Re: [GIT PULL] ASoC updates for v4.15
Date: Mon, 13 Nov 2017 17:20:02 +0000
Message-ID: <20171113172002.bi2etkkkkhtvkses@sirena.co.uk>
References: <20171113115242.pmc7asf4yumj5ubk@sirena.co.uk>
 <s5h4lpyb2e2.wl-tiwai@suse.de>
 <20171113163014.qtdfgpqiign5xahk@sirena.co.uk>
 <s5hshdi9lvr.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0967361021589688110=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 57B772673B5
 for <alsa-devel@alsa-project.org>; Mon, 13 Nov 2017 18:20:03 +0100 (CET)
In-Reply-To: <s5hshdi9lvr.wl-tiwai@suse.de>
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


--===============0967361021589688110==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fb6ilvj5nyjuffn7"
Content-Disposition: inline


--fb6ilvj5nyjuffn7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 13, 2017 at 05:36:08PM +0100, Takashi Iwai wrote:

> My understanding is that it's git-request-pull containing the marginal
> stuff that annoys him.  He usually compares the diffstat between the
> pull-request and the actual merge result, and it doesn't work when the
> pull-request already contains the old commits in itself.

That *should* be fine for my stuff since I do merge back up from Linus,
I'd expect the diffstat I send to be the same as gets added by the pull.

--fb6ilvj5nyjuffn7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloJ1EEACgkQJNaLcl1U
h9ArNQf/Vu4ZDWXSoSf70alhj9uHhTAq7BiWfZ35jnNb1mp5wrla8HzYtpoHyJ4j
K58BgrIHlDXngVPD/x+0Ql4Vo7j0I7oXhyVMihUHiaJn/ukkvdhgd5uWLVJEqCHn
vCWeq3WFrq5WZ1qFPm9bnXs3u/3u5+uPh5yZDUEEjwxTNiKuBg20bVEZIxejlKb8
xzs//HeNvqcdL2ItwdmXdf9t21WgEfEm+Y0RiM0HN4z7Td/xFgSJ6XgtAT/czoTl
p5BbBA6iF5B1Ax2UvcInkijwtI2EU+5aqDLercj/j1122F58DUh9s7mtygzl3I4X
5tppZTvLkY232mFZ3vDBpAeesWDf9A==
=XdWB
-----END PGP SIGNATURE-----

--fb6ilvj5nyjuffn7--

--===============0967361021589688110==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0967361021589688110==--
