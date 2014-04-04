From: RongJun Ying <rjying@gmail.com>
Subject: Re: [PATCH] ASoC: sirf: Move the tx rx enable from
 port to codec, that will not need register sharing
Date: Fri, 4 Apr 2014 17:49:22 +0800
Message-ID: <CAByv0RNAG9daCBd0dVZKxJ=U34_OMBiyp5X784crwS+EthYjfA@mail.gmail.com>
References: <1395301579-2960-1-git-send-email-rongjun.ying@csr.com>
 <20140321192002.GS552@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f52.google.com (mail-qg0-f52.google.com
 [209.85.192.52])
 by alsa0.perex.cz (Postfix) with ESMTP id E37042657A2
 for <alsa-devel@alsa-project.org>; Fri,  4 Apr 2014 11:49:22 +0200 (CEST)
Received: by mail-qg0-f52.google.com with SMTP id q107so3022763qgd.25
 for <alsa-devel@alsa-project.org>; Fri, 04 Apr 2014 02:49:22 -0700 (PDT)
In-Reply-To: <20140321192002.GS552@sirena.org.uk>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Rongjun Ying <rongjun.ying@csr.com>
List-Id: alsa-devel@alsa-project.org

2014-03-22 3:20 GMT+08:00 Mark Brown <broonie@kernel.org>:
> On Thu, Mar 20, 2014 at 03:46:19PM +0800, RongJun Ying wrote:
>> From: Rongjun Ying <rongjun.ying@csr.com>
>>
>> The port driver only used to register component and dmaengine pcm.
>
> Applied, thanks.

Hi Mark:
You have applied this patch.
But you have not merge it into next branch.
Please check it.
Thanks.
----
RongJun Ying

-- 
------------------------------
Rongjun Ying
