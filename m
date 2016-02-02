From: Mark Brown <broonie@kernel.org>
Subject: Re: sound: use-after-free in snd_seq_deliver_single_event
Date: Tue, 2 Feb 2016 19:26:03 +0000
Message-ID: <20160202192603.GU4455@sirena.org.uk>
References: <CACT4Y+Zd66+w12fNN85-425cVQT=K23kWbhnCEcMB8s3us-Frw@mail.gmail.com>
 <20160201111625.GB4455@sirena.org.uk>
 <CACT4Y+YXXYWUGSZ5y=ZHPJXVAKXeEXLn8vjkpm+xx98yfo4dxw@mail.gmail.com>
 <20160201122018.GC4455@sirena.org.uk>
 <56AF5EDF.9030202@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0WGqsT62A4RTsSXf"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56AF5EDF.9030202@sakamocchi.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Dmitry Vyukov <dvyukov@google.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, LKML <linux-kernel@vger.kernel.org>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>, Alexander Potapenko <glider@google.com>, Sasha Levin <sasha.levin@oracle.com>
List-Id: alsa-devel@alsa-project.org


--0WGqsT62A4RTsSXf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 01, 2016 at 10:34:23PM +0900, Takashi Sakamoto wrote:

> Well, I don't mind to receive them because it's a good information for
> me to get current state of ALSA core functionality. If I had some
> spare time, I was also going to fix it. But currently I have little
> time for it due to my development for my minor hardwares...

Yeah, my concern is that I'm getting to the point where I mentally tag
them as irrelevant and delete them unread (the subject lines don't help
here).  I've had quite a few and none of them have been for code I even
recall working on.

--0WGqsT62A4RTsSXf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWsQLKAAoJECTWi3JdVIfQ79sH/jtL0WAycs4pjtMvxcwMbwf+
1edVgvWQg47k8FCE3cnZLUuADIF1W6tBuSJ/X9rP6UqPU3C6HYi3XT6sYVuf1vYN
ILMYIbTHDiAAJNLeoU/aoHr5vkBkrCc3UmTDxAOZiUSzg+PmffkWU1E/gbfKIkDI
QYczYOGERjr1pybPIWmRjnqZzRbSuuwgkbPgTYH7uEeypQRp4yz1fEF8WpEDaQQy
FSCT5zmtt8swrrd3QB+XC33qrws+KQ0rPI1f4+4WWkO6OpPp402ThDIi5ATzFnKL
CcO3MBQ8Cd6p2tjsFb3yLvE2rLhQrkpHR8usMjnR3342iwRQC45LH+s8kf+qOi0=
=5PAH
-----END PGP SIGNATURE-----

--0WGqsT62A4RTsSXf--
