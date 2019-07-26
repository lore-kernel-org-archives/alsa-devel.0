From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 7/7] docs: dt: fix a sound binding broken reference
Date: Fri, 26 Jul 2019 13:08:41 +0100
Message-ID: <20190726120841.GA55803@sirena.org.uk>
References: <cover.1564140865.git.mchehab+samsung@kernel.org>
 <9932608f32030c886d906ea656eda8408c544776.1564140865.git.mchehab+samsung@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0710924350089899933=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <9932608f32030c886d906ea656eda8408c544776.1564140865.git.mchehab+samsung@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Maxime Ripard <maxime.ripard@bootlin.com>, Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============0710924350089899933==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 26, 2019 at 08:47:27AM -0300, Mauro Carvalho Chehab wrote:
> Address this rename:
> 	Documentation/devicetree/bindings/sound/{sun4i-i2s.txt -> allwinner,sun4i-a10-i2s.yaml}

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl067UgACgkQJNaLcl1U
h9DZ3gf/XVyELAxpK+iOsyrIIgOtkynK4H9wknGxpl2rZE0a6qJHb4tUp+EVM5k7
BP3tcLa5QVeuWG3k2rqMwoL86wXC7QLc+So1k5s612+LqO7tkgHRPQv0fFZFYFU+
iQ7E6+MUeBW4LoqA4pSOQvpeU7oNy4amI/X639LTk7qjrTwnmwcH5aagkPRGOvPL
KC+Hf/saAF5T9eue6updywRGYPWffVpQkoCO6NpwfWMk5UV071OneiL3SKXf/y+2
7ZgIh2qwDFvkrpgmTUowa8D+iODO0/P6YP3m7Q8WZXS3YBSrnp0c9pDUUG38QVVG
jB89EPyDbXAjR7L2WTMO1GCnC/j9Dg==
=gcDY
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--


--===============0710924350089899933==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0710924350089899933==--
