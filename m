From: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
Subject: Re: Speaker burnout
Date: Tue, 07 Apr 2015 19:49:37 +1200
Message-ID: <55238C11.5000404@blennerhassett.gen.nz>
References: <1427551386.3092172.246393281.691C33A7@webmail.messagingengine.com>	<5518F8F3.10304@ladisch.de>	<1427711234.231499.246955417.6E2E7C65@webmail.messagingengine.com>	<55192FBC.1070307@ladisch.de>	<1427726222.1872206.247049189.3E3BB0F7@webmail.messagingengine.com>	<551A6A15.1070605@canonical.com>	<1427796392.581386.247465613.43178C71@webmail.messagingengine.com>	<551A7A4D.203@canonical.com>	<55236B93.9070504@blennerhassett.gen.nz>	<5523828C.8060301@canonical.com>
 <5523868A.3020502@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from omr.mail.isx.net.nz (omr.mail.isx.net.nz [111.65.230.130])
 by alsa0.perex.cz (Postfix) with ESMTP id 1FFA826057D
 for <alsa-devel@alsa-project.org>; Tue,  7 Apr 2015 09:49:41 +0200 (CEST)
In-Reply-To: <5523868A.3020502@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, "Nikita N." <nikitan@operamail.com>
List-Id: alsa-devel@alsa-project.org

On 07/04/15 19:26, Clemens Ladisch wrote:

> In theory, it would be possible to do the mixing in the analog domain.
> But there is no way to find out what the HDA codec actually does except
> trying it out.


Dear testers, please perform the following steps:

1. Place laptop on heat-resistant surface in a well-ventilated space.
Have a fire extinguisher handy.  Put on your earmuffs.
2. Start stopwatch
3. Set all alsa volumes to maximum
3.1 If screaming noise not already evident, play this full-scale square wave
4.1 If smoke or flames appear from your laptop, stop stopwatch.
Extinguish any flames.
4.2 If 30 seconds elapsed without smoke, terminate the test.
5. Report back to us the results, if necessary borrow a friend's
computer to do so.

Hmmm, why isn't anyone volunteering to do this testing?

Seriously, How is the safe limit going to be determined?
