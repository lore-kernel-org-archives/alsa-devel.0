From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [alsa-devel] [PATCH 1/7] ASoC: neo1973_wm8753: Remove scenario
 management code.
Date: Thu, 14 Apr 2011 07:33:39 +0900
Message-ID: <01bc01cbfa2a$d82588a0$887099e0$%kim@samsung.com>
References: <1299481500-5481-1-git-send-email-lars@metafoo.de>
 <1299495878.3377.17.camel@odin>
 <20110307122520.GI13471@opensource.wolfsonmicro.com>
 <4DA4AFE6.8050007@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <4DA4AFE6.8050007@metafoo.de>
Content-language: ko
Sender: linux-kernel-owner@vger.kernel.org
To: 'Lars-Peter Clausen' <lars@metafoo.de>, 'Mark Brown' <broonie@opensource.wolfsonmicro.com>
Cc: 'Liam Girdwood' <lrg@slimlogic.co.uk>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, 'Jassi Brar' <jassi.brar@samsung.com>
List-Id: alsa-devel@alsa-project.org

Lars-Peter Clausen wrote:
> 
> On 03/07/2011 01:25 PM, Mark Brown wrote:
> > On Mon, Mar 07, 2011 at 11:04:38AM +0000, Liam Girdwood wrote:
> >
> >> Just had a quick look. All
> >
> >> Acked-by: Liam Girdwood <lrg@ti.com>
> >
> > Applied 1-6 - I'll wait for Kukjin to check patch 7 just in case he
> > wants it to go via his tree, there's no compile time dependency.
> 
Oops, maybe I missed. Because he didn't send to me, Linux ARM Kernel mailing
list or Linux Samsung SoC mailing list at that time.

> Thanks.
> 
> So far patch 7 (adding the dfbmcs320 platform device to gta02 mach file)
> hasn't
> been applied. Should I resent it, or do you still have it?
> 
Anyway, I checked Mark's applying just now. It's ok to me :)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
