From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [RFC][PATCH 2/2 v3] ASoC: simple-card: add Device Tree support
Date: Fri, 1 Feb 2013 01:21:53 +0800
Message-ID: <20130131172150.GC15376@opensource.wolfsonmicro.com>
References: <20130129014808.GC4748@opensource.wolfsonmicro.com>
 <87sj5k3f83.wl%kuninori.morimoto.gx@renesas.com>
 <87obg8z4u4.wl%kuninori.morimoto.gx@renesas.com>
 <5107FF97.1070601@wwwdotorg.org>
 <87halz82bm.wl%kuninori.morimoto.gx@renesas.com>
 <51097F0F.2030501@wwwdotorg.org>
 <20130131013500.GA4759@opensource.wolfsonmicro.com>
 <510AA551.30400@wwwdotorg.org>
 <20130131171158.GA15376@opensource.wolfsonmicro.com>
 <510AA720.9000904@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9002805426501769238=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <510AA720.9000904-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--===============9002805426501769238==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CblX+4bnyfN0pR09"
Content-Disposition: inline


--CblX+4bnyfN0pR09
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 31, 2013 at 10:17:20AM -0700, Stephen Warren wrote:
> On 01/31/2013 10:11 AM, Mark Brown wrote:

> > There's more attributes that we might want to configure on the
> > devices than just the actual DAI link.  Clocks for example.

> Sure, but this binding is *simple*-audio, right. If the intent is to
> create some more general/all-encompassing binding structure, I'd want
> to think about it and review it in a different way.

Right, but things like the clocks are basic enough.

--CblX+4bnyfN0pR09
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRCqgmAAoJELSic+t+oim97ScP/AnEshtmbNWW+oE9Ay5as8fe
A161X3Xb7ncvPBJhDhpnqVtc4q//e8lz8IBokTiGqT862FQvInmYkkfMC+HrN1s8
HHaDKulo1miJ0Yuhu/tXWdl5GIcmu/TDdfg7LD5CATMfbZVWd4FaQIIKQGhOzbV6
yfZ2CWBxOnZ1wl39cy4vBFlwGNWGlO4MDpJq5WSrNbO76PwP6WArvrSnebzaXxWe
1202alQXla3XIMuutIcW5XJSCld3/txGorortA1dm9FtpmCSPwrJxSU6u+Tk910M
9A0PMRqnnfQoTs663ff+bWrlTkNr9vfUK4JzBELdrpGWCkBcSTPesHfhr+/277wW
mjUtTgoh3DxH7+LSOi+gRD+cutp3kjG+CmCDdDttqtjkjVR5rZYL25XzjwsR3beW
UThyFlon4xi1xzZgiC1DmmLw7axZ/kZvjWrr7aVs5jIVcyFo6boOUa33nKVqfKPl
KifhU0mzWPhJndW/aFxmDRMkaTuwEzacIj2rsC1gu1f2vvRzAQg01TdSJDXxkKT2
fNEh4So4dhE7acmvOXwboQaev4EIjCKCeOnLEJ6uXutWV656gCCSjdeCV2He72r+
gtgpuC4ZtyVWfGvgTU+7HagCNLPxg/bGvHcZTyLDbAEFGvR9JWsikJXQAXLpKdy2
d0JzXv5BdXyDl3GYYZnN
=y1FH
-----END PGP SIGNATURE-----

--CblX+4bnyfN0pR09--

--===============9002805426501769238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============9002805426501769238==--
