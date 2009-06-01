From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH] Support NVIDIA 8 channel HDMI audio
Date: Mon, 1 Jun 2009 07:07:30 +0200
Message-ID: <200906010707.30788.marek.vasut@gmail.com>
References: <15F501D1A78BD343BE8F4D8DB854566B058A63E9@hkemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f170.google.com (mail-fx0-f170.google.com
	[209.85.220.170])
	by alsa0.perex.cz (Postfix) with ESMTP id BF092244D1
	for <alsa-devel@alsa-project.org>;
	Mon,  1 Jun 2009 07:07:32 +0200 (CEST)
Received: by fxm18 with SMTP id 18so7734976fxm.32
	for <alsa-devel@alsa-project.org>; Sun, 31 May 2009 22:07:32 -0700 (PDT)
In-Reply-To: <15F501D1A78BD343BE8F4D8DB854566B058A63E9@hkemmail01.nvidia.com>
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
Cc: Wei Ni <wni@nvidia.com>, Takashi Iwai <tiwai@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>, Peer Chen <pchen@nvidia.com>, akpm <akpm@linux-foundation.org>, Pavel Hofman <pavel.hofman@insite.cz>
List-Id: alsa-devel@alsa-project.org

On Monday 01 of June 2009 04:51:16 Wei Ni wrote:
> Hi, Takashi
> I'm a Nvidia engineer, we wish to support 8 channel HDMI audio for
> MCP78/7A.
>
> I attached the patch file, it based on the latest sound git tree,
> please check it.
>

Hi,
can you please run scripts/checkpatch.pl on the patches you submit? I'd help a 
lot, thanks.

btw. here's the output (shortened):

total: 47 errors, 15 warnings, 349 lines checked

0001-Support-NVIDIA-8-channel-HDMI-audio.patch has style problems, please 
review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.

>  <<0001-Support-NVIDIA-8-channel-HDMI-audio.patch>>
>
> Thanks
> Wei.
>
> ---------------------------------------------------------------------------
>-------- This email message is for the sole use of the intended recipient(s)
> and may contain confidential information.  Any unauthorized review, use,
> disclosure or distribution is prohibited.  If you are not the intended
> recipient, please contact the sender by reply email and destroy all copies
> of the original message.
> ---------------------------------------------------------------------------
>--------
