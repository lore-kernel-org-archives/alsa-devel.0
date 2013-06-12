From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2] ASoC: rt5640: add device tree support
Date: Wed, 12 Jun 2013 19:25:33 +0100
Message-ID: <20130612182533.GS1403@sirena.org.uk>
References: <1371058470-25100-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7790958259095699690=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1371058470-25100-1-git-send-email-swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
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
Cc: oder_chiou-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bard Liao <bardliao-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org>, flove-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--===============7790958259095699690==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7JtmyEQckRKrnqj+"
Content-Disposition: inline


--7JtmyEQckRKrnqj+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2013 at 11:34:30AM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>=20
> Modify the RT5640 driver to parse platform data from device tree. Write
> a DT binding document to describe those properties.

Applied, thanks.

--7JtmyEQckRKrnqj+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRuL0aAAoJELSic+t+oim96XwQAIxk6AMpo/wMwXd693ej8n2h
iIPS4AtuVDvnnjSeDKlBPRdq5VcYZX3pNf7jP7EMP/SMPUR1CtsMLQXik8jyPcMn
LG0aDxdkJoSRYC1sTL/B8WBhJRnPBaBF5JXHskCEpjgCMJnU/7P+KAWic09Ub8rt
Mkan0wGYn4eGlriIkcXq7UvvL6irzy0Ne6GfEOcxAxTBQUF0DbX76V4nHL1MCpf/
XQhxvEnFOUEq0rXpc7I3GVC7tXzEe5SlSSTfYeA3UTEtf8EkoOX9NmyR/4CKIF/c
0gefYIcUAkTb1ekV8kPCLuZw26svgHlBrWO/SF1ncUlf9RpHV22EsribCb+tD/LD
FtcxSBS+fnrBu6qyq+6ZaPLwFppoj3DzOoIGUN2Mn3y1ahhfE6LL9IIH/FQrO7aL
D64kOCAXV5NdF99R10uRP4tnC7OKkZc88EF3RQ0ASCN9dfqh55ziER2SXuwZBsNp
zA4Vqa/WyzPTuBIZaQDIhqsOqKQ1wvqjUkMRZrquqD94zTaCjl8PR6b6VO3KUW9G
WIfmuqj3ANPjSuZKW+OvumCbzg8qLj2syuW5+MkSzRaLhwVcc/X0YTw74aj/oXW6
KPXqjZn/U4LMPmXIkXTfaRBRLq25zCm4e3diQ5g7Mpi9h1ZUnK6wleoyQSKvftin
5pzpTJ9NhimyohnCowCr
=/ys/
-----END PGP SIGNATURE-----

--7JtmyEQckRKrnqj+--

--===============7790958259095699690==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============7790958259095699690==--
