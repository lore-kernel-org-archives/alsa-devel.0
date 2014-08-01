From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Add dependency to DW_DMAC for
	BDW platform
Date: Fri, 1 Aug 2014 19:11:42 +0100
Message-ID: <20140801181142.GE30458@sirena.org.uk>
References: <1406904859-30514-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7063419197180921200=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B66126576F
 for <alsa-devel@alsa-project.org>; Fri,  1 Aug 2014 20:12:31 +0200 (CEST)
In-Reply-To: <1406904859-30514-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jie Yang <yang.jie@intel.com>
Cc: mengdong.lin@intel.com, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============7063419197180921200==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FVm6dlxF4pQlpRQl"
Content-Disposition: inline


--FVm6dlxF4pQlpRQl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 01, 2014 at 10:54:19PM +0800, Jie Yang wrote:
> Add dependency to DW_DMAC for broadwell machine, which
> have built in DW dma engines.

Applied, thanks.

--FVm6dlxF4pQlpRQl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT29hbAAoJELSic+t+oim9WVcQAJDE27XxTwj3JCPFGqKAhPyd
7ukElYpEF55AErTyAsT6kIMd480uAnFOW9qs6UsTb8lfdhN3YTz9oZ4jpWObxvRE
DqalDagVov5eiVsXZNZITYiPZ/qSIkMwp9oxd+F+CVmjyoh+PNk01VzKoOYqGRgt
VGnSI7z5WzPL7SSkMJO9OtIWOk+HtJGU5iybtT5Xkg+Nq4ivQIBnVCCZOn6LZMuW
jMzWkxyeLgAPAEw5KcgQk4sqfOj4TawQ+WoYB7GVnypZWNolT7vFb69ONkMM+UJh
/++HWimjEj+juGEwRIp6ijwf7dAEMN8ZNcjnIY4I0Ef3HuB5Fb/iPOtLO3fxiPcq
Hn9EkUanCW13zl2bO5B1ZM4FP2PgtcVCI6mY9/QbL2DDc8NR8+QZC/JRNo2zWhXz
7DQGztvEzZ3U0/CiaFK9Zm+N3IecPMywriHG2Je23eb5DzemH9syMi2wz3UW58u7
JlmGhn1iglnl0OFeVzd8gg7H2R6X3xOnI3V4bp6YypV8DRmgJZMDvuEK0yuhPi8d
+jeDFeWUTCE2mAMcutkHbxBSyw4SeSKrTu43kwe0RecT9JWkxmRUPQaAWARSSYcv
tqtR2m9t55l+sZWH/ml823nEpZVF7uXexOp3H4DmgGP9oYggvCXh1+WczfZHUPe3
WpDGAtMOE9rIKExU+0MY
=3hD+
-----END PGP SIGNATURE-----

--FVm6dlxF4pQlpRQl--

--===============7063419197180921200==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7063419197180921200==--
