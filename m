From: Mark Brown <broonie@kernel.org>
Subject: Re: Audio mini conference 2014?
Date: Tue, 26 Aug 2014 11:19:53 +0100
Message-ID: <20140826101953.GI17528@sirena.org.uk>
References: <53EA6165.3070902@zonque.org> <s5hbnropcvd.wl-tiwai@suse.de>
 <20140813165517.GB17528@sirena.org.uk>
 <20140817231021.GQ14537@sirena.org.uk>
 <s5hha1aw6we.wl-tiwai@suse.de> <53F1B892.5080109@metafoo.de>
 <53F1BA5B.6070400@zonque.org> <s5hbnr7u5xp.wl-tiwai@suse.de>
 <20140826084220.GA17528@sirena.org.uk>
 <s5hvbpf5zn1.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7779437927764675972=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 94EFC26507D
 for <alsa-devel@alsa-project.org>; Tue, 26 Aug 2014 12:20:08 +0200 (CEST)
In-Reply-To: <s5hvbpf5zn1.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: =?iso-8859-1?Q?Jo=EBl_Kr=E4hemann?= <weedlight@gmail.com>, "Austin,
 Brian" <Brian.Austin@cirrus.com>, Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vinod.koul@intel.com>, Tanu Kaskinen <tanu.kaskinen@linux.jf.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Paul Handrigan <paul.handrigan@cirrus.com>, Daniel Mack <daniel@zonque.org>, Arun Raghavan <arun@accosted.net>, Dylan Reid <dgreid@chromium.org>, David Henningsson <david.henningsson@canonical.com>, "Alexander E. Patrakov" <patrakov@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7779437927764675972==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ykeeQfsKCRyAS6o+"
Content-Disposition: inline


--ykeeQfsKCRyAS6o+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 26, 2014 at 12:11:30PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:
> > On Tue, Aug 26, 2014 at 08:21:38AM +0200, Takashi Iwai wrote:

> > > - Code removals (Takashi)
> > >   There have been actions to remove the codes for old hardware
> > >   recently.  Which is acceptable?  Feature removals, too?

> > Linus was muttering about ISA sound card drivers.

> Interesting, I thought Linus doesn't mind much about such "dead"
> drivers.

It was because they aren't automatically probeable without loading the
driver and taking a look at the hardware - if a distro wants to use them
it ends up having to load and unload the module.

--ykeeQfsKCRyAS6o+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/F9GAAoJELSic+t+oim9zL8P/1SqFROmuHX8T3+rWh3FII0S
rdFzWA0rg8ovkKsUG0wJ61+t1PMjpdfuE81rOchlagWmwogidcG6AowJ0VLvNmEF
wujWbyMdtYUb9CDuiEXEHR4andgFbSFiUfe78FpXqSrsryqqLlvsWPzsVtgaMPJF
zufOVPrsAFB6bEhum30nr7qGa7Ufk9JSm/YpXenudGRPJajVShn3uWQilCRi1BDl
IU4elfZOrfR80a3s97uJWg1g6X7phtfAf7skGis3OTQ3ZW13UjDoaGxIr4dyKeD+
O07xsTX+djtAVxMChv3EZOLi2SFP0QL3y+yjCAgfkQbqKOYxKdw4HepoLiBnMkMA
QMAZrsCSuvgtzgQehyN42rkTQEO/JR9bJwhv4GyO8UFVOaCSeUdUbuKpdh6jGpQ2
AbwD7x5nAbuZnGovmahQl0Zj9ubXNSTq01tBm5HBQWfcp14yExRRVULTg1MtxuO6
Mpx/xSyunTzRiN7oz1ir48mqTCdkAhMrL+6krFSsh5Km+tF6ErSFVKF6c6smdUkB
iztIzB+f7qDlzrCwp4KvBK2PCOSAl3qWrY08rCy8UxxAnWUcgZLYfW9VnBX+omDn
FsHT6eRS26kz6SQbqxeKNeDkUN3Iw+EhRbTcjPfoqD/BFMwyaLIjoWW4w9kQ2y+h
9uJ70Z4Fm54GODiQe7mS
=hNv6
-----END PGP SIGNATURE-----

--ykeeQfsKCRyAS6o+--

--===============7779437927764675972==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7779437927764675972==--
