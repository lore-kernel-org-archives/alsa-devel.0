From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [PATCH] ASoC: au1x: convert to platform drivers.
Date: Mon, 2 Nov 2009 12:39:11 +0100
Message-ID: <f861ec6f0911020339x3816f6c0oe8ec935800f9f56a@mail.gmail.com>
References: <1257016508-13195-1-git-send-email-manuel.lauss@gmail.com>
	<20091102113247.GE29351@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f217.google.com (mail-bw0-f217.google.com
	[209.85.218.217])
	by alsa0.perex.cz (Postfix) with ESMTP id 0DF05103823
	for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2009 12:39:13 +0100 (CET)
Received: by bwz9 with SMTP id 9so19867025bwz.32
	for <alsa-devel@alsa-project.org>; Mon, 02 Nov 2009 03:39:12 -0800 (PST)
In-Reply-To: <20091102113247.GE29351@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Manuel Lauss <manuel.lauss@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 2, 2009 at 12:32 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Sat, Oct 31, 2009 at 08:15:08PM +0100, Manuel Lauss wrote:
>> Convert psc-ac97,i2s to platform drivers similar to the davinci ones.
>>
>> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
>
> Applied, thanks. =A0Please remember to CC maintainers on patch submissions
> - sometimes things get missed if they're only on mailing lists.

Great, thanks.  I'll add you to all other asoc related patches in the futur=
e.
Off-topic: I'm not really up-to-date on ASoC; how is multi-device support
coming along?  I received a new system which has 2 independet audio
systems, one with AC97 WM9715 + touchscreen, the other I2S.  Some day
I'd like to support the touch interface and I2S at the same time ;-)

Thanks!
     Manuel Lauss
