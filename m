From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: ALSA 1.0.21 release
Date: Mon, 31 Aug 2009 16:51:41 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0908311650590.21152@eeebox2.perex-int.cz>
References: <alpine.LNX.2.00.0908311614150.21152@eeebox2.perex-int.cz>
	<s5h4oro3v3x.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 3541D103813
	for <alsa-devel@alsa-project.org>;
	Mon, 31 Aug 2009 16:51:42 +0200 (CEST)
In-Reply-To: <s5h4oro3v3x.wl%tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 31 Aug 2009, Takashi Iwai wrote:

> At Mon, 31 Aug 2009 16:17:33 +0200 (CEST),
> Jaroslav Kysela wrote:
>>
>> Hello all,
>>
>>  	all ALSA packages except alsa-oss and alsa-firmware (no changes
>> from 1.0.20) are available for download at http://www.alsa-project.org .
>
> alsa-utils-1.0.21 seems missing.  Could you upload?

It will take several minutes. It seems that older ncurses does not have 
set_escdelay() function. Thanks for the notification.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
