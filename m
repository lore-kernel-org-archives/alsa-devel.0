From: Giorgio Padrin <giorgio@mandarinlogiq.org>
Subject: Re: Audio support for codec Philips UDA1380
Date: Sat, 12 Nov 2005 17:11:56 +0100
Message-ID: <200511121711.57270.giorgio@mandarinlogiq.org>
References: <200511041201.01260.giorgio@mandarinlogiq.org> <17268.30963.131027.711505@ipc1.karo>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <17268.30963.131027.711505@ipc1.karo>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lothar Wassmann <LW@KARO-electronics.de>
Cc: alsa-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

Hi Lothar,

Thanks very much for your contribution.

=46or clearness, I'd have prefered your email splitted for the two independ=
ent=20
threads and codes, PXA2xx i2Sound and UDA1380.

Alle 11:56, venerd=C3=AC 11 novembre 2005, Lothar Wassmann ha scritto:
> > Download from: "http://www.mandarinlogiq.org/PXA2xx i2Sound/"
> This URL is broken and needs to be fixed. :)
> s/ /%20/
=2E.. In case your app refuses to do it for you :)

> > Clean write for ALSA and kernel 2.6 with full power optimizations at
> > subchip level, enabling hw blocks on need. Looking around in the kernel,
> > this seems to be a novelty among sound drivers, that run commonly in an
> > all-always-powered-up manner.
>
> Is there any reason why you didn't use the pxa2xx-pcm code
> (sound/arm/pxa2xx-pcm.c) which is already working perfectly with AC97
> and can be used for I2S without any change.

=46or clearness: You cited lines from this tread, then speaking of the othe=
r.
Now answering: A matter of PXA2xx i2Sound's evolutive history, as now.=20

Giorgio



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
