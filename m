From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 05/13] ALSA: hda: check stream decoupled
	register state
Date: Fri, 16 Dec 2016 13:02:49 +0000
Message-ID: <20161216130249.b5iwaia6nfysmawp@sirena.org.uk>
References: <1481184684-9620-1-git-send-email-jeeja.kp@intel.com>
 <1481184684-9620-6-git-send-email-jeeja.kp@intel.com>
 <20161216083449.GA11902@kpjeeja-desk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3591570413432379262=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 642E026688A
 for <alsa-devel@alsa-project.org>; Fri, 16 Dec 2016 14:03:00 +0100 (CET)
In-Reply-To: <20161216083449.GA11902@kpjeeja-desk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============3591570413432379262==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hkfgegjrcaufcn6z"
Content-Disposition: inline


--hkfgegjrcaufcn6z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 16, 2016 at 02:04:51PM +0530, Jeeja KP wrote:

> I have fixed the comments on the V2 patch.
> Can you please ACK this patch of this series if there no concern, as this=
 on
> on sound/hda/. I think Mark is waiting on that..=20

I am, but I think Takashi might be on his Christmas vacation by now.

--hkfgegjrcaufcn6z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhT5fkACgkQJNaLcl1U
h9B/mgf8DB/aFeqHQ+ZUUqOswMDbN4+H2zEIYaYHJEDqkAq7AMlLddZSNjZa+6/l
6mTRk4Llm3lDBFLmdWy+tPoyYhJA3MK3JWsJZAF8Sg/dJUaF/J/hQQb7herHU1tK
VMNpe8RW78Qc6pLoFIVPboXN2Dt/QfFu4OZc96QL7bEmlueWrl0vdgaOMjHPw/ui
dloajwd3RaQApTnXZ3eVlTT1czq758oiaLMoLk8Gmk0oW3HsELQfjt/2wyA1j3Lv
1IS8OynIf8p0gDmGEBntT7+tWpd2k9WphcB77nh2iOH0FS45JfIjt8iiQdY0swG4
r1bWzPyVPXQ+YIzcdeEa3nZPDbPmNg==
=DVSF
-----END PGP SIGNATURE-----

--hkfgegjrcaufcn6z--

--===============3591570413432379262==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3591570413432379262==--
