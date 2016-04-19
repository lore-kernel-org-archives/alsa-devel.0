From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: sti: update dt-bindings for tdm
	mode
Date: Tue, 19 Apr 2016 17:53:37 +0100
Message-ID: <20160419165337.GA3217@sirena.org.uk>
References: <1461067181-23577-1-git-send-email-moise.gergaud@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3503598816443394907=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DB0CE265182
 for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2016 18:53:43 +0200 (CEST)
In-Reply-To: <1461067181-23577-1-git-send-email-moise.gergaud@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Moise Gergaud <moise.gergaud@st.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, arnaud.pouliquen@st.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3503598816443394907==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JbaLeU65fPBt7QWN"
Content-Disposition: inline


--JbaLeU65fPBt7QWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 19, 2016 at 01:59:41PM +0200, Moise Gergaud wrote:
> - Add "TDM" in the st,mode property list
> - st,mode property is also mandatory for reader
> - add tdm playback dai-link example

Please don't resend patches that have already been applied.  If any
changes are needed please send incremental updates.

--JbaLeU65fPBt7QWN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXFmKNAAoJECTWi3JdVIfQJUQH/32CShhq0fgYBfMZJJ66TiQD
T/rhrCoEm4v8dh/ucB55M7VoxQVhD2LFwvyLWjyNUbSYk8n355vYX4gz10QXrXDV
sqn+9Vp0nkg0+x6Yfbp4hOHra79oYzrWCi28OAqRJIy+p207PUL7IZ6ehLZbcIny
r7uNxJkGxlJ+EsHhiG6glewSawDMBypT40BMDL7UVOn+RyvIbkKw23yM0UDqchgo
gy9qrGNNfnai2GYzpQaEy3m03YeBOCONTt5bdVBY+M6MPbWgUGlatMPMAdfFYIAG
3w66VAZgA0Lwxg0nQSWgwgD0NjXRK7gtskgcmmn9Xve2HO+xwbYzJXZnFqk5ltg=
=iQEx
-----END PGP SIGNATURE-----

--JbaLeU65fPBt7QWN--

--===============3503598816443394907==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3503598816443394907==--
