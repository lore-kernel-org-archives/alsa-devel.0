From: Mark Brown <broonie@kernel.org>
Subject: Re: Applied "ASoC: hdac_hdmi: Ensuring proper setting
 of output widget power state" to the asoc tree
Date: Mon, 15 Jan 2018 10:30:40 +0000
Message-ID: <20180115103040.GB7333@sirena.org.uk>
References: <1515670468-9198-1-git-send-email-abhijeet.kumar@intel.com>
 <E1ea6ZJ-0003BS-KB@debutante>
 <20180112212012.GI21458@sirena.org.uk>
 <20180115061216.GS18649@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8973306642741232971=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 83667266FBD
 for <alsa-devel@alsa-project.org>; Mon, 15 Jan 2018 11:30:58 +0100 (CET)
In-Reply-To: <20180115061216.GS18649@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Abhijeet Kumar <abhijeet.kumar@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Takashi Iwai <tiwai@suse.com>, Jeeja KP <jeeja.kp@intel.com>, Sandeep Tayal <sandeepx.tayal@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============8973306642741232971==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 15, 2018 at 11:42:16AM +0530, Vinod Koul wrote:
> On Fri, Jan 12, 2018 at 09:20:12PM +0000, Mark Brown wrote:

> > I've dropped this because it caused a conflict with the topic/hdac-hdmi
> > branch - can you please check what's going on there?  I merged that into
> > the topic/intel branch so probably just a rebase is needed.

> I do not think this is ready yet. Takashi and me have few comments on
> this...

There were comments on v1 but nobody responded to v2.

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpcgtAACgkQJNaLcl1U
h9BxYQf+JviD7o31KUnHvgB18j4NyJWNn4WRNw7PN9CKXqSVl5ylMwPhq0QHilTl
R8lRg/be4RvdKqf5D/MZGiH6zGf5W8MSzkAqAaZ4FzXierQa3E0g+JMZTzn6q5OQ
gfdsi6tjCQy9Qy7jJnQy8CRCYwHWrbD/PZWid/krJvwOK9dxmDXzHYvtux0Qr9JS
70ocphztICGWg+RyVOdo4qvi5ZHZmLFprz8RP4JJCSNCvMmVKBj3uUFugIdPx2PQ
cDKdIK5Znx/I3YmNdNzar7hXfMF5FMWHmFD93E9pemJuFxLKes9dHFP/byxObvkj
tHiWE5Lt8xNmQKowAfxLrS9XjLRPrA==
=VezL
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--

--===============8973306642741232971==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8973306642741232971==--
