From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: rt5677: Add the chip type to
 distinguish the setting of the clock source
Date: Sat, 21 Feb 2015 23:36:59 +0900
Message-ID: <20150221143659.GW6236@finisterre.sirena.org.uk>
References: <1423653531-978-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3980012580746843568=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B161264F3D
 for <alsa-devel@alsa-project.org>; Sat, 21 Feb 2015 15:37:51 +0100 (CET)
In-Reply-To: <1423653531-978-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: bardliao@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, flove@realtek.com, john.lin@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============3980012580746843568==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6B5oiwbC31sfIr4n"
Content-Disposition: inline


--6B5oiwbC31sfIr4n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 11, 2015 at 07:18:51PM +0800, Oder Chiou wrote:
> There is only one clock source in the rt5676, so the chip type is added to
> distinguish the setting of the clock source in the VAD function.

Applied, thanks.

--6B5oiwbC31sfIr4n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU6JgKAAoJECTWi3JdVIfQg+QH/0ZjzXdiYKOUXz4j+3ujaK97
HilrnbQpUrOm7hl+LIdp1/2S/KFBF/Gj8vwZzW6B91FcsjS0jPnls3ihmzSth1tU
SPn7DtE1bvzPtQoWpd26NCTv9P6NXTq7ubH0n7qlfNISeYbOTbFG/rEQ86VtTLQM
1+EBOxMTUsnwcsEKzwJVVrMaRulHCGuRiukwdBdqHflCKH58J2arbv3Fpy4NzQxd
q1rs58kp2FXvZZCrFhxTg8lHHMKd61ueKs1bsi4sF+WseGkS4Pe3YHucSs1DOg0R
lYxFiz4Z3JWBlo0T6KHZ46ah9edLguV8iqPk/8+iDwlsaRVDuipGdyR9vKJcCGM=
=PPKk
-----END PGP SIGNATURE-----

--6B5oiwbC31sfIr4n--

--===============3980012580746843568==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3980012580746843568==--
