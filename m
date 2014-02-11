From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/7] sound: codec: add Device Tree binding to cs42l51
Date: Tue, 11 Feb 2014 12:35:22 +0000
Message-ID: <20140211123522.GM13533@sirena.org.uk>
References: <1391102051-5319-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1391102051-5319-2-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4766034334340816038=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1391102051-5319-2-git-send-email-thomas.petazzoni@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Liam Girdwood <lgirdwood@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4766034334340816038==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dzI2QqkSBOAresgT"
Content-Disposition: inline


--dzI2QqkSBOAresgT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 30, 2014 at 06:14:05PM +0100, Thomas Petazzoni wrote:
> This commit adds a trivial Device Tree binding to the I2C-based
> cs42l51 sound codec, so that it can be used from Device Tree based
> platforms.

Applied, thanks.

--dzI2QqkSBOAresgT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS+hkHAAoJELSic+t+oim99WgP/0xx/IXIJ2qJXxh5V8+miagm
WM+k5aKdkSRR/ym/8++SFJktU64fYMolkIC61PIKyjAmTDEJ6U7R+S40C4DT0l/O
W4IjenjPoUGqVHOwVFk2ZRF/i+5h6c9SBZrNg8lqR+icm+cYiWeZ3WxA08ys+Kfq
fof2lJP646fJNKpzFsDcSQWc47OiP5/fokwfUUAVoWwdyemWegelYZZoCrtsCC/2
Z05/JWhCsovCeiu0haPtFCJQic3JpYfWK+7G4Ku2akH9dJQqOj3/ZI8P5w481voc
daUm9asSuj/I1VhusW/YgYNWK/B6A7+9V7TCvt/xyoMJftTEHvc32u6x2KSVIm1a
DSBVhPPvfG96Zt8bEmTJTX9ua9CetEIZ02AKzkjoMFchrfo2P2M3DLswCgnpWut8
Ww7PP9Z0ot6TQAwgWaU7t89L9sqLpN0BOzUzZxYFn1xyu8YKqpqxVVPqkJqpNilM
OnUFPLX5cuttggMosdrqMeJrkMZv5maoVqKcCu3UH40g9YgvUMhdsTzoH4/NI/ny
vaUNQPlr6SAad05fAVc+eO7wzq1WB39gVn7W1FYjgtKh+a+c/zsWcby/7rquGLhC
5jErKJjNeci34sR91Mguc4+4zK6Y3DdWu/9yiBX48TZq7/chwQk5q7+xIzFImPlk
b3FbfyLlvC5nRFRWyXP0
=TffU
-----END PGP SIGNATURE-----

--dzI2QqkSBOAresgT--


--===============4766034334340816038==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4766034334340816038==--
