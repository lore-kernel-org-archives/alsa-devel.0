From: Udo van den Heuvel <udovdh@xs4all.nl>
Subject: Re: Emvy24control s/pidf input issue
Date: Mon, 17 Mar 2008 18:12:28 +0100
Message-ID: <47DEA67C.902@xs4all.nl>
References: <47DE9D12.9030900@xs4all.nl>	<47DE9FEA.3020509@xs4all.nl>
	<s5hve3lwamt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-vbr6.xs4all.nl (smtp-vbr6.xs4all.nl [194.109.24.26])
	by alsa0.perex.cz (Postfix) with ESMTP id C349310387C
	for <alsa-devel@alsa-project.org>; Mon, 17 Mar 2008 18:12:29 +0100 (CET)
Received: from surfplank2.hierzo (pindarots.xs4all.nl [82.92.197.115])
	(authenticated bits=0)
	by smtp-vbr6.xs4all.nl (8.13.8/8.13.8) with ESMTP id m2HHCTYV036359
	for <alsa-devel@alsa-project.org>; Mon, 17 Mar 2008 18:12:29 +0100 (CET)
	(envelope-from udovdh@xs4all.nl)
In-Reply-To: <s5hve3lwamt.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
>>> Unable to read S/PDIF input switch: No such file or directory
>> I still get the message now, but using envy24control 0.6.0 from
>> alsa-tools 1.0.16 I do get meters.
>>
>> Any ideas about the messages I see?
> 
> You can ignore 'Unable to read S/PDIF input switch' messages.  It's an
> unimplemented (non-existing) feature for Audiophile 2496.

Ah, OK.
Thanks for the quick reply.
With some asound.conf magic I appear to get some audio into the machine now.
I wil lcheck this out!
