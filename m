From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm5102: Use put_unaligned_be16
Date: Mon, 29 Dec 2014 16:57:34 +0000
Message-ID: <20141229165734.GA17800@sirena.org.uk>
References: <20141226044457.GA12777@vaishali-Ideapad-Z570>
 <CAK-LDb+i8ATb5GrA6=dx5Y6EZSct+A6epXwNdEoVN4797Yzmqw@mail.gmail.com>
 <20141229155357.GL17800@sirena.org.uk>
 <CAK-LDb+KCWHz7A5im7cB=dQfCs8ioh2T+jsxk9PdAFHNSOuvzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2945932942284739187=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 07BFA2615DC
 for <alsa-devel@alsa-project.org>; Mon, 29 Dec 2014 17:57:47 +0100 (CET)
In-Reply-To: <CAK-LDb+KCWHz7A5im7cB=dQfCs8ioh2T+jsxk9PdAFHNSOuvzg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vaishali Thakkar <vthakkar1994@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2945932942284739187==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mtW7bbyDpSFHJrnL"
Content-Disposition: inline


--mtW7bbyDpSFHJrnL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 29, 2014 at 10:00:13PM +0530, Vaishali Thakkar wrote:
> On Mon, Dec 29, 2014 at 9:23 PM, Mark Brown <broonie@kernel.org> wrote:

> > You sent this on the 26th, two days later on the 28th you're demanding a
> > review and complaining that we've missed this with a top posted quote.
> > Even during a normal working period this would not be a reasnoable
> > demand (a couple of weeks is normally a good *lower* limit, people have
> > vacations and other things to do), and right now we're in the middle of
> > the time of year when people from western societies typically take
> > vacation.

> I am really very sorry for this. Actually I am a newbie. I mainly
> worked during opw-application period and there we used to work with
> staging directory only. This is my first time, I am working with other
> parts of kernel. So, I had kind of feeling that I might have done
> something wrong that's why I am not getting any comments. But I think
> its my fault. I may need to understand workflow of community properly
> and I apologizes for that.

Basically you should be allowing something measured in weeks to get a
response rather than days unless there's some ultra critical issue -
people might be busy, on vacation or whatever.  Different parts of the
kernel will have different working patterns and rules of thumb but in
general be patient, try to leave it for a few weeks before doing
anything unless you realise that there's some problem (eg, you forgot to
CC someone or you spot a mistake yourself in which case do a new version
fixing that mistake).  If it's just been a week or two people might just
be busy.

--mtW7bbyDpSFHJrnL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUoYf9AAoJECTWi3JdVIfQOj0H/3yC4RJ+LipmVvhG9Lg/asv8
6KKLwhSV/rhwRJ9uRPSOW8Y1rdLxHuu2ARmZ5a5QGbXHECons0bhuFDJ0eRp6y+1
+ESYkr3AGgemFYrfR3nNQh8/bGFkF34dBm8KojY7qhNg/rW6HKLjKwGAMlLANJhR
IQ+XpXKKyoxRQ8WYhbHdkwWTLK3rUdIC3jMUVxJdqqXe/g76YLy9MLh6cixd/ZLg
r8LBOEH4i1D9ESPMZhU1t4rPsmu/iC5T0adMJfUdKbLw90bQb0mZRBG7ChOstUYq
+XtylNCPGemCVJ1gHH5SHy7t+LHlGEUj6gx7VcwSmWRjL8YUD1RwLbGAz/Y95vg=
=Ey5L
-----END PGP SIGNATURE-----

--mtW7bbyDpSFHJrnL--

--===============2945932942284739187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2945932942284739187==--
