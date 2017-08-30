From: Ian W MORRISON <ianwmorrison@gmail.com>
Subject: Re: [PATCH v2] ASoC: rt5645: Add jack detection
 workaround for MINIX Z83-4 based devices
Date: Thu, 31 Aug 2017 07:16:10 +1000
Message-ID: <CAFXWsS_GL+xGPZc-ySjRqEejp=GPU9qkE80zaCZge63QiwnQkw@mail.gmail.com>
References: <29ad0cbd-b58d-70e3-0647-a2d633b7e57e@gmail.com>
 <20170830211217.5s3ubddjrpngkbb7@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f67.google.com (mail-pg0-f67.google.com [74.125.83.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B894267217
 for <alsa-devel@alsa-project.org>; Wed, 30 Aug 2017 23:16:12 +0200 (CEST)
Received: by mail-pg0-f67.google.com with SMTP id t193so5882459pgc.4
 for <alsa-devel@alsa-project.org>; Wed, 30 Aug 2017 14:16:11 -0700 (PDT)
In-Reply-To: <20170830211217.5s3ubddjrpngkbb7@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 31 August 2017 at 07:12, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Aug 31, 2017 at 07:04:31AM +1000, Ian W MORRISON wrote:
>
>> v2: Applied and tested again sound -b for-next and linux-next -b master
>
> You're submitting this to me, it needs to apply to *my* tree:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git

Yes, v2 is now applied and tested against your
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git using
branch for-next. Is that correct or should I use a different branch?
