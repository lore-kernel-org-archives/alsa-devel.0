From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: [PATCH 0/5] Even more hdspmixer fixes
Date: Tue, 01 Mar 2011 13:56:09 +0100
Message-ID: <4D6CECE9.4040706@drcomp.erfurt.thur.de>
References: <1298972547-8759-1-git-send-email-adi@drcomp.erfurt.thur.de>
	<s5hzkpfm269.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [85.14.220.160])
	by alsa0.perex.cz (Postfix) with ESMTP id 7AD8310380A
	for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2011 13:56:15 +0100 (CET)
In-Reply-To: <s5hzkpfm269.wl%tiwai@suse.de>
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

On 03/01/11 13:54, Takashi Iwai wrote:

>> Thanks to Craig Bourne for immediate testing, also tested and confirmed
>> to be working on RayDAT, Multiface and AES32.
> The first three patches have been already applied in alsa-tools git
> tree so I applied newly the latter two.  For further works, please
> update your git tree first.

Mea culpa, I just forgot that I've sent them yesterday. Unconditionally
rebasing indeed seems to be the reasonable cure. ;)


Thanks
