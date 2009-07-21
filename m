From: Frank Roth <frashman@freenet.de>
Subject: Re: Testers wanted: New SB X-Fi driver
Date: Tue, 21 Jul 2009 18:51:12 +0200
Message-ID: <4A65F200.8040200@freenet.de>
References: <4A5DB59B.2010407@freenet.de>	<s5hvdltnfrp.wl%tiwai@suse.de>	<4A659DE2.40400@freenet.de>
	<s5h3a8q47d0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout0.freenet.de (mout0.freenet.de [195.4.92.90])
	by alsa0.perex.cz (Postfix) with ESMTP id 59A8410383E
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Jul 2009 18:51:14 +0200 (CEST)
In-Reply-To: <s5h3a8q47d0.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ok thanks.

So you still didn't have specifications from Creative?
Because I red some time ago, creative gave the specs to the opensource community?
How is it possible to write this drivers then? Only reengineering from their opensource drivers?
Impressive!!

So I understand it right, everything is more or less software based right now?
We must change this ... (I would help you out, so far I can)


But thanks again for your work,
I have clear sound to here some music on linux, a first step.

Frank

Takashi Iwai schrieb:
> At Tue, 21 Jul 2009 12:52:18 +0200,
> Frank Roth wrote:
>> I play around with my X-Fi now,
>> I'm wondering if there is a way to support this Headphones/4/5.1/7.1 up-/downmix modes from Windows.
>> Stereo/Surround ...
>>
>> And in what I'm much more interested is,
>> Bass-Redirection ... because I use a Teufel - Concept E Magnum 5.1 speaker system.
>> It's connected via analogue 5.1 cables. And by default, nothing is coming out of LFE if play usual stereo music.
>> There is also an option in the windows drivers.
>>
>>
>> I found out, i could configure .asoundrc to do this, but is this the usual way?
> 
> Unless any information about the DSP programming on emu20kx is opened,
> there is no way to implement in the driver side.
> 
> 
> Takashi
