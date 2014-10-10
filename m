From: Nick Stoughton <nstoughton@aether.com>
Subject: Re: proposal: snd_pcm_start_at()
Date: Fri, 10 Oct 2014 12:50:17 -0700
Message-ID: <CADO7NSFbR0i_DHr5rBnNHvs2DzwUpOfpOuN9fokptkCiewEpvA@mail.gmail.com>
References: <1412260460.3891605.174362449.667FB9BE@webmail.messagingengine.com>
 <542D8E3F.4080400@linux.intel.com> <542E8FE4.4080904@eml.cc>
 <542F2216.7050801@linux.intel.com> <s5h61fxzg2y.wl-tiwai@suse.de>
 <20141008141832.GZ4609@sirena.org.uk>
 <s5hwq8atw95.wl-tiwai@suse.de> <543561A0.8020701@eml.cc>
 <20141008201644.GM4609@sirena.org.uk> <54365342.5010906@eml.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f44.google.com (mail-la0-f44.google.com
 [209.85.215.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 019D52605FF
 for <alsa-devel@alsa-project.org>; Fri, 10 Oct 2014 21:50:17 +0200 (CEST)
Received: by mail-la0-f44.google.com with SMTP id hs14so3876979lab.31
 for <alsa-devel@alsa-project.org>; Fri, 10 Oct 2014 12:50:17 -0700 (PDT)
In-Reply-To: <54365342.5010906@eml.cc>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tim Cussins <timcussins@eml.cc>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Interestingly, I implemented this exact function (snd_pcm_start_at) about a
week ago before I saw this thread! We are still experimenting with it, but
I'd be happy to discuss it next week at the summit.

*______________________________*
*Nick Stoughton*
 *Aether Things Inc *
 *San Francisco*
  +1 (510) 388 1413


On Thu, Oct 9, 2014 at 2:20 AM, Tim Cussins <timcussins@eml.cc> wrote:

> On 08/10/14 21:16, Mark Brown wrote:
>
>> On Wed, Oct 08, 2014 at 05:09:04PM +0100, Tim Cussins wrote:
>>
>>> On 08/10/14 16:29, Takashi Iwai wrote:
>>>
>>
>>  OK, I added it to the topic list of audio mini-summit.
>>>> Let's see whether we can talk something about this.
>>>>
>>>
>>  2) Come over on Tuesday and join the mini summit
>>>
>>
>> This would be great, but please note that since the Linux Foundation are
>> doing the logistics (room and so on) for us you'd need to register for
>> one of the conferences that week.
>>
>>
> Righto. Registration has closed (all full I guess!) - I'll see if I can
> find a (legitimate) way in :)
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
