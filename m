From: Andreas Berglund <andreas.berglund@home.se>
Subject: Re: support for IDT 92HD89E codec
Date: Sun, 28 Aug 2011 20:51:20 +0200
Message-ID: <4E5A8E28.9060107@home.se>
References: <4E527AA2.5060606@home.se> <s5hk4a4b2jv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch-smtp04.sth.basefarm.net (ch-smtp04.sth.basefarm.net
	[80.76.153.5]) by alsa0.perex.cz (Postfix) with ESMTP id 61835243D1
	for <alsa-devel@alsa-project.org>;
	Sun, 28 Aug 2011 20:53:44 +0200 (CEST)
Received: from c83-251-13-21.bredband.comhem.se ([83.251.13.21]:42918
	helo=[192.168.0.13])
	by ch-smtp04.sth.basefarm.net with esmtp (Exim 4.76)
	(envelope-from <andreas.berglund@home.se>) id 1QxkSg-0002eT-EV
	for alsa-devel@alsa-project.org; Sun, 28 Aug 2011 20:52:04 +0200
In-Reply-To: <s5hk4a4b2jv.wl%tiwai@suse.de>
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

On 2011-08-23 16:55, Takashi Iwai wrote:
> At Mon, 22 Aug 2011 17:49:54 +0200,
> Andreas Berglund wrote:
>>
>> Hi!
>> I have a sounccard with the IDT 92HD89E codec, or at least I thought so,
>> when I run the alsa-info script I get the IDT ID 76c7 returned as the
>> codec. However none of them seem to be supported by alsa, are there
>> plans to support these codecs in the future?
>>
>> I am running the latest version of debian stable and have version 1.0.21
>> of the driver and version 1.0.23 of the library and utilities running.
>
> It's been already supported since some time ago.
> Try more newer version of alsa-driver.

That's awesome :D Do you know which version I need?
>
>
> Takashi
>
