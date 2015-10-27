From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Packages 1.0.30 - release pending
Date: Tue, 27 Oct 2015 17:01:42 +0100
Message-ID: <562F9FE6.5060704@perex.cz>
References: <561AB391.6030504@perex.cz> <s5hvbaca40c.wl-tiwai@suse.de>
 <s5hlhaomjem.wl-tiwai@suse.de> <1445959655.7199.12.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E54C260527
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2015 17:01:43 +0100 (CET)
In-Reply-To: <1445959655.7199.12.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Takashi Iwai <tiwai@suse.de>
Cc: Vinod Koul <vinod.koul@intel.com>, "Lin, Mengdong" <mengdong.lin@intel.com>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Dne 27.10.2015 v 16:27 Liam Girdwood napsal(a):
> On Tue, 2015-10-27 at 16:16 +0100, Takashi Iwai wrote:
>> On Mon, 12 Oct 2015 10:24:19 +0200,
>> Takashi Iwai wrote:
>>>
>>> On Sun, 11 Oct 2015 21:08:01 +0200,
>>> Jaroslav Kysela wrote:
>>>>
>>>> Hi all,
>>>>
>>>> 	I would like to release 1.0.30 version of all packages. Things to discuss:
>>>
>>> There are pending issues: one is about the topology ABI and this seems
>>> still in flux.  I suppose this will be stabilized in 4.4.  Also, the
>>> documentation for BAT is utterly missing, and I expect we'll get this
>>> soonish.  Liam, Mengdong, any comments on these?
>>
> 
> BAT (stage1) is now upstream including documentation. Caleb and Han are
> working on new BAT features and these should be part of the 1.0.31 alsa
> package release.

Thanks for the info. Yes, the man page is there. I'm just curious - what
features will be added? BTW: 1.0.31 should be 1,1.1 - no more 1.0.x
releases.
				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
