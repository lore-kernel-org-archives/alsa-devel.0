From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: ALSA userspace release time?
Date: Fri, 13 Jun 2014 08:30:04 +0200
Message-ID: <539A9A6C.6050108@canonical.com>
References: <538D6AC8.1010208@canonical.com> <538D7221.6010802@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D9C626167D
 for <alsa-devel@alsa-project.org>; Fri, 13 Jun 2014 08:30:04 +0200 (CEST)
In-Reply-To: <538D7221.6010802@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org



On 2014-06-03 08:58, Jaroslav Kysela wrote:
> Date 3.6.2014 08:27, David Henningsson wrote:
>> Hi,
>>
>> It was around a year since we last had a release of ALSA's userspace
>> component.
>>
>> Is it perhaps time for 1.0.28, or are we waiting for something that
>> would be nice to get in first?
>>
>> We've currently got e g speaker-test improvements/fixes, 2.1 surround
>> support, "alsactl monitor" command, and random fixes here and there.
>> Sounds good enough for a release to me.
>>
>
> Hi,
>
>    yes, I also think that's time to prepare the 1.0.28 release. I will
> start the work on it.

Thanks! Any progress?

>    If someone has any waiting fix, please, let me know ...

Alexander posted a few small fixes yesterday [1], which probably make 
sense to include after a quick review by yourself or Takashi.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic

[1] 
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-June/077652.html
