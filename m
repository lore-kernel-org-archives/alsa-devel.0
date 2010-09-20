From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: [PATCH 0/3] alsa-lib: UCM - Use Case Manager
Date: Mon, 20 Sep 2010 17:26:30 +0100
Message-ID: <i781vn$nhb$1@dough.gmane.org>
References: <1282580239-10549-1-git-send-email-lrg@slimlogic.co.uk>	<alpine.LNX.2.00.1008231907170.10278@eeebox2.perex-int.cz>	<1282640988.3053.43.camel@odin>	<alpine.LNX.2.00.1008250925540.10278@eeebox2.perex-int.cz>	<1282728400.2991.114.camel@odin>
	<alpine.LNX.2.00.1008251128140.10278@eeebox2.perex-int.cz>	<1282732983.2991.161.camel@odin>	<alpine.LNX.2.00.1008251831330.10278@eeebox2.perex-int.cz>	<1283864698.3048.26.camel@odin>
	<alpine.LNX.2.00.1009071618230.10278@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 1EA25244B3
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Sep 2010 18:26:42 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1OxjCT-0004eq-Cn
	for alsa-devel@alsa-project.org; Mon, 20 Sep 2010 18:26:41 +0200
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 20 Sep 2010 18:26:41 +0200
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 20 Sep 2010 18:26:41 +0200
In-Reply-To: <alpine.LNX.2.00.1009071618230.10278@eeebox2.perex-int.cz>
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

Hi Jaroslav,

'Twas brillig, and Jaroslav Kysela at 07/09/10 15:42 did gyre and gimble:
> On Tue, 7 Sep 2010, Liam Girdwood wrote:
> 
>> Hi Jaroslav,
>>
>> Any update on this ? I have someone scheduled to write new use case
>> files and someone else ready to add PA support.
> 
> Hi,
> 
> I'm working on this. Unfortunately, I have other things which interrupts 
> this work. The actual code is at:
> 
> http://git.alsa-project.org/?p=alsa-lib.git;a=shortlog;h=ucm

Has there been any progress on the UCM stuff? I'm quite interested to
see how this will develop from a PA perspective. It does have some
impact on work that I've been wanting to do for a while in PA so the
sooner this is available in ALSA the sooner I can start thinking about
some of the knock on effects. I know Liam is intending to do some work
on PA too to integrate UCM once the API has stabilised, so I'm obviously
keen to encourage that too :D

Cheers

Col



-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
  Mageia Contributor [http://www.mageia.org/]
  PulseAudio Hacker [http://www.pulseaudio.org/]
  Trac Hacker [http://trac.edgewall.org/]
