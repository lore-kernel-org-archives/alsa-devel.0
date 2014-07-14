From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/7] ASoC: Intel: add sst shim register
 start-end variables
Date: Mon, 14 Jul 2014 19:45:22 +0100
Message-ID: <20140714184522.GX6800@sirena.org.uk>
References: <1404898076-1882-1-git-send-email-vinod.koul@intel.com>
 <1404898076-1882-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5737222061555189950=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8275E261B02
 for <alsa-devel@alsa-project.org>; Mon, 14 Jul 2014 20:45:39 +0200 (CEST)
In-Reply-To: <1404898076-1882-2-git-send-email-vinod.koul@intel.com>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5737222061555189950==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LmcuB6YxSMQAV95c"
Content-Disposition: inline


--LmcuB6YxSMQAV95c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 09, 2014 at 02:57:49PM +0530, Vinod Koul wrote:
> the shim registers start and end can be useful while parsing the shim addresses,
> so add these

Applied, thanks.

--LmcuB6YxSMQAV95c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIbBAEBAgAGBQJTxCU/AAoJELSic+t+oim9wJgP+Puhp5Uyu7Qw2ZeKDC2ZtPO+
IJkOzI26glrI9+Iwq0NYrJFexUtoN/snjfvltco2Sh0Z+iqDpukWvucs8DF+cWaL
BnIkxoTKKWvNizmshg8rda5TyrXX3FchLNaZosaAUDlqxcX5X9CKDOe8opuRfInA
OP1tm8QWggEycLmKkChJZ5Krhmz6zoqcTadBd7TEJ8quETRhnryHDIsQp9KUk3uJ
zWfsusJTBtrx1JYK4SBBrMLww4Ep27Z8O6cToyPxz2Knv6lfjk2x9YhmQ7VlO7Pm
0C8vdiNs3tKGHQ1mhf/7VD8e9baCYxTlUXHeBS3OgMpnH5hKxKJyKK229bku8k93
WJuEr6vGmU38NF9Fzpq++YhFTo4/JgpjDjJ1GBy1SKUiwE/Q9FVLTho7YZ8np/00
8kbAPpNUFp9Ip0jMd3F9kwNcM2/trBSKu5glOLeN24euS2Z2xp28ay2GwNch4H9o
210+G6GzkXnUBqiKWNqxs94HSQUReEZVtQHwqbNyUhH1NWCAbHmWRew1xv/VoAUU
r5XOApgKuH76JUcLatEwUrfBqaeEf1xJS60GuAciU9UCLO0Xpn3NlQbVNWmmpaiQ
WFVunF1QcIIm+bj36h1YeAqarkNS9WmqnPz2jJ45Q3PMegWUVM8w8ExGkANI9xiR
sP135/VPc4BkmdPXZaA=
=F7ke
-----END PGP SIGNATURE-----

--LmcuB6YxSMQAV95c--

--===============5737222061555189950==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5737222061555189950==--
