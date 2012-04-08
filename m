From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH][Trivial] sound/pci/riptide/riptide.c: remove trailing
 whitespace
Date: Sun, 08 Apr 2012 15:39:14 -0700
Message-ID: <1333924754.2508.11.camel@joe2Laptop>
References: <alpine.LNX.2.00.1204090024570.11747@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1204090024570.11747@swampdragon.chaosbits.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Jesper Juhl <jj@chaosbits.net>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, trivial@kernel.org, Peter Gruber <nokos@gmx.net>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2012-04-09 at 00:27 +0200, Jesper Juhl wrote:
> There's a bunch of trailing whitespace at the top of the
> sound/pci/riptide/riptide.c file - this patch gets rid of it.
[]
> diff --git a/sound/pci/riptide/riptide.c b/sound/pci/riptide/riptide.c
[]
> @@ -21,29 +21,29 @@
>  /*
>    History:
>     - 02/15/2004 first release
> -   
> +
>    This Driver is based on the OSS Driver version from Linuxant (riptide-0.6lnxtbeta03111100)
>    credits from the original files:

Might as well delete the whole block.
