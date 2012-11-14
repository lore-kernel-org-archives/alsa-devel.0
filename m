From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoC: ak4104: add reset line
 property to DT bindings
Date: Wed, 14 Nov 2012 19:57:19 +0900
Message-ID: <20121114105718.GL7407@opensource.wolfsonmicro.com>
References: <1352888919-25270-1-git-send-email-zonque@gmail.com>
 <20121114104344.GJ7407@opensource.wolfsonmicro.com>
 <CACTFLAM68vtG-oKjV+AQtyeROZx1Ouku+Bz4MsN3EGOz=2uPgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6976892450502023502=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5E5452652D7
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2012 11:57:25 +0100 (CET)
In-Reply-To: <CACTFLAM68vtG-oKjV+AQtyeROZx1Ouku+Bz4MsN3EGOz=2uPgQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6976892450502023502==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AQNmCumFClRcGgHG"
Content-Disposition: inline


--AQNmCumFClRcGgHG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 14, 2012 at 06:54:12PM +0800, Daniel Mack wrote:
> On Wed, Nov 14, 2012 at 6:43 PM, Mark Brown

> > This doesn't apply, the bindings file doesn't exist in mainline or -next
> > - probably an earlier patch you forgot to submit.

> I submitted that some weeks ago - it's in your topic/ak4104 branch :)

>   https://git.kernel.org/?p=linux/kernel/git/broonie/sound.git;a=commit;h=ac5dbea

I don't appear to have any such branch locally...  wonder where that
went.

--AQNmCumFClRcGgHG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQo3jjAAoJELSic+t+oim9gKsQAJFwFebGoDLYakUpZ1wuDr4r
YVA3Ikuo3ziTALx9/jntRZBw2CvL63TqMU4Nlz79iZflEI1f7fMhpZhoXcXL1v8e
pZY0G946/Mh8RI094aADa01hTHOzKEFbjQQqxoZrmbtLxhFwBz53Q7ChP6U9vK5W
UurT1A5N3ZJvZN4M194p5HBlkdVAUPkFZMqy4fl7i/7PhqeV+u1Zf1YrzYe2IK2b
RoMtBhZ+hXrOeYVTE2D/Y3bqi1AammC961cuFg8R/Aj1qW7OFuihX7u03RjlyDR+
sYsv9IDmB7n+8dSi6piZWTTbWqhe3oj+sl+/VQnACoEgIxh7UvzqECjXOULQr0up
6OvhHZz2nkcYjPJQBCMFJZ3m8rho1qpHrQB62RAXMD1L4FDNP1PBJVs2CMEHrbLu
wqFAUgyJubAXN52V/H0zZKKFIeSccgBB+/hBD9DsKqEVk66cRTQ3u1BpBdzRCu67
TBmQPVMG0AMJQTltYxXCQnQ5kSIA1zb9xgURXK1ggMnNpowQRlU4es+nJVb7yGXR
Exam7MXjsOstr9QiW6dBjFCDr04WXmFhyk/Cfw77OjcUVkZO+4qpWps7vI7zxl5H
EatcTZHkkGVs5AvKIbXb4RJxDSC7FcAAAx83FpM8eamzW5HEmYWFAepTYpUXE82e
dC2QU8d1kqCYqmpImv09
=VrQG
-----END PGP SIGNATURE-----

--AQNmCumFClRcGgHG--

--===============6976892450502023502==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6976892450502023502==--
