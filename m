From: Zoilo Gomez <zoilo@xs4all.nl>
Subject: Re: When turning up the volume,
 the sound dies and I'm forced to reboot...
Date: Fri, 02 May 2008 00:10:04 +0200
Message-ID: <481A3FBC.8040303@xs4all.nl>
References: <481A3C45.7070307@summitmediagroupllc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-vbr2.xs4all.nl (smtp-vbr2.xs4all.nl [194.109.24.22])
	by alsa0.perex.cz (Postfix) with ESMTP id 8321B2493C
	for <alsa-devel@alsa-project.org>;
	Fri,  2 May 2008 00:10:11 +0200 (CEST)
In-Reply-To: <481A3C45.7070307@summitmediagroupllc.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sean Thayne <sthayne@summitmediagroupllc.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Sean,

Sounds like your problem is identical to the one that we have been 
currently discussing in another thread this week; check the archives for 
a temporary fix at: 
http://mailman.alsa-project.org/pipermail/alsa-devel/2008-April/007572.html.

I think that a proper patch can be made available soon.

Regards,

Z.


Sean Thayne wrote:
> Hi All,
>
>     I've got a via8237 audio card, and I'm using the latest alsa driver 
> via82xx, and I got a problem. Basically if I start playing say a music 
> file, and then turn the volume up above 75%, My sound craps out and I 
> get a muffled, very low volume version of the song, the only way I've 
> found to fix this is to reboot. This also happens randomly at low 
> volume. I thought it might be a hardware issue, but I've tried it on 3 
> other boxes with the same card.
>
> Thanks for any input at all...
>   
