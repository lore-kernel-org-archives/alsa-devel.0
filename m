From: "matthias.nyffenegger@bluewin.ch" <matthias.nyffenegger@bluewin.ch>
Subject: Re: [PATCH] alsa: Emagic Audiowerk8 low-level ALSA
 driver
Date: Tue, 14 Oct 2008 11:27:06 +0000 (GMT)
Message-ID: <29361787.280941223983626975.JavaMail.webmail@ps5zhb.bluewin.ch>
Reply-To: matthias.nyffenegger@bluewin.ch
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail11.bluewin.ch (mail11.bluewin.ch [195.186.18.61])
	by alsa0.perex.cz (Postfix) with ESMTP id 0A5ED103801
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Oct 2008 13:27:25 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

At 13.10.2008 12:32
tiwai@suse.de wrote:

Hi Takashi,

>[please stop top-posting]

Ok, sorry for that. 

>I don't care in which direction, whether to merge yours into aw2 or
>aw2 into yours.  I just want to have a reasonable merge of two
>works.
>
>Well, this is basically an option, and can be achieved later, too.
>So, could you post the patches to ML for further reviews?

Yes, I'll do that soon.

>But before submitting patches, I recommend you to run once
>scripts/checkpatch.pl (found in kernel tree) with your patches.
>You'll find lots of coding style issues even by such a simple tool.
>Then, check Documentation/CodingStyle and fix your codes again.
>
>And, please remove the debug trace stuff unless you really need it in
>future.  This decreases readability fairly much.

I guess you refer to the 0.1 sourceforge release -> I actually did that before submitting aw-alsa-patch-0.2.
Anyway, I'll post the patch again, this time in Mail body, following your recommendations.

Thank you for helping.

Regards,

Matthias
