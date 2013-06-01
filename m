From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] dma: Add a PAUSE_RESUME capability
Date: Sat, 1 Jun 2013 20:00:00 +0100
Message-ID: <20130601190000.GJ16790@sirena.org.uk>
References: <1369827743-5533-1-git-send-email-lars@metafoo.de>
 <1369932575.3890.18.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9107927402359252049=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 55AC4261ACF
 for <alsa-devel@alsa-project.org>; Sat,  1 Jun 2013 21:00:14 +0200 (CEST)
In-Reply-To: <1369932575.3890.18.camel@vkoul-udesk3>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: Scott Jiang <scott.jiang.linux@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org, Steven Miao <realmz6@gmail.com>, vinod.koul@intel.com, Liam Girdwood <lgirdwood@gmail.com>, uclinux-dist-devel@blackfin.uclinux.org
List-Id: alsa-devel@alsa-project.org


--===============9107927402359252049==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YPJ8CVbwFUtL7OFW"
Content-Disposition: inline


--YPJ8CVbwFUtL7OFW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 30, 2013 at 10:19:35PM +0530, Vinod Koul wrote:

> - This mail-list is not correct for this patch
> - use get_maintainer.pl, if you dont know but you already know!

These two bits of advice unfortunately conflict with each other a bit if
one of the lists involved is lkml - since lkml isn't listed in
MAINTAINERS and is always added implicitly get_maintainers won't tell
you if it is actually a list you should be using as opposed to just
something that it shoves on the end of the list of addreses (which most
of the time means it's not actually sensible to send there).

--YPJ8CVbwFUtL7OFW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRqkStAAoJELSic+t+oim9jJMP/Rny8wSL/YM4g0np5rkPqg72
yGquSfYUtTlk+sv2ZBfEYGDtnEdwMCf70gv2lt5fD8kCHv355IxFKmTkRAvFylh5
aPPf+d12vd/TesRP8UvwlTwLLVF32FSowU7OEAj1vuGbnKgsAc8WwZTUMRCjw7iO
j9fPTdAN0kxFS9jQdpmxk2TEPGzX4NBKE0ppUPF7AWsZpkXc2wdv6oQDQx58Z0VP
yWu7B8tsqKks+xJ+6zeLaBpn59LL+jzEYGs/Oe4ZKOdTyv2VMQK+b7emscfzaYOu
gXXb5ogdjsQV209VUns613JWD1xjH4ybb7Wbh2qaQ8ay/ZGcw7ieQlDPbmYVAdY+
6mltLahKbjTkmOtrFVjaPIlo7h2KADnCPgIiwidsSqzEmmSlNkZQYBZr/+27KpCa
eXwlxxfQYWPdyo8/+U+eg30GZHSJ/0JB6/+54CYnTU6sxzaBn5kjYpcdJ0UDEuIl
BTtM8qfWeADnI+KU6c8ZxyJIoTOfMGfrPVPLbGn6gwTujTkU6jyU4mhfZTUpdKtr
SojKCbp056c2vAPXh1kLpqif4ckdf7HoaYlSzE2pSXSJ9liIsADeKYrqkJWS30vQ
3hXDSyQby+7ucCwOA8+7jyN838PvhBowSkI/ooHw5dFtQHIHbT7g+XcNSbOzb3us
EN4n1EQkkr/z59VUgnjj
=vsJ7
-----END PGP SIGNATURE-----

--YPJ8CVbwFUtL7OFW--

--===============9107927402359252049==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9107927402359252049==--
