From: anish <yesanishhere@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add maintainer for maxim codecs
Date: Mon, 23 Mar 2015 17:04:26 -0700
Message-ID: <CABCoZhD+pMPM3yazjh8R3s+8m1Sq7q3B81TBY0NKxJvgKBf4mw@mail.gmail.com>
References: <1425338170-30924-1-git-send-email-yesanishhere@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425338170-30924-1-git-send-email-yesanishhere@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, gregkh@linuxfoundation.org
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Anish Kumar <yesanishhere@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hello,

I was wondering if this patch is in any of the queue?

On Mon, Mar 2, 2015 at 3:16 PM, Anish Kumar <yesanishhere@gmail.com> wrote:
> This patch adds maintainer for maxim audio codecs.
> Signed-off-by: Anish Kumar <yesanishhere@gmail.com>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8bdd7a7..2128586 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7387,6 +7387,13 @@ S:       Supported
>  F:     sound/soc/
>  F:     include/sound/soc*
>
> +MAXIM INTEGRATED SOC CODEC DRIVER
> +M:     Anish Kumar <yesanishhere@gmail.com>
> +L:     alsa-devel@alsa-project.org (moderated for non-subscribers)
> +S:     Maintained
> +F:     sound/soc/codecs/max*
> +F:     include/sound/max*
> +
>  SPARC + UltraSPARC (sparc/sparc64)
>  M:     "David S. Miller" <davem@davemloft.net>
>  L:     sparclinux@vger.kernel.org
> --
> 1.9.3
>
