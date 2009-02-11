From: Holger Dehnhardt <dehnhardt@ahdehnhardt.de>
Subject: Re: MTP-AV Bugs
Date: Wed, 11 Feb 2009 22:08:42 +0100
Message-ID: <200902112208.42644.dehnhardt@ahdehnhardt.de>
References: <200902102154.32301.dehnhardt@ahdehnhardt.de>
	<200902111444.14051.dehnhardt@ahdehnhardt.de>
	<s5h1vu513oe.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ahdehnhardt.de (ahdehnhardt.de [88.80.200.198])
	by alsa0.perex.cz (Postfix) with ESMTP id 01BA61038C1
	for <alsa-devel@alsa-project.org>; Wed, 11 Feb 2009 22:13:15 +0100 (CET)
Received: from [88.73.132.142] (helo=musik.localnet)
	by ahdehnhardt.de with esmtpa (Exim 4.63)
	(envelope-from <dehnhardt@ahdehnhardt.de>) id 1LXMKg-0004Zv-3q
	for alsa-devel@alsa-project.org; Wed, 11 Feb 2009 22:13:22 +0100
In-Reply-To: <s5h1vu513oe.wl%tiwai@suse.de>
Content-Disposition: inline
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

Yes Takashi - your patch works - even if I had to apply the changes manually 
because patch always gave me errors and I was not willing to go deeper into it 
because of 2 lines of code. As stated before - I'm not used to this all ;-)

I did not have to do use the deprecated snd_card_new() method either... . Even 
MIDI out works as expected.
I'm sorry that I was stupid enough to overwrite my changes, so I can not 
comprehend what I've done before.
One last thing:
>
> Heh, you can teach your children driver programming :)
>
You would not wish that my 3 year old son is doing this stuff - hopefully even 
I am better than he;-)

So Takashi, thank you very much for your help! Have a nice evening - or 
whatever time is in your place!


Holger
