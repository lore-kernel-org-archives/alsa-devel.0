From: Rolf Meeser <rolfm_9dq@yahoo.de>
Subject: Re: [PATCH] snd-usb-audio with multiple audio functions
Date: Mon, 06 Jun 2011 17:17:14 +0200
Message-ID: <4DECEF7A.80909@yahoo.de>
References: <4DEC787C.3050805@yahoo.de>	<BANLkTi=pZYO4SEhYxmfh9-vAucFumeQ=JQ@mail.gmail.com>
	<s5hipsj1g59.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm16.bullet.mail.bf1.yahoo.com (nm16.bullet.mail.bf1.yahoo.com
	[98.139.212.175]) by alsa0.perex.cz (Postfix) with SMTP id 5BA4224509
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jun 2011 17:17:18 +0200 (CEST)
In-Reply-To: <s5hipsj1g59.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

On 06/06/2011 11:08 AM, Takashi Iwai wrote:
>> The patch itself looks reasonable to be, and I doubt it would break
>> any existing functions.
> Yeah, I think so, too.
>
I have to disagree :-)
Even worse, I think it is almost nonsense.

Let me figure out another solution which will have to take Clemens' 
concerns into account.

>> However, please have a look at Documentation/SubmittingPatches. In
>> particular, you need to have a comprehensive commit log (which can be
>> taken from your explanations in this email) and your "Signed-off-by:"
>> line above the actual patch. Would you care to resend?
> FYI, about sign-off (and in general about the kernel patches), refer
> to $LINUX/Documentation/SubmittingPatches document.
>
I'll submit a clean patch next time!

Regards,
Rolf
