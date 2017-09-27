From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: dapm: Fix typos in comment
Date: Wed, 27 Sep 2017 16:39:23 +0200
Message-ID: <c14e9fe8-a98c-e875-84ad-fe6e9becb5ae@metafoo.de>
References: <1506522901-10552-1-git-send-email-dolinux.peng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C07A266E0C
 for <alsa-devel@alsa-project.org>; Wed, 27 Sep 2017 16:39:59 +0200 (CEST)
In-Reply-To: <1506522901-10552-1-git-send-email-dolinux.peng@gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peng Donglin <dolinux.peng@gmail.com>, broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 09/27/2017 04:35 PM, Peng Donglin wrote:
> Signed-off-by: Peng Donglin <dolinux.peng@gmail.com>
> ---
>  sound/soc/soc-dapm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index dcef67a..0867eaa 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -4167,7 +4167,7 @@ void snd_soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd, int stream,
>   * @dapm: DAPM context
>   * @pin: pin name
>   *
> - * Enables input/output pin and its parents or children widgets iff there is
> + * Enables input/output pin and its parents or children widgets if there is

https://en.wikipedia.org/wiki/If_and_only_if
