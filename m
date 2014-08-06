From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ASoC: fsl_sai: Add asynchronous mode support
Date: Wed, 6 Aug 2014 21:12:36 +0100
Message-ID: <20140806201236.GO17528@sirena.org.uk>
References: <1407223925-29678-1-git-send-email-nicoleotsuka@gmail.com>
 <53E0B926.9010103@gmail.com>
 <20140805110735.GA16503@MrMyself>
 <53E0BC95.7040208@gmail.com>
 <20140806024236.GA17879@MrMyself>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZWXtK32sF+lMTTLi"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140806024236.GA17879@MrMyself>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolin Chen <Guangyu.Chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Varka Bhadram <varkabhadram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, timur-N01EOCouUvQ@public.gmane.org, Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, b42378-KZfg59tc24xl57MIdRCFDg@public.gmane.org, b02247-KZfg59tc24xl57MIdRCFDg@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--ZWXtK32sF+lMTTLi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 06, 2014 at 10:42:37AM +0800, Nicolin Chen wrote:
> On Tue, Aug 05, 2014 at 04:44:29PM +0530, Varka Bhadram wrote:

> > Reading comfortably is important for us...  :-)
> > see this:http://lxr.free-electrons.com/source/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt#L46

> I know how to write a binding doc with indentations to make it clear.

> What I'm talking about is that the doc was created without indentations,
> so I don't feel comfortable to add indentations starting from this patch
> while leaving the old lines in totally a different style because It's not
> helpful to make people read comfortably at all but only forcing people to
> think why these two lines are so special to take some steps back here.

> So personally I agree with your idea to make doc more readable. But what
> I prefer to do is not having a conversation on the style within this patch
> but to create an extra style-refinement patch later after this one.

This is the right approach.

--ZWXtK32sF+lMTTLi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT4owxAAoJELSic+t+oim9KcIQAICotBQolgWw5UxLxsPdDXn6
0FWS1aFBrD5ihL5ddLrznh/gHaCclN1FQWggU/LjmDjfXr4tddRSUP0NYgTo8HBJ
fCKLmrXe/sfbMxl7W8sz7DuXLvy8qO7Q5KYjX4B8HKAu23m/trwcux25vkOpi5dP
T7sHjU0pyw6zm+62Knv/IvUiPMePRjS4OkAPo5F+vYWG5rtHsGnjPdcIV+SnBxPj
n17q7guf54qL4Or8bbT0G5Tmhiuz1m6ji/dObt8e7OSvd/83O4oreMg5uJ0umLWT
Ylrg7InGH2m8rCF6EQs9GoEQVttfI00uE5TQPxweO+WssyhrAigTunslnuUBVzhE
EJzNzABbawTE8oxlynWyFMJJWSoNSBHwUgXSqdPqq5FdB5ueZu6FIELQU/8AD4He
mAWAlehGQj8Sm1ppHKjw8eRWh2il8CDjk8vrFzxTAvkPrht+f2LwkbGMPGEA7TIU
t85u2rxwGQ6UdZNriA+JawhCnKDVBWXQvTkPosrsjW+Z/FIYbYy7fugfyF7P6H2x
w1kqX3LqPywO+A4KaHMQyMYJ/pgDsHuxj6irMGzSC5jVe4CPOqGGUp4y+i8QNGYc
/JwWxZdWITPD12gJRF+r1ZceNcu/BYEcviUHx7EPzz5iPm6iYtFchA1On4Ih88yL
gudDN8hYeYPjVgDCWaQG
=FNp5
-----END PGP SIGNATURE-----

--ZWXtK32sF+lMTTLi--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
