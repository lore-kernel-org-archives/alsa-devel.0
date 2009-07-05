From: Duke Grable <kejento@gmail.com>
Subject: Re: Testers wanted: New SB X-Fi driver
Date: Sun, 5 Jul 2009 12:10:55 -0700
Message-ID: <4812c8250907051210m3102e07evf96bb36e6752fde4@mail.gmail.com>
References: <4812c8250907050138w586919d4vd23d71b4ae14e1dc@mail.gmail.com>
	<4A50977E.6000602@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.146])
	by alsa0.perex.cz (Postfix) with ESMTP id 1E8581037F2
	for <Alsa-devel@alsa-project.org>;
	Sun,  5 Jul 2009 21:11:15 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 5so1615086qwf.56
	for <Alsa-devel@alsa-project.org>; Sun, 05 Jul 2009 12:11:15 -0700 (PDT)
In-Reply-To: <4A50977E.6000602@googlemail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

It seems like my problem was even stranger than that. For some reason the
only mute option for it under kmix or pulseaudio are through their taskbar
icons. If I remember correctly, I set my mic as master then unmuted it
through the one of icon's menu. That made it possible to hear my mic through
my speaker. Then a program called "gamix" solved my recording issues. Pretty
interesting. Loving these drivers either way though.

Thanks,
Duke

On Sun, Jul 5, 2009 at 5:07 AM, Gernot Kohlhaas <
gernot.kohlhaas@googlemail.com> wrote:

> Hi!
> Try to unmute the "Line-In" Playback-device.
>
> Duke Grable schrieb:
> > Hello!
> >
> > I stumbled upon these X-Fi drivers recently and ended up giving them a
> try.
> > So far they work flawlessly, except for microphone input... I'm wondering
> if
> > this is either just unimplemented, or if it's just an issue of
> > configuration? My sound card is an "X-Fi XtremeGamer" and my distro is
> the
> > latest version of openSuSe (2.6.27.23-0.1-default
> > ). Let me know if I'm missing anything!
> >
> > Thanks,
> > Duke
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >
>
>
> --
> http://www.gnupp.de/verschluesselung/warum.html
> Key ID: 0x4C0B2250
> Key: http://home.arcor.de/mr_maniac/ANDERES/public.gpg
>
