From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH V2 3/3] dt-bindings: bsm2835: fix bindings documentation to use new clock framework
Date: Thu, 28 Jan 2016 14:11:04 -0800
Message-ID: <87si1hfj7r.fsf@eliezer.anholt.net>
References: <1452602149-5875-1-git-send-email-kernel@martin.sperl.org> <1452602149-5875-4-git-send-email-kernel@martin.sperl.org> <20160112143601.GA29373@rob-hp-laptop> <2EC555E0-91B9-45AA-8804-848C445E052E@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2EC555E0-91B9-45AA-8804-848C445E052E-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org> writes:

>> On 12.01.2016, at 15:36, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>>=20
>> On Tue, Jan 12, 2016 at 12:35:48PM +0000, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
>>> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>>=20
>> Typo in the subject (bsm).
>>=20
>>>=20
>>> The bcm2835-i2s driver has been updated to use the new clock framework
>>> for the bcm2835 SOC.
>>>=20
>>> This patch documents the required changes to the bindings.
>>>=20
>>> Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>>=20
>> Please add acks when you post new versions.
>>=20
>
> You want it resent with the typo fixed and signed-off?

Generally, make sure you apply acks as you get them, so that they don't
get lost.  If you fix the subject and add Rob's ack, it's also:

Acked-by: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWqpH5AAoJELXWKTbR/J7oAJcP/icpRC9xZxRZO33Q4AVwvohL
XkUNU+BeuB46dGx4xQgjSgqKpOLpp1I3UlqrkZZNsWI9glr6BGu1r45tzWbpLOrQ
8hHmEGo1Mg7M4TMyvpuLCG6kBLqvj0m33DNEnvw6ufvhyK74QZrB5nZCYckmuAZw
59DbYnikJaH58iwTQLk/iJlz+p9avTtc75MLa6cOOBpkQJwZEzpyQvhKSwkj64ap
HtI3BKHuaAb9iQdn8wdjUFQm+elPFa+dwpGxiS80gYMVhhqHPd+TOhcJYQ7wYHGc
IYRRDr0VrSb8a660kC1TvuaVrWd1531mubkwdiIWZwCtEpQ02Tc0xTSodfOkGoke
vFQZfKAh6XTw53nR64Y2EvJDqBk3je0N5LwrcrSkbKJdB1xeIGO1TjKdrRDj8d8O
O+hrAloSPFO9o+jeho+PNDsnriEhn7aiRFvhgE2wjkiGqHtzwd8nYS2dLXAzEdAM
d7PESWYVM+cRaiN7wGyFKi37TBguvYhdqlkL0m6yh9VHiSl/JNgW1EHPsGklbept
a0JpBDYkwCIroLMJq+BVOJiZJjnZrt0ng2wH7wI9wM+nufWhdXzeF51o+e5iUPRY
Kj2r9mSMJilP3QcwpfyIIHBojqsKjF/l/cWUCzIGc+JWbe7fbq0OmNolVHuzzyk6
t8RHddHc7Z1oCXMqinaG
=Tqn6
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
