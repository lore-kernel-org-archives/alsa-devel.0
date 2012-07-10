From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] ASoC: tlv320aic3x: add AGC settings
Date: Tue, 10 Jul 2012 09:57:17 +0100
Message-ID: <20120710085717.GB3918@opensource.wolfsonmicro.com>
References: <1341906070-4429-1-git-send-email-jiri.prchal@aksignal.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0580189367825188561=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A7F2A24976
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Jul 2012 11:06:25 +0200 (CEST)
In-Reply-To: <1341906070-4429-1-git-send-email-jiri.prchal@aksignal.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jiri Prchal <jiri.prchal@aksignal.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0580189367825188561==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Content-Disposition: inline


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 10, 2012 at 09:41:10AM +0200, Jiri Prchal wrote:
> This patch adds AGC target level and times settings for TLV320AIC3x.
> Enums uses small arrays of two channels left and right since it uses different registers.

Patches 1-3 don't seem to have been sent...

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP++5mAAoJEBus8iNuMP3dYDQQAJtziau3N/Ea+7BuSs81KRrU
I01XrvATkas3mgPIaUlLivNjv3i1Cqb5+kJ9QfloEpBuWPdKZ7pERy0v9NKJHw5F
CMNh++PTakqW2KK4hUhPNBVpJbMmlSTuYkDjZQ5g3XqE3V0e5M15TR5I3UEgS+z1
qkHXwAYmtqAH1pq8nqQjrwxWGeJkwvg3LxtDhK2n8KscbLrNIAw9bvN4SxwHyQRb
P6gP7BHpcEjnTQwae6AjhjscFX/E3db8PuuRXu//LrnKzikXiujAGM1Jh0qYJxFV
l5jONGiqXeprrxbGyx22PWGwKa3ph8dOc6pY1DTS4gw4n3DiScMoTUsY06ls4q/f
henhSNCXcDuw3IPEJVkHUT9Mdq3HCC/7H7uQL26COBQX5I5PqrIYh/Zwily1q8FZ
8Ei0wNaGOmpcj4jleNjyhMytVD+phOsU47yjWczDEHKIyhUfYzH/s7tem8m3v11z
LWrsm3xXo4GKZ7KtO6PDwm3X1tpgJWnwrW/ks+ksE+o5s2Z88nk6D/FVYTW3iUOe
JxD9k5fCl3zj0jKO4MRzN8/LA2fD/o59dYJ4/+Wmv4ZZWW/blHv/9+aPLuxpmQHo
l2MlVVQ/GmgFlSDnijqg+aJUhLPxAerhxbyABE7piV9NM0kK9JPDloghpx+VKJTt
gNrqx+cO9nXBxbi0QfRR
=RJtU
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--

--===============0580189367825188561==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0580189367825188561==--
