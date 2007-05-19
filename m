From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH] remove email addresses from MODULE_AUTHOR
 tag
Date: Sat, 19 May 2007 03:38:07 +0200
Message-ID: <464E54FF.7080207@gmail.com>
References: <4643C20C.8050105@gmail.com> <s5hd517ich2.wl%tiwai@suse.de>
	<4644DC5A.7060905@gmail.com> <4645F2F4.2010807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl
	[213.51.146.201])
	by alsa0.perex.cz (Postfix) with ESMTP id A888724447
	for <alsa-devel@alsa-project.org>;
	Sat, 19 May 2007 03:41:47 +0200 (CEST)
In-Reply-To: <4645F2F4.2010807@gmail.com>
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
Cc: ALSA devel <alsa-devel@alsa-project.org>, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

On 05/12/2007 07:01 PM, Rene Herman wrote:

> On 05/11/2007 11:12 PM, Rene Herman wrote:
> 
>> I seem unlikely to convince him but I believe it's upto specific 
>> subsystems whether or not they'll take patches removing the email 
>> adresses from the tag, ie, in the case of ALSA upto you and Jaroslav.
> 
> For what it's worth, Linus merged the patch removing the advice to 
> include an email address in the MODULE_AUTHOR comment:
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=108f39a1b3b1e4b28ca8cc156f06171445499d21 
> 
> 
> He was aware of Alan's objection. Removing existing ones is ofcourse not 
> quite the same as not introducing new ones though so ofcourse still up 
> to you. I'm still signing off on it...

Takashi, Jaroslav, could you get me an ACK or NAK on this? I'm waiting 
around before submitting more to see if you'll take 'em.

Rene.
