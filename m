From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: need help for PCM constraint/rules
Date: Wed, 27 Mar 2013 21:11:13 +0900
Message-ID: <5152E1E1.2010104@sakamocchi.jp>
References: <514F0696.1030109@sakamocchi.jp> <514F5010.5000707@ladisch.de>
 <5151D3B5.50301@sakamocchi.jp> <5151E7C9.4030904@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id B8B55265178
 for <alsa-devel@alsa-project.org>; Wed, 27 Mar 2013 13:11:19 +0100 (CET)
In-Reply-To: <5151E7C9.4030904@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

 > Takashi Sakamoto wrote:
 >> about your firewire-kernel-streaming branch in alsa-kprivate.git.
 >> There is no commit since last year and I'm anxious about the reason.
 >
 > Just lack of time.

That's OK :)

Currently I'm working for adding PCM capturing into snd-firewire-lib.ko. 
I plan to post some patches for amdtp.c and cmp.c. It's my glad that you 
give a little time for reviewing my patches.

Regards


Takashi Sakamoto
o-takashi@sakamocchi.jp

(Mar 27 2013 03:24), Clemens Ladisch wrote:
> Takashi Sakamoto wrote:
>> about your firewire-kernel-streaming branch in alsa-kprivate.git.
>> There is no commit since last year and I'm anxious about the reason.
>
> Just lack of time.
>
>
> Regards,
> Clemens
