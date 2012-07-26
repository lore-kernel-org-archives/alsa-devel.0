From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 05/21] ASoC: ux500: Include the correct
	header files
Date: Thu, 26 Jul 2012 12:58:57 +0100
Message-ID: <20120726115857.GG3099@opensource.wolfsonmicro.com>
References: <1343298534-13611-1-git-send-email-lee.jones@linaro.org>
 <1343298534-13611-6-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6143405272656885033=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4912C265E92
 for <alsa-devel@alsa-project.org>; Thu, 26 Jul 2012 13:58:56 +0200 (CEST)
In-Reply-To: <1343298534-13611-6-git-send-email-lee.jones@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, sameo@linux.intel.com, arnd@arndb.de, linux-kernel@vger.kernel.org, olalilja@yahoo.se, STEricsson_nomadik_linux@list.st.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org, linus.walleij@stericsson.com
List-Id: alsa-devel@alsa-project.org


--===============6143405272656885033==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lIdIj/ncdD+VcXt4"
Content-Disposition: inline


--lIdIj/ncdD+VcXt4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 26, 2012 at 11:28:38AM +0100, Lee Jones wrote:
> Thought to be another merge error, board-mop500-msp.h has never existed
> in the upstream kernel, only msp.h. This patch changes the include files
> to match the existing file name.

Applied, thanks.

--lIdIj/ncdD+VcXt4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQETDwAAoJEBus8iNuMP3dWp0QAI35HBC1mXgHfopkpELya+2c
0zbB0kWAfNRjwoiT7tatgoAPFEFcCUzRJ/Ref0BuI/Vy2EkRYXnijSWgeRbjQ/UJ
xbsVh4cvC5FIsxZL2wYffGAY1BwaANkzU141q6iaRMMEJ8CkzlaAfiuUkSveQTlv
sSg4RoM9JDR4lnQDB8XEfYk62xpa6yLmloM+qx7F/AuU+FY74Tda/IxYFYQk2snO
cz9CcXiW0Vdjoyg5F+gMXUb3l8+FzQQfbm/CC26jLfdV+AGzG8cOqG/S5KeK2Rit
8XBaVlIy1VPyjAfsF/dFZWo3FuNOQdiB5WCwmvMltDjTjtSRIQ+I+H/l9vSuofGz
PlWYK4HerF4LgIGr5AyV5s1gVt5P4LlmjScMwld3bR87A4ENfPWAbOWRvomC5Gfi
UUPKUibNECpmQkcVs6qlA6ZUL1dRy110P2sq+yr14WdfspkFHIYDaG0zxpH/ZAtL
Sl8Ezan3GNCE+QoFaYjm8mZyKvF4tvD5dsuRuxks9cJShkkwz42g8k0WBXYxp7d/
6kXrR3rDakiW+Ba7BijAb9Cz21uKRqGhSoyi6VnG5Sre3eSF7Z8mEfuPJUERd0w2
tliJ5EeV+liB3ATm+LAatGsQuSvOYJi7p29P90MBCP320Lt51Bv5W5ds+UrSjkiu
zl3prGwEdMuItD1E5itZ
=i13L
-----END PGP SIGNATURE-----

--lIdIj/ncdD+VcXt4--

--===============6143405272656885033==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6143405272656885033==--
